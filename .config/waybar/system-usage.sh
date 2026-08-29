#!/usr/bin/env bash

read_cpu() {
  read -r _ user nice system idle iowait irq softirq steal _ < /proc/stat
  cpu_idle=$((idle + iowait))
  cpu_total=$((user + nice + system + idle + iowait + irq + softirq + steal))
}

read_cpu
idle1=$cpu_idle
total1=$cpu_total
sleep 0.1
read_cpu
idle2=$cpu_idle
total2=$cpu_total

total_delta=$((total2 - total1))
if (( total_delta > 0 )); then
  cpu_usage=$((100 * (total_delta - (idle2 - idle1)) / total_delta))
else
  cpu_usage=0
fi

memory_usage=$(awk '
  /^MemTotal:/     { total = $2 }
  /^MemAvailable:/ { available = $2 }
  END {
    if (total > 0) printf "%d", ((total - available) * 100 / total) + 0.5
    else print 0
  }
' /proc/meminfo)

printf '{"text":"󰍛 CPU %d%% Mem %d%%"}\n' "$cpu_usage" "$memory_usage"
