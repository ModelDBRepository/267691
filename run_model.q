#!/bin/bash
#
#SBATCH --mem 20G
#SBATCH -p wmglab
#SBATCH --array=1-25
#SBATCH --ntasks=400
#SBATCH --cpus-per-task=1
mpirun -np $SLURM_NTASKS ./mechanisms/x86_64/special -NSTACK 100000 -NFRAME 20000 -Py_NoSiteFlag -nobanner -c -mpi "cell_id=$SLURM_ARRAY_TASK_ID" init_icms.hoc