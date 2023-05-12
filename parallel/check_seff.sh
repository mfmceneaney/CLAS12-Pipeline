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
touch timeout_jobs.txt
touch fail_jobs.txt
touch node_fail_jobs.txt

# Loop PIDs and seff                                                                                                                                                       
n=${#slurm_pids[@]}
i=0
while [ $i -lt $n ];
do

echo PID ${slurm_pids[$i]}
echo "COMMAND: seff ${slurm_pids[$i]}"
output=`seff ${slurm_pids[$i]}`
output_timeout=`echo ${output} | grep TIMEOUT`
output_failed=`echo ${output} | grep FAILED`
output_node_fail=`echo ${output} | grep NODE_FAIL`
                                                                                                                                                                   
if [ -n "$output_timeout" ]; then #NOTE: THE QUOTES HERE ARE NECESSARY!                                                                                                    
    echo $i >> timeout_jobs.txt
fi
if [ -n "$output_fail" ]; then
    echo $i  >> fail_jobs.txt
fi
if [ -n "$output_node_fail" ]; then
    echo $i >> node_fail_jobs.txt
fi
echo

i=$(($i+1))
done
echo DONE
