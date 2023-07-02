#!/bin/bash

# Check if docker is installed
if ! command -v docker &> /dev/null; then
    echo "Docker is not installed. Installing Docker..."
    # Install Docker
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo usermod -aG docker $USER
    rm get-docker.sh
    echo "Docker installed successfully."
fi

# Check if docker-compose is installed
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose is not installed. Installing Docker Compose..."
    # Install Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    echo "Docker Compose installed successfully."
fi

# Function to create WordPress site using Docker Compose
create_wordpress_site() {
    site_name=$1
    echo "Creating WordPress site: $site_name"

    # Create a docker-compose.yml file
    cat << EOF > docker-compose.yml
version: '3'

services:
  db:
    image: mysql:5.7
    volumes:
      - db_data:/var/lib/mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root_password
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress_password

  wordpress:
    depends_on:
      - db
    image: wordpress:latest
    ports:
      - 80:80
    volumes:
      - ./wp-content:/var/www/html/wp-content
    restart: always
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress_password
      WORDPRESS_DB_NAME: wordpress
EOF

    # Create the site directory
    mkdir -p wp-content

    # Start the containers
    docker-compose up -d

    # Add /etc/hosts entry
    echo "127.0.0.1 $site_name" | sudo tee -a /etc/hosts

    # Open the site in the browser
    echo "WordPress site created successfully. Opening $site_name in the browser..."
}

# Function to enable/disable the site
toggle_site() {
    site_name=$1
    echo "Toggling WordPress site: $site_name"

    # Check if containers are running
    if docker-compose ps | grep -q "wordpress"; then
        echo "Stopping containers for $site_name..."
        docker-compose stop
    else
        echo "Starting containers for $site_name..."
        docker-compose start
    fi
}

# Function to delete the site
delete_site() {
    site_name=$1
    echo "Deleting WordPress site: $site_name"

    # Stop and remove the containers
    docker-compose down

    # Remove the site directory
    rm -rf wp-content

    # Remove /etc/hosts entry
    sudo sed -i "/$site_name/d" /etc/hosts

    echo "WordPress site deleted successfully."
}

# Check the command-line arguments
if [ "$#" -lt 2 ]; then
    echo "Usage: $0 create <site_name>"
    echo "       $0 toggle <site_name>"
    echo "       $0 delete <site_name>"
    exit 1
fi

command=$1
site_name=$2

case $command in
    create)
        create_wordpress_site $site_name
        ;;
    toggle)
        toggle_site $site_name
        ;;
    delete)
        delete_site $site_name
        ;;
    *)
        echo "Invalid command: $command"
        exit 1
        ;;
esac