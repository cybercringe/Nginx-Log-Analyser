#!/bin/bash

# Check if the log file is provided
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <log_file>"
  exit 1
fi

LOG_FILE=$1

# Ensure the log file exists
if [ ! -f "$LOG_FILE" ]; then
  echo "Log file $LOG_FILE not found."
  exit 1
fi

# Function to print top N items
print_top() {
  echo "$1"
  echo "$2" | sort | uniq -c | sort -rn | head -n 5 | awk '{print $2 " - " $1 " requests"}'
  echo ""
}

# Top 5 IP addresses with the most requests
IPs=$(awk '{print $1}' "$LOG_FILE")
print_top "Top 5 IP addresses with the most requests:" "$IPs"

# Top 5 most requested paths
PATHS=$(awk '{print $7}' "$LOG_FILE")
print_top "Top 5 most requested paths:" "$PATHS"

# Top 5 response status codes
STATUS_CODES=$(awk '{print $9}' "$LOG_FILE")
print_top "Top 5 response status codes:" "$STATUS_CODES"

# Top 5 user agents
USER_AGENTS=$(awk -F\" '{print $6}' "$LOG_FILE")
print_top "Top 5 user agents:" "$USER_AGENTS"
