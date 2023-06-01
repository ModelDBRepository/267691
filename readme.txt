This is the readme for the model associated with the paper:

K. Kumaravelu, J. Sombeck, L. E. Miller, S. J. Bensmaia and W. M. Grill (2022) 
Stoney vs. Histed: Quantifying the spatial effects of intracortical microstimulation. 
Brain stimulation 

This model was contributed by K. Kumaravelu.

Instructions to run the model:
The cortical column model comprises 6410 neurons across 25 cell types and hence needs 
to be simulated on a compute cluster with many CPUs. The model was run using NEURON with 
MPI support on the Duke Compute Cluster with the q file - run_model.q
The run_model.q file might have to be modified to match your local cluster resources. 

Instructions to replicate Figs-4A & 4B from the paper:
1. Compile the mod files from /mechanisms using /opt/apps/rhel7/nrn-7.7/x86_64/bin/nrnivmodl. 
   This should create a directory called /mechanisms/x86_64.
2. To run the model, use: sbatch run_model.q This would begin execution of the cortical column model. At the end of the simulation,
   transmembrane potentials across the model's soma and axon of each neuron would be saved in the current directory as .dat files. 
   For example, Vm_10_446.dat refers to the transmembrane potential recorded from the soma of the 446th neuron of cell type 10. Similarly, 
   Vm_axon_ refers to the transmembrane potential recordings from the axonal compartments of neurons. 
3. Next, run the MATLAB code extract_spike_times.m using q file run_extract_spike_times.q to extract the spike times from the 
   transmembrane potential data files. Note the extract_spike_times.m must be executed from the same directory that stores 
   the Vm_ files. At the end of the simulation run, spike times across soma and axon of each neuron in the model would be saved as .mat files. 
   For example, data_soma23.mat refers to the spike times of soma across all neurons of cell type 23. Similarly, data_axon23.mat refers to the 
   spike times across all axon compartments for all neurons of cell type 23. 
4. Transfer the spike times .mat files to the data_analysis folder and run the code axon_analysis.m to replicate figure 4A in the paper. 
   Next, run soma_analysis.m to replicate figure 4B in the paper.        

Overview of data files:

1. realx.dat, realy.dat, realz.dat - x,y,z coordinates (in microns) of cell bodies of neurons in the column
2. realang.dat - angle at which each neuron is rotated around its somatodendritic axis
3. cell_cnt.dat - number of neurons within each cell type. There are 25 different cell types and 6410 neurons in total
4. /data_analysis/intx.dat, inty.dat, intz.dat - x,y,z coordinates of various compartments (soma, axon, dendrites) for each cell type
5. /data_analysis/soma_coord.dat - x,y,z coordinates of soma for each cell type
6. /data_analysis/x_axon.dat, y_axon.dat, z_axon.dat - x,y,z coordinates of various axonal compartments for each cell type

   