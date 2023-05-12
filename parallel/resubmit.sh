#!/bin/bash

# Script to resubmit by user job submission order number all jobs in log file.
# Accepts file name as argument.

# Check arguments                                                                                                                                                          
FILENAME="timeout_jobs.txt"
if (($# > 0 )); then
    FILENAME=$1
    echo Checking $FILENAME
else
    name=`basename "$0"`
    echo "Usage: $name <filename>"
    exit 0
fi

# Get SLURM PIDs as list
slurm_pids=($(grep -Eo '[0-9]{1,10}' $FILENAME))
#echo ${slurm_pids[*]} #NOTE: Print entire array

# Loop PIDs and resubmit
n=${#slurm_pids[@]}
i=0
while [ $i -lt $n ];
do

# Set filenames
SUBMITFILE=submit${slurm_pids[$i]}.sh
JOBFILE=job${slurm_pids[$i]}.sh

echo PID ${slurm_pids[$i]}
echo "COMMAND: sbatch $SUBMITFILE"
INFILE=`grep -E "INFILE=.*" $JOBFILE | sed "s;export INFILE=;;" | sed "s;';;g"`
echo "> $i ${slurm_pids[$i]} $INFILE"
echo
sbatch $SUBMITFILE #NOTE: Change filename as needed.
echo

i=$(($i+1))
done
echo DONE
