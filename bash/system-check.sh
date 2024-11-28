 #!/bin/bash

# Set thresholds
CPU_THRESHOLD=80
MEMORY_THRESHOLD=75

# Get current CPU usage
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')

# Get current memory usage
MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')

# Output CPU and memory usage
echo "Current CPU Usage: $CPU_USAGE%"
echo "Current Memory Usage: $MEMORY_USAGE%"

# Check CPU usage and send email if threshold is exceeded
if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
    echo "CPU usage is above $CPU_THRESHOLD%. Sending alert email."
    echo "High CPU Usage: $CPU_USAGE%" | mail -s "Alert: High CPU Usage" osagieanolu22@gmail.com
fi

# Check memory usage and send email if threshold is exceeded
if (( $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l) )); then
    echo "Memory usage is above $MEMORY_THRESHOLD%. Sending alert email."
    echo "High Memory Usage: $MEMORY_USAGE%" | mail -s "Alert: High Memory Usage" osagieanolu22@gmail.com
fi
