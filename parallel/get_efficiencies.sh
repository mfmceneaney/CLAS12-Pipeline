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
#echo ${slurm_pids[*]} #NOTE: Print entire array
touch efficiencies.txt
echo "i completed timeout fail node_fail cpu_used cpu_efficiency mem_used mem_efficiency" >> efficiencies.txt

# Loop PIDs and seff
n=${#slurm_pids[@]}
i=0
while [ $i -lt $n ];
do

echo PID ${slurm_pids[$i]}
echo "COMMAND: seff ${slurm_pids[$i]}"
output=`seff ${slurm_pids[$i]}`
output_completed=`echo ${output} | grep COMPLETED`
output_timeout=`echo ${output} | grep TIMEOUT`
output_failed=`echo ${output} | grep FAILED`
output_node_fail=`echo ${output} | grep NODE_FAIL`
output_cpu_efficiency=`echo ${output} | grep -Eo "CPU Efficiency: .*core-walltime"` #NOTE: -o option is necessary here
output_mem_efficiency=`echo ${output} | grep -Eo "Memory Efficiency: .*$"`

cpu_used=`echo ${output_cpu_efficiency} | sed "s;CPU Efficiency: .*\% of ;;g" | sed "s; core-walltime$;;g"`
cpu_efficiency=`echo ${output_cpu_efficiency} | sed "s;CPU Efficiency: ;;g" | sed "s;\%.*;;g"`
mem_used=`echo ${output_mem_efficiency} | sed "s;Memory Efficiency: .*\% of ;;g" | sed "s; .*B.*$;;g"`
mem_efficiency=`echo ${output_mem_efficiency} | sed "s;Memory Efficiency: ;;g" | sed "s;\%.*;;g"`

completed=0
timeout=0
fail=0
node_fail=0
if [ -n "$output_completed" ]; then #NOTE: THE QUOTES HERE ARE NECESSARY!
    completed=1
fi
if [ -n "$output_timeout" ]; then
    timeout=1
fi
if [ -n "$output_fail" ]; then
    fail=1
fi
if [ -n "$output_node_fail" ]; then
    node_fail=1
fi

echo $i ${completed} ${timeout} ${fail} ${node_fail} ${cpu_used} ${cpu_efficiency} ${mem_used} ${mem_efficiency} >> efficiencies.txt

i=$(($i+1))
done
echo DONE
