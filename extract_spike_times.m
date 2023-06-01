clear all
clear all
close all

load('cell_cnt.dat')

for cell_type=1:25

cnt=1;
    for i=1:cell_cnt(cell_type)
    name=['Vm_' num2str(cell_type) '_' num2str(i) '.dat'];
    a=load(name);
    data_soma(cnt).times = a(diff(a(:,2)>-20)==1,1)'; 
    cnt=cnt+1;
    clear a
	end
        

    for i=1:cell_cnt(cell_type)
    name=['Vm_axon_' num2str(cell_type) '_' num2str(i) '.dat'];
    a=load(name);
    
    for j=1:length(a(1,:))-1
    data_axon(i).times{1,j} = a(diff(a(:,j+1)>-20)==1,1)'; 
    end
    
    clear a
    
    end

    name1=['data_soma' num2str(cell_type) '.mat'];
    name2=['data_axon' num2str(cell_type) '.mat'];


save(name1,'data_soma')
save(name2,'data_axon')

clear data_soma data_axon name name1 name2

end



    