#Create a script to monitor and log the status of a process (sshd)
#!/bin/bash

# Log file path
LOG_FILE="/var/log/sshd_status.log"

# Get the current date and time
CURRENT_TIME=$(date "+%Y-%m-%d %H:%M:%S")

# Check if sshd process is running
if ps aux | grep "[s]shd" > /dev/null; then
    STATUS="running"
else
    STATUS="not running"
fi

# Log the status with a timestamp
echo "$CURRENT_TIME - sshd is $STATUS" >> $LOG_FILE

# Optional: Alert if sshd is not running
if [ "$STATUS" == "not running" ]; then
    echo "ALERT: sshd process is not running!" | mail -s "sshd Alert" admin@example.com
fi



