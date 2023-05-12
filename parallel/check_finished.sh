#!/bin/bash

# Script to check completion status of all jobs in log file.
# Accepts file name as argument.
  
# Check arguments
FILENAME="jobs.txt"
if (($# > 0 )); then
    FILENAME=$1
    echo Checking $FILENAME
else
    name=`basename "$0"`
    echo "Usage: $name <filename>"
    exit 0
fi

# Get SLURM PIDs as list
slurm_pids=($(grep -Eo '[0-9]{8}' $FILENAME))
#echo ${slurm_pids[*]} #NOTE: Print entire array.

# Loop PIDs and seff
n=${#slurm_pids[@]}
i=0
while [ $i -lt $n ];
do

echo PID ${slurm_pids[$i]}
echo "COMMAND: seff ${slurm_pids[$i]}"
seff ${slurm_pids[$i]}
echo
 
i=$(($i+1))
done
echo DONE
