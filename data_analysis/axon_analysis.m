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

cell_id=1:cell_cnt(id);

intx=load(['intx_' num2str(id) '.dat']);
inty=load(['inty_' num2str(id) '.dat']);
intz=load(['intz_' num2str(id) '.dat']);

x_axon=load(['x_axon_' num2str(id) '.dat']);
y_axon=load(['y_axon_' num2str(id) '.dat']);
z_axon=load(['z_axon_' num2str(id) '.dat']);

% soma_coord=load(['soma_coord_' num2str(id) '.dat']);

load(['data_axon' num2str(id) '.mat']);

elec_x=200;
elec_y=1000;
elec_z=200;

eli_a=[];
eliminate=[];

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
if ~isempty(data_axon(i).times)
    for j=1:length(data_axon(i).times)
        for k=1:length(data_axon(i).times{1,j})
if data_axon(i).times{1,j}(k) >=209
    data_axon(i).times{1,j}(k)=[];
end
end
end
end
end

real_cell_id=[];

cnt=1;
for i=1:cell_cnt(id)
if ~isempty(data_axon(i).times{1,1})
        for j=1:length(data_axon(i).times)
dta(cnt).times{1,j}=sort(data_axon(i).times{1,j})-201;
        end
        real_cell_id(cnt)=cell_id(i); 
        cnt=cnt+1;

end
end

if ~isempty(real_cell_id)

for i=1:length(dta)
    for j=1:length(dta(1).times)
        if ~isempty(dta(i).times{1,j})
        dta_temp(j)=dta(i).times{1,j}(1);
        else
            dta_temp(j)=NaN;
        end

    end
        dta_final(i,1)=min(dta_temp);
        dta_final(i,2)=find(dta_temp==min(dta_temp),1,'first');
        clear dta_temp
end

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
    dta_final(ind_find,:)=[];
    
end

for i=1:length(real_cell_id)
    
    net_ad_x1=(((realx(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i)))*cos(realang(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i))))-((realz(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i)))*sin(realang(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i)))))-(realx(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i)));
    net_ad_y1=(realy(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i)))-(realy(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i)));
    net_ad_z1=(((realx(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i)))*sin(realang(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i))))+((realz(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i)))*cos(realang(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i)))))-(realz(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i)));
    
    x1=((x_axon(dta_final(i,2))+realx(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i)))*cos(realang(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i))))-((z_axon(dta_final(i,2))+realz(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i)))*sin(realang(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i))));
    y1=y_axon(dta_final(i,2))+realy(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i));
    z1=((x_axon(dta_final(i,2))+realx(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i)))*sin(realang(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i))))+((z_axon(dta_final(i,2))+realz(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i)))*cos(realang(sum(cell_cnt(1:id))-cell_cnt(id)+real_cell_id(i))));

    x_final=x1-net_ad_x1;
    y_final=y1-net_ad_y1;
    z_final=z1-net_ad_z1;
    
%     real_cell_id_final_1(cnt_cnt)=real_cell_id(i);
    x_coord(cnt_cnt)=x_final;
    y_coord(cnt_cnt)=y_final;
    z_coord(cnt_cnt)=z_final;
    cnt_cnt=cnt_cnt+1;

    
    clear net_ad_x1 net_ad_y1 net_ad_z1 x1 y1 z1 x_final y_final z_final 
end

end

clear eliminate eli eli_a x_axon y_axon z_axon intx inty intz data_axon dta dta_final real_cell_id cell_id  


end

% load('real_cell_id_final.mat');
% 
% for bd=1:length(real_cell_id_final)
%     ijk(bd)=find(real_cell_id_final_1==real_cell_id_final(bd));
% end

tru_id=1:1:length(realx);

% dist=sqrt(((x_coord-elec_x).^2)+((y_coord-elec_y).^2)+((z_coord-elec_z).^2));


figure(1)
plot3(x_coord,z_coord,y_coord,'.r','Markersize',8)
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
hold off
view(3)
axis equal
set(gcf,'color','w');
