#!/bin/bash

# Modify these as necessary
DIR=`dirname "$0"`
DIR_NAME=`echo $DIR | xargs -n 1 basename`
OUTDIR='/path/to/outdir/$DIR_NAME' #NOTE Change /path/to/outdir as needed.  An directory named identically to $PWD will be created.
INFILES=/path/to/*.root #NOTE: Change /path/to/*.root to your input files
JOB_SCRIPT=job.sh
SUBMIT_SCRIPT=submit.sh
DEFAULT_INFILE_PATH='/path/to/infile' #NOTE: Define INFILE='/path/to/infile' in your job script.
DEFAULT_OUTDIR_PATH='/path/to/outdir' #NOTE: Define OUTDIR='/path/to/outdir' in your job script.

# Get basenames of scripts
JOB_SCRIPT_NAME=`echo $JOB_SCRIPT | xargs -n 1 basename`
SUBMIT_SCRIPT_NAME=`echo $SUBMIT_SCRIPT | xargs -n 1 basename`

# Create job files and submit to slurm
cd ${OUTDIR}
i=1
for INFILE in ${INFILES};
do
echo "> $i $INFILE"
echo
TARGET_JOB_SCRIPT=${SCRIPT_DIR}/${JOB_SCRIPT_NAME}_$i
TARGET_SUBMIT_SCRIPT=${SCRIPT_DIR}/${SUBMIT_SCRIPT_NAME}_$i
cp ${JOB_SCRIPT} ${TARGET_JOB_SCRIPT}
cp ${SUBMIT_SCRIPT} ${TARGET_SUBMIT_SCRIPT}
sed -i "s;${DEFAULT_INFILE_PATH};$INFILE;g" ${TARGET_JOB_SCRIPT}
sed -i "s;${DEFAULT_OUTDIR_PATH};$OUTDIR;g" ${TARGET_JOB_SCRIPT}
sed -i "s;${JOB_SCRIPT};${TARGET_JOB_SCRIPT};g" ${TARGET_SUBMIT_SCRIPT}
sbatch ${TARGET_SUBMIT_SCRIPT}
echo
((i++))
done
