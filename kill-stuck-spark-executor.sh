#!/bin/bash

# My heuristic is that executors that are running and have CPU usage less than 120% CPU are stuck
# In my case healthy executors have all CPUs used
# Unheathy ones usualy have 0-5% CPU used

EXECUTOR_PS_LINE=$(ps aux | grep org.apache.spark.executor | grep -v grep | tr -s ' ')
EXECUTOR_PID=$(echo "$EXECUTOR_PS_LINE"|  cut  -d ' '  -f 2)
MIN_ALLOWED_CPU_USAGE=2

TOTAL_CPU_USAGE=$(top -bn2 | grep '%Cpu' | tail -1 | tr -s ' ' | cut -d ' ' -f 2)

if [ -z "$EXECUTOR_PID" ]; then
  echo "Unable to find executor process, exiting..."
  exit 0
else
  echo "Found executor PID: $EXECUTOR_PID"
  echo "Current CPU usage is: $TOTAL_CPU_USAGE"
fi

if (( $(echo "$MIN_ALLOWED_CPU_USAGE > $TOTAL_CPU_USAGE" |bc -l) )); then
  echo "killing Executor with PID $EXECUTOR_PID"
  kill "$EXECUTOR_PID"
else
  echo "CPU usage is above threshold of $MIN_ALLOWED_CPU_USAGE, Executor is running OK"
fi

echo "Done"
