#!/bin/bash

# Function to get total CPU usage
get_cpu_usage() {
    echo "=== CPU Usage ==="
    top -bn1 | grep "Cpu(s)" | \
    awk '{print "CPU Usage: " 100 - $8 "%"}'
}

# Function to get memory usage
get_memory_usage() {
    echo -e "\n=== Memory Usage ==="
    free -m | awk 'NR==2{
        used=$3
        free=$4
        total=$2
        printf "Used: %s MB\nFree: %s MB\nTotal: %s MB\nUsage: %.2f%%\n", used, free, total, used/total * 100
    }'
}

# Function to get disk usage
get_disk_usage() {
    echo -e "\n=== Disk Usage (/ Partition) ==="
    df -h / | awk 'NR==2{
        printf "Used: %s\nFree: %s\nTotal: %s\nUsage: %s\n", $3, $4, $2, $5
    }'
}

# Function to get top 5 processes by CPU usage
get_top_cpu_processes() {
    echo -e "\n=== Top 5 Processes by CPU Usage ==="
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
}

# Function to get top 5 processes by memory usage
get_top_mem_processes() {
    echo -e "\n=== Top 5 Processes by Memory Usage ==="
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
}

# Run all functions
get_cpu_usage
get_memory_usage
get_disk_usage
get_top_cpu_processes
get_top_mem_processes
