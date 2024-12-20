#!/bin/bash

# Function to set firewall rules using UFW
Set_Firewall() {
    # Enable UFW
    ufw enable

    # Allow SSH connections
    ufw allow ssh

    # Allow HTTP connections on port 80
    ufw allow 80/tcp

    # Allow HTTPS connections on port 443
    ufw allow 443/tcp

    # Deny all other incoming traffic by default
    ufw default deny incoming

    # Allow all outgoing traffic
    ufw default allow outgoing

    # Log configuration status
    logs "Firewall (UFW) Configured with Basic Rules"
}
