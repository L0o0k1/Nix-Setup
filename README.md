# Server Setup Automation Script

## Overview

This script automates the setup and configuration of a server. It performs essential tasks such as updating and upgrading system packages, installing necessary packages, configuring SSH settings, creating a new admin user, setting up a firewall, and installing and configuring a web server. The script ensures that the server is secured with fail2ban and other hardening measures.

## Features

- **System Update and Upgrade**: Updates and upgrades system packages to ensure they are up-to-date.
- **Package Installation**: Installs a list of essential packages required for server operation.
- **SSH Configuration**: Configures SSH to disable root login and password authentication, and enables key-based authentication.
- **Admin User Creation**: Creates a new admin user with sudo access and generates an SSH key pair for the user.
- **Firewall Setup**: Configures the firewall to allow essential traffic and deny all other incoming traffic by default.
- **Web Server Installation**: Installs and configures the Nginx web server with a default HTML page.
- **Security Hardening**: Configures fail2ban to protect against brute force attacks and applies additional security measures.

## Usage

1. **Run the Script as Root**: Ensure you run the script as the root user or with sudo privileges.
2. **Log Output**: The script logs all actions performed for transparency and debugging purposes.

## Structure

The script is divided into several functions, each responsible for a specific task:

- `Updating_Upgrading()`: Updates and upgrades system packages.
- `installing_Packges()`: Installs essential packages.
- `ssh_config()`: Configures SSH settings.
- `new_admin_usr()`: Creates a new admin user with sudo access.
- `Set_Firewall()`: Sets up the firewall using UFW.
- `installing_web_server()`: Installs and configures the Nginx web server.
- `apply_security_hardening()`: Applies additional security measures, including configuring fail2ban.

## Important Notes

- **Script Structure**: The script follows best practices for maintainability and readability.
- **Comments**: Clear and concise comments are included to explain each part of the code.
- **Error Handling**: The script includes error handling to log and exit if an unsupported package manager is detected or if the script is not run as root.

## Getting Started

1. **Download the Script**: Save the script to your server.
2. **Make the Script Executable**: Run `chmod +x script_name.sh` to make the script executable.
3. **Run the Script**: Execute the script with `sudo ./script_name.sh`.

## Disclaimer

Use this script at your own risk. Ensure you understand each part of the script before running it on a production server.

---
