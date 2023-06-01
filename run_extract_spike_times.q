#!/bin/bash
#
#SBATCH -p wmglab
/opt/apps/rhel7/matlabR2019a/bin/matlab -nodisplay -r "extract_spike_times"
