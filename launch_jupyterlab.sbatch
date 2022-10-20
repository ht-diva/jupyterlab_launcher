#!/bin/bash
#SBATCH --mail-type=NONE
#SBATCH --output=jupyterlab.log
#SBATCH --partition=cpu-interactive
#SBATCH --mem=16GB
#SBATCH --ntasks=1
#SBATCH --job-name=jupyterlab
#SBATCH --time=06:00:00

source $HOME/.bashrc
conda activate jupyterlab_launcher
cd $HOME
jupyter-lab --no-browser --port=8890 --ip 0.0.0.0 
