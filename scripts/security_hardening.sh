apply_security_hardening() {
#---------------------------
# Configure fail2ban for SSH
# --------------------------
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sed -i 's/bantime = 10m/bantime = 1h/' /etc/fail2ban/jail.local
sed -i 's/maxretry = 5/maxretry = 3/' /etc/fail2ban/jail.local

    systemctl enable fail2ban
    systemctl restart fail2ban
    logs "Additional security measues applied!"
}