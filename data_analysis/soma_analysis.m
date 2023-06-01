clear all
clear all
close all


load('realx.dat')
load('realy.dat')
load('realz.dat')

load('realang.dat')

load('cell_cnt.dat')

cnt_cnt=1;

for id=1:25
    
amp=[50];


bin_size=1;

intx=load(['intx_' num2str(id) '.dat']);
inty=load(['inty_' num2str(id) '.dat']);
intz=load(['intz_' num2str(id) '.dat']);

soma_coord=load(['soma_coord_' num2str(id) '.dat']);

load(['data_soma' num2str(id) '.mat'])

cell_id=1:cell_cnt(id);

elec_x=200;
elec_y=1000;
elec_z=200;

eli_a=[];
eliminate=[];

% tot_cell_count.sum(0,cell_id-1)-tot_cell_count.x[cell_id-1]+n_run1-1
% sum()
% sum(cell_cnt(1:id))-cell_cnt(id)+k

cnt=1;
for k=1:cell_cnt(id)
    
    net_ad_x1a=(((realx(sum(cell_cnt(1:id))-cell_cnt(id)+k ))*cos(realang(sum(cell_cnt(1:id))-cell_cnt(id)+k )))-((realz(sum(cell_cnt(1:id))-cell_cnt(id)+k ))*sin(realang(sum(cell_cnt(1:id))-cell_cnt(id)+k ))))-(realx(sum(cell_cnt(1:id))-cell_cnt(id)+k ));
    net_ad_y1a=(realy(sum(cell_cnt(1:id))-cell_cnt(id)+k ))-(realy(sum(cell_cnt(1:id))-cell_cnt(id)+k ));
    net_ad_z1a=(((realx(sum(cell_cnt(1:id))-cell_cnt(id)+k ))*sin(realang(sum(cell_cnt(1:id))-cell_cnt(id)+k )))+((realz(sum(cell_cnt(1:id))-cell_cnt(id)+k ))*cos(realang(sum(cell_cnt(1:id))-cell_cnt(id)+k ))))-(realz(sum(cell_cnt(1:id))-cell_cnt(id)+k ));
    
for i=1:length(intx)
% for j=1:nseg(i)
    
    x1a=(((realx(sum(cell_cnt(1:id))-cell_cnt(id)+k )+intx(i))*cos(realang(sum(cell_cnt(1:id))-cell_cnt(id)+k )))-((realz(sum(cell_cnt(1:id))-cell_cnt(id)+k )+intz(i))*sin(realang(sum(cell_cnt(1:id))-cell_cnt(id)+k ))));
    y1a=(realy(sum(cell_cnt(1:id))-cell_cnt(id)+k )+inty(i));
    z1a=(((realx(sum(cell_cnt(1:id))-cell_cnt(id)+k )+intx(i))*sin(realang(sum(cell_cnt(1:id))-cell_cnt(id)+k )))+((realz(sum(cell_cnt(1:id))-cell_cnt(id)+k )+intz(i))*cos(realang(sum(cell_cnt(1:id))-cell_cnt(id)+k ))));

    x_final_a=x1a-net_ad_x1a;
    y_final_a=y1a-net_ad_y1a;
    z_final_a=z1a-net_ad_z1a;
    
rdist_a=(sqrt(((elec_x-x_final_a)^2)+(((elec_y-y_final_a)^2)+((elec_z-z_final_a)^2))));
if rdist_a<15 
eli_a(cnt)=k;
cnt=cnt+1;
end
% end
end
end

if ~isempty(eli_a)

eliminate=unique(eli_a);

end


for i=1:cell_cnt(id)
if ~isempty(data_soma(i).times)
if data_soma(i).times >=210
    data_soma(i).times=[];
end
end
end

real_cell_id=[];

cnt=1;
for i=1:cell_cnt(id)
if ~isempty(data_soma(i).times)
dta(cnt)=sort(data_soma(i).times(1))-201;
real_cell_id(cnt)=cell_id(i); 
cnt=cnt+1;
end
end

if ~isempty(real_cell_id)

ind_find=[];
cmbt=1;
if ~isempty(eliminate)
    for i=1:length(eliminate)
        if ~isempty(find(real_cell_id==eliminate(i), 1)) 
    ind_find(cmbt)=find(real_cell_id==eliminate(i));
    cmbt=cmbt+1;
    end
    end
    real_cell_id(ind_find)=[];
    dta(ind_find)=[];
    
end

for pri=1:length(dta)
    dta_final(cnt_cnt)=dta(pri);
    real_cell_id_final(cnt_cnt)=sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(pri);
    x_coord(cnt_cnt)=soma_coord(1)+realx(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(pri));
    y_coord(cnt_cnt)=soma_coord(2)+realy(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(pri));
    z_coord(cnt_cnt)=soma_coord(3)+realz(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(pri));
    cnt_cnt=cnt_cnt+1;

end

end

clear dta real_cell_id ind_find cell_id data_soma eliminate eli_a rdist_a x_final_a y_final_a z_final_a x1a y1a z1a net_ad_x1a net_ad_y1a net_ad_z1a intx inty intz soma_coord 

end

adf=unique(real_cell_id_final);

tru_id=1:length(realx);
tru_id(adf)=[];

% x_c=realx(adf);
% y_c=realy(adf);
% z_c=realz(adf);
% 
% dist=sqrt(((x_c-elec_x).^2)+((y_c-elec_y).^2)+((z_c-elec_z).^2));


% save x_c_0_15.mat x_c
% save y_c_0_15.mat y_c
% save z_c_0_15.mat z_c


figure(1)
plot3(realx(adf),realz(adf),realy(adf),'.r','Markersize',6)
hold on
for i=1:length(tru_id)
    
    if tru_id(i)>=1 && tru_id(i)<=450
        plot3(realx(tru_id(i)),realz(tru_id(i)),realy(tru_id(i)),'.m','Markersize',1)
hold on
    elseif tru_id(i)>=451 && tru_id(i)<=2690 
        plot3(realx(tru_id(i)),realz(tru_id(i)),realy(tru_id(i)),'.','Color',[251 177 23]/255,'Markersize',1)
        hold on
        
    elseif tru_id(i)>=2691 && tru_id(i)<=3910
        plot3(realx(tru_id(i)),realz(tru_id(i)),realy(tru_id(i)),'.','Color',[0 100 0]/255,'Markersize',1)
        hold on
        
    elseif tru_id(i)>=3911 && tru_id(i)<=4680
        plot3(realx(tru_id(i)),realz(tru_id(i)),realy(tru_id(i)),'.b','Markersize',1)
        hold on
        
    else
         plot3(realx(tru_id(i)),realz(tru_id(i)),realy(tru_id(i)),'.','Color',[169 169 169]/255,'Markersize',1)
        hold on
    end
end
hold off
view(3)
axis equal
set(gcf,'color','w');
% xlabel('right <-> left (mm)')
% ylabel('posterior <-> anterior (mm)')
% zlabel('inferior <-> superior (mm)')





