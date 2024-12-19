#!/bin/bash
set -euo pipefail
#---------------------------
## Logging ..
#---------------------------
logs(){
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}
#---------------------------
## Root Checking.
#---------------------------
ch_root(){
    if [[ $EUID -ne 0 ]]; then
        logs "ERROR: This script must be run as root"
        exit 1
    fi
}
#---------------------------
# Importing Scripts Modules
# --------------------------
source scripts/system_update.sh
source scripts/package_installation.sh
source scripts/ssh_config.sh
source scripts/user_management.sh
source scripts/firewall_setup.sh
source scripts/web_server_install.sh
source scripts/security_hardening.sh
# ====
mainFun() {
    ch_root
    logs "Starting server Setup Process..!"
    
    update_system
    install_packages
    create_admin_user
    configure_ssh
    setup_firewall
    installing_web_server
    apply_security_hardening

    logs "Server Setup Completed Successfully!"
}

mainFun "$@"