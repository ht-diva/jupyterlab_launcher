#!/bin/bash
#SBATCH --mail-type=NONE
#SBATCH --output=jupyterlab_%j.log
#SBATCH --partition=cpuq
#SBATCH --mem=4GB
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=jupyterlab
#SBATCH --time=06:00:00

source /center/healthds/singularity_functions
launch_jupyterlab
