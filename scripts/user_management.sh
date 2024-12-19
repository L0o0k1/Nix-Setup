#!/bin/bash
new_admin_usr() {
    local USERNAME="admin"
    local PASSWORD=$(openssl rand -base64 15 )
#---------------------------
# Createing User.
#---------------------------
useradd -m -s /bin/bash "$USERNAME"
echo "$USERNAME: $PASSWORD" | chpasswd
#---------------------------
# Adding to sudo group.
#---------------------------
usermod -aG sudo "$USERNAME"

#---------------------------
# Generating SSH Key for the user
#---------------------------
sudo -u "$USERNAME" ssh-keygen -t rsa -b 4096 -f "/home/$USERNAME/.ssh/id_rsa" -N ""
    logs "Admin User $USERNAME Created with sudo access"
    logs " Temporary Pasword : $PASSWORD (Change on first login.)"

}