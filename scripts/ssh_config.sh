#!/bin/bash
ssh_config() {
    local SSH_CONFIG="/etc/ssh/sshd_config"
#---------------------------
# Backing up!
#---------------------------
cp "$SSH_CONFIG" "${SSH_CONFIG}.backup"
#---------------------------
# Modify SSH Configuration
#---------------------------
sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' "$SSH_CONFIG"
sed -i 's/^PasswordAuthentication yes/PasswordAuthentication no/' "$SSH_CONFIG"
#---------------------------
# Enable key-based auth
#---------------------------
echo "PubkeyAuthentication yes" >> "$SSH_CONFIG"
#---------------------------
#  Restart SSH service
#---------------------------
systemctl restart ssh
#---------------------------
logs "SSH Configuration Updated and Harded"
}