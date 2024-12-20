#!/bin/bash

# Function to apply security hardening
apply_security_hardening() {
    # ---------------------------
    # Configure fail2ban for SSH
    # ---------------------------

    # Backup original fail2ban configuration
    cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

    # Set ban time to 1 hour
    sed -i 's/bantime = 10m/bantime = 1h/' /etc/fail2ban/jail.local

    # Set maximum retries to 3
    sed -i 's/maxretry = 5/maxretry = 3/' /etc/fail2ban/jail.local

    # Enable and restart fail2ban service
    systemctl enable fail2ban
    systemctl restart fail2ban

    # Log the application of additional security measures
    logs "Additional security measures applied!"
}
