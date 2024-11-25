#!/bin/bash

#write a script to Automate clearing temporary files older than a certain date.

#Description: Cleaning temporary files older than a day

# Directories to clear
TEMP_DIRS=("/tmp" "/var/tmp")

# Log file
LOG_FILE="/var/log/clear_temp_files.log"

# Timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

echo "[$TIMESTAMP] Starting temporary file cleanup." | tee -a $LOG_FILE

for dir in "${TEMP_DIRS[@]}"; do
    if [ -d "$dir" ]; then
        echo "Cleaning directory: $dir" | tee -a $LOG_FILE
        find "$dir" -type f -mtime +1 -exec rm -f {} \; 2>>$LOG_FILE
        find "$dir" -type d -empty -delete 2>>$LOG_FILE
    else
        echo "Directory $dir does not exist. Skipping." | tee -a $LOG_FILE
    fi
done

echo "[$TIMESTAMP] Cleanup completed." | tee -a $LOG_FILE

