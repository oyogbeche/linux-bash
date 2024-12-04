#!/bin/bash
# Script to log active network connections

# Variables
LOG_DIR="/var/log/network_logs"    # Directory to store logs
LOG_FILE="$LOG_DIR/connections_$(date +%Y%m%d_%H%M%S).log" # Log file with timestamp

# Create the log directory if it doesn't exist
if [ ! -d "$LOG_DIR" ]; then
    sudo mkdir -p "$LOG_DIR"
    sudo chmod 755 "$LOG_DIR"
    echo "Log directory created: $LOG_DIR"
fi

# Get active network connections
echo "Fetching active network connections..."
if command -v ss &>/dev/null; then
    # Use ss if available
    ss -tunap > "$LOG_FILE"
    echo "Active connections logged using 'ss' command."
elif command -v netstat &>/dev/null; then
    # Fallback to netstat if ss is not available
    netstat -tunap > "$LOG_FILE"
    echo "Active connections logged using 'netstat' command."
else
    echo "Error: Neither 'ss' nor 'netstat' is available on this system."
    exit 1
fi

# Output file location and a summary to the console
echo "Active connections logged to: $LOG_FILE"
echo "Summary of connections:"
tail -n 5 "$LOG_FILE"  # Display the last 5 lines of the log file

exit 0

