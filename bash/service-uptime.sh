#!/bin/bash


# Define the service name
SERVICE="ssh"
LOGFILE="/var/log/service_monitor.log"


# Function to log actions
log_action() {
    local message="$1"
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $message" >> "$LOGFILE"
}


# Check if the service is active
if systemctl is-active --quiet "$SERVICE"; then
    log_action "$SERVICE service is running."
else
    log_action "$SERVICE service is down. Attempting to restart."
    systemctl restart "$SERVICE"
    if systemctl is-active --quiet "$SERVICE"; then
        log_action "Successfully restarted $SERVICE service."
    else
        log_action "Failed to restart $SERVICE service. Manual intervention required."
    fi
fi

