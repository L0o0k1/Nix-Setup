#!/bin/bash

# Function to update and upgrade system packages
Updating_Upgrading() {
    # Log the start of the updating process
    logs "Updating system packages..."

    # --------------------
    # Detect Package Manager
    # --------------------
    if command -v yum &> /dev/null; then
        yum update -y
        yum autoremove -y
    elif command -v apt-get &> /dev/null; then
        apt-get update
        apt-get upgrade -y
        apt-get autoremove -y
    else
        # Log an error if no supported package manager is found
        logs "ERROR: Oops! Unsupported Package Manager!"
        exit 1
    fi
}
