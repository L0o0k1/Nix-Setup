#!/bin/bash

# Function to create a new admin user
new_admin_usr() {
    local USERNAME="admin"
    local PASSWORD=$(openssl rand -base64 15 )

    # ---------------------------
    # Creating User
    # ---------------------------
    useradd -m -s /bin/bash "$USERNAME"
    echo "$USERNAME:$PASSWORD" | chpasswd

    # ---------------------------
    # Adding to sudo group
    # ---------------------------
    usermod -aG sudo "$USERNAME"

    # ---------------------------
    # Generating SSH Key for the user
    # ---------------------------
    sudo -u "$USERNAME" ssh-keygen -t rsa -b 4096 -f "/home/$USERNAME/.ssh/id_rsa" -N ""

    # Log the creation of the new admin user
    logs "Admin User $USERNAME Created with sudo access"
    logs "Temporary Password: $PASSWORD (Change on first login.)"
}
