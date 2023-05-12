#!/bin/bash                                                  

# Do not change these!
INFILE='/path/to/infile'
OUTDIR='/path/to/outdir'
INFILE_NAME=`echo $INFILE | xargs -n 1 basename`
mkdir -p $OUTDIR && cd $OUTDIR

# Write your job here.
