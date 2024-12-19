#!/bin/bash
Updating_Upgrading() {
    logs "Updating system packages..."
#--------------------
## Detect Packge manager 
#--------------------
if command -v yum &> /dev/null; then
    yum update -y
    yum autoremove -y
elif command -v apt-get &> /dev/null; then
    apt-get update
    apt-get upgrade -y
    apt-get autoremove -y
else 
    logs "ERROR: Ops!, Unsupported Package Manager!"

    exit 1
fi
}