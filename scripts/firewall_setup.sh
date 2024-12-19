#!/bin/bash
Set_Firewall() {
    ufw enable
    ufw allow ssh
    ufw allow 80/tcp
    ufw allow 443/tcp
#-------------------------
# Ignore all other incoming traffic by default
#-------------------------
    ufw default deny incoming
    ufw default allow outgoing

    logs "Firewall (UFW) Configured with Basic Rules"
}