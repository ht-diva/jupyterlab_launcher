#!/bin/bash
#SBATCH --mail-type=NONE
#SBATCH --output=%j_jupyterlab.log
#SBATCH --partition=cpuq
#SBATCH --mem=4GB
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --job-name=jupyterlab
#SBATCH --time=08:00:00

source $HOME/.bashrc
conda activate jupyterlab
cd $HOME
jupyter-lab --no-browser --port=8890 --ip 0.0.0.0