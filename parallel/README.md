# CLAS12 Pipeline: Parallel

This provides a working example for submitting [SLURM](https://slurm.schedmd.com/overview.html) jobs in parallel for a set of files.

The `setup.sh` script loops a regex of files, and creates a job script and submits it for each file.  Created job and submission scripts are put in the directory `jobs` (also created by this script).  The script will also output the SLURM job ids and output file names and numbers for logging purposes.  It is useful to save this to a text output.  Then one can use the `check_*.sh` scripts for checking job status and completion and resubmission of failed jobs.

The `job.sh` script is where you should write your actual job that you want performed for each file.  The script `setup.sh` will modify input and output files names and directories via the environment variables `$INFILE`, `$INDIR`, `$OUTFILE`, `$OUTDIR`.

The `submit.sh` script is where you should specify all the SLURM job options you want.  This script will also be copied into the `jobs` directory for each job.

#

Contact: matthew.mceneaney@duke.edu
