#!/bin/bash

# Function to install essential packages
installing_Packges() {
    # Log the start of package installation
    logs "Installing essential packages..."

    # List of essential packages to install
    PACKAGES=(
        "curl"
        "unzip"
        "git"
        "nginx"
        "ufw"
        "wget"
        "htop"
        "traceroute"
        "fail2ban"
        "auditd"
        # Add any other packages you need below
    )

    # Check if the system uses apt-get package manager
    if command -v apt-get &> /dev/null; then
        apt-get install -y "${PACKAGES[@]}"
    # Check if the system uses yum package manager
    elif command -v yum &> /dev/null; then
        yum install -y "${PACKAGES[@]}"
    else
        # Log an error if no supported package manager is found
        logs "ERROR: Unable to install essential packages"
        exit 1
    fi
}
