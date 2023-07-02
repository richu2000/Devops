# rtCamp
assignment 
# WordPress Site Management Script

This Bash script allows you to easily manage WordPress sites using Docker and Docker Compose. It provides a convenient command-line interface to create, toggle, and delete WordPress sites running in containers. The script sets up a LEMP stack (Linux, Nginx, MySQL, and PHP) and automates common site management tasks.

## Prerequisites

Before using this script, ensure that you have the following dependencies installed on your system:

- Docker: Visit [Docker's official website](https://www.docker.com/get-started) for installation instructions.
- Docker Compose: Follow the [official Docker Compose installation guide](https://docs.docker.com/compose/install/) for your platform.

## Usage

To use the script, follow these steps:

1. Download or clone this repository to your local machine.

2. Open a terminal and navigate to the directory where you saved the script.

3. Make the script executable by running the following command:

    bash
    chmod +x rt.sh
    

4. Run the script with one of the following commands:

    - *Create a WordPress site:*  
      bash
      ./rt.sh create <site_name>
      
      Replace `<site_name>` with the desired name for your WordPress site.

    - *Toggle (start/stop) a WordPress site:*  
      bash
      ./wordpress.sh toggle <site_name>
      
      Replace `<site_name>` with the name of the WordPress site you want to toggle.

    - *Delete a WordPress site:*  
      bash
      ./rt.sh delete <site_name>
      
      Replace `<site_name>` with the name of the WordPress site you want to delete.

5. Follow the on-screen instructions and prompts provided by the script.

## Additional Information

- The script automatically checks if Docker and Docker Compose are installed on your system and installs them if necessary.

- The WordPress site created by the script uses the latest version of WordPress available.

- The script sets up a LEMP stack (Linux, Nginx, MySQL, and PHP) within Docker containers for running the WordPress site.

- Each WordPress site is isolated in its own container, allowing you to manage multiple sites independently.

- The script creates an entry in your `/etc/hosts` file to map the site name to localhost, allowing you to access the site in your browser.

- You may need elevated permissions (e.g., using `sudo`) to run some commands or modify system files.

## License

This script is licensed under the [MIT License](LICENSE).

Feel free to modify and customize it according to your needs.
