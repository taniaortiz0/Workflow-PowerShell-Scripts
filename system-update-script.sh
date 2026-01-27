#!/bin/bash

if command -v apt >/dev/null 2>&1; then
    echo "Detected Debian/Ubuntu (apt)"
    sudo apt update && sudo apt upgrade -y
elif command -v dnf >/dev/null 2>&1; then
    echo "Detected Fedora/RHEL8+ (dnf)"
    sudo dnf upgrade --refresh -y
elif command -v yum >/dev/null 2>&1; then
    echo "Detected RHEL/CentOS7 (yum)"
    sudo yum update -y
else
    echo "No supported package manager found (apt/dnf/yum)"
    exit 1
fi

echo "Update complete. Reboot? (y/n)"
read -r REBOOT
[ "$REBOOT" = "y" ] && sudo reboot
