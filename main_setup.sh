#!/bin/bash
set -euo pipefail

# ---------------------------
# Logging function
# ---------------------------
logs() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*"
}

# ---------------------------
# Root Checking
# ---------------------------
ch_root() {
    if [[ $EUID -ne 0 ]]; then
        logs "ERROR: This script must be run as root"
        exit 1
    fi
}

# ---------------------------
# Importing Scripts Modules
# ---------------------------
source scripts/system_update.sh
source scripts/package_installation.sh
source scripts/ssh_config.sh
source scripts/user_management.sh
source scripts/firewall_setup.sh
source scripts/web_server_install.sh
source scripts/security_hardening.sh

# ====
# Main Function
# ====
mainFun() {
    ch_root
    logs "Starting server setup process...!"

    # Run imported script functions
    Updating_Upgrading
    installing_Packges
    new_admin_usr
    ssh_config
    Set_Firewall
    installing_web_server
    apply_security_hardening

    logs "Server setup completed successfully!"
}

mainFun "$@"
