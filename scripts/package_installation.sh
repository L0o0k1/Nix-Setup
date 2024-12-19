#!/bin/bash

installing_Packges() {
    logs "Installing essential packages .." # Add Whatever you want

    PACKAGES=(
        "curl"
        "unzip"
        "git"
        "nginx"
        "ufw"
        "wget"
        "htop"
        "traceroute"
        "fail2ban"
        "auditd"
        ## You can add What ever you want in here
    )
    if command -v apt-get &> /dev/null; then
        apt-get install -y "${PACKAGES[@]}"
    elif command -v yum &> /dev/null; then
        yum install -y "${PACKAGES[@]}"
    else 
        logs "ERROR: Unable to install essential packages"
        exit 1
    fi
}