#!/bin/bash

# Script to check output files of all jobs in log file.
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

# Set default output directory and file suffix. (You can change these.)
OUTDIR="/farm_out/$USER/"
FILE_SUFFIX=".out"

# Get list of SLURM PIDs
slurm_pids=($(grep -Eo '[0-9]{8}' $FILENAME))

# Loop PIDs and tail output files
n=${#slurm_pids[@]}
i=0
while [ $i -lt $n ];
do

echo PID ${slurm_pids[$i]}
echo "COMMAND: tail ${OUTDIR}/*${slurm_pids[$i]}*${FILE_SUFFIX}"
tail ${OUTDIR}/*${slurm_pids[$i]}*${FILE_SUFFIX}
 
i=$(($i+1))
done
echo DONE
