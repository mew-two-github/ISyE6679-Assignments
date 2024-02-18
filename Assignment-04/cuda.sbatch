#!/bin/bash

# Request 1 GPU core.
#SBATCH -N1 --gres=gpu:1

# Request 10 minutes of wall-clock time.
#SBATCH -t10

# Set the output log to be batch.log
#SBATCH -oReport-%j.log
#SBATCH -obatch.log

# Change to the submission directory
cd $SLURM_SUBMIT_DIR

# Load the cuda module so we can find the run-time libraries
module load cuda

# Run the code
./device-query > myoutput.log
