#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <days>"
    exit 1
fi

DAYS=$1
LOG_DIR="/var/log"

if [ ! -d "$LOG_DIR" ]; then
    echo "Error: $LOG_DIR is not a directory"
    exit 1
fi

echo "Deleting files in $LOG_DIR older than $DAYS days..."
find "$LOG_DIR" -name "*.log" -mtime +$DAYS -exec rm -f {} \; 2>/dev/null
echo "Cleanup complete."
