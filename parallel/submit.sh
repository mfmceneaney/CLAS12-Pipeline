#!/bin/bash

#SBATCH --job-name=clas12Lambdas
#SBATCH --output=/farm_out/%u/%x-%j-%N.out
#SBATCH --error=/farm_out/%u/%x-%j-%N.err
#SBATCH --partition=production
#SBATCH --account=clas12
#SBATCH -c 2
#SBATCH --mem-per-cpu=8G
#SBATCH --gres=disk:2G
#SBATCH --time=12:00:00
#SBATCH --mail-user=your-email@somewhere.org

job.sh
