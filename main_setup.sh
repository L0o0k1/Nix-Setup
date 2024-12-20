#!/bin/bash
set -euo pipefail

# ---------------------------
# Global Variables
# ---------------------------
LOG_FILE="/var/log/setup_script.log"
BACKUP_DIR="/root/config_backup_$(date +%Y%m%d)"

# ---------------------------
# Logging Function
# ---------------------------
logs() {
    MSG="[$(date +'%Y-%m-%d %H:%M:%S')] $*"
    echo "$MSG" | tee -a "$LOG_FILE"
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
# System Validation
# ---------------------------
validate_system() {
    logs "Validating system compatibility..."
    
    OS_ID=$(grep -i '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
    OS_VERSION=$(grep -i '^VERSION_ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
    
    case "$OS_ID" in
        "ubuntu")
            logs "Detected Ubuntu Server (Version: $OS_VERSION)"
            REQUIRED_OS="Ubuntu"
            ;;
        "rhel" | "centos" | "rocky" | "alma")
            logs "Detected Red Hat-based Server (Version: $OS_VERSION)"
            REQUIRED_OS="Red Hat"
            ;;
        *)
            logs "ERROR: Unsupported OS detected: $OS_ID. This script only supports Ubuntu and Red Hat-based systems."
            exit 1
            ;;
    esac

    logs "System is compatible with $REQUIRED_OS-based configurations."
}

# ---------------------------
# System Resource Check
# ---------------------------
check_resources() {
    logs "Checking system resources..."

    # Check CPU cores
    CPU_CORES=$(nproc)
    if [[ $CPU_CORES -lt 2 ]]; then
        logs "WARNING: Low CPU cores detected ($CPU_CORES)."
    fi

    # Check available RAM
    RAM=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
    if [[ $RAM -lt 2097152 ]]; then  # 2GB in KB
        logs "WARNING: Low available RAM detected (${RAM}KB)."
    fi

    # Check available disk space
    DISK_SPACE=$(df / --output=avail -k | tail -n 1)
    if [[ $DISK_SPACE -lt 5242880 ]]; then  # 5GB in KB
        logs "ERROR: Insufficient disk space (${DISK_SPACE}KB). Exiting..."
        exit 1
    fi

    logs "System resource check passed."
}

# ---------------------------
# Backup Function
# ---------------------------
backup_configs() {
    logs "Backing up existing configurations..."

    mkdir -p "$BACKUP_DIR"

    cp /etc/ssh/sshd_config "$BACKUP_DIR/" 2>/dev/null || :
    cp /etc/firewalld/firewalld.conf "$BACKUP_DIR/" 2>/dev/null || :
    cp /etc/firewall/rules.v4 "$BACKUP_DIR/" 2>/dev/null || :

    logs "Backup completed. Backup directory: $BACKUP_DIR"
}

# ---------------------------
# Post-Installation Verification
# ---------------------------
verify_services() {
    logs "Verifying services..."

    # Check SSH service
    if systemctl is-active --quiet sshd; then
        logs "SSH service is running."
    else
        logs "ERROR: SSH service is not running."
    fi

    # Check Firewall (UFW for Ubuntu, firewalld for Red Hat)
    if command -v ufw &>/dev/null && ufw status | grep -qw "active"; then
        logs "Firewall (UFW) is active."
    elif systemctl is-active --quiet firewalld; then
        logs "Firewall (firewalld) is active."
    else
        logs "ERROR: No active firewall detected."
    fi

    # Check Web Server
    if systemctl is-active --quiet apache2 || systemctl is-active --quiet httpd; then
        logs "Web server is running."
    else
        logs "ERROR: Web server is not running."
    fi

    logs "Service verification completed."
}

# ---------------------------
# Cleanup on Exit
# ---------------------------
cleanup() {
    logs "Cleaning up temporary files..."
    # Add commands to clean up if necessary
}
trap cleanup EXIT

# ---------------------------
# Importing Script Modules
# ---------------------------
source scripts/system_update.sh
source scripts/package_installation.sh
source scripts/ssh_config.sh
source scripts/user_management.sh
source scripts/firewall_setup.sh
source scripts/web_server_install.sh
source scripts/security_hardening.sh

# ---------------------------
# Main Function
# ---------------------------
mainFun() {
    ch_root
    validate_system
    check_resources
    backup_configs
    logs "Starting server setup process...!"

    # Run imported script functions
    Updating_Upgrading
    installing_Packges
    new_admin_usr
    ssh_config
    Set_Firewall
    installing_web_server
    apply_security_hardening

    verify_services
    logs "Server setup completed successfully!"
}

mainFun "$@"
