clear all
clear all
close all

a=400; 
b=400; 

depth1=(27*2000)/100; 
depth2=(12*2000)/100; 
depth3=(19*2000)/100; 
depth4=(35*2000)/100; 
depth5=(7*2000)/100; 

v1=(a/1000)*(b/1000)*(depth1/1000);
v2=(a/1000)*(b/1000)*(depth2/1000);
v3=(a/1000)*(b/1000)*(depth3/1000);
v4=(a/1000)*(b/1000)*(depth4/1000);
v5=(a/1000)*(b/1000)*(depth5/1000);

nn_1=(v1*20000)+2;
nn_2=(v2*20000)+2;
nn_3=(v3*20000)+4;
nn_4=v4*20000;
nn_5=(v5*20000)+2;



tot_cell_count=[(nn_5/5)*ones(1,5) (nn_4/5)*ones(1,5) (nn_3/5)*ones(1,5) (nn_2/5)*ones(1,5) (nn_1/5)*ones(1,5)];

n1 = bsxfun(@times, [a, b, depth1], rand(round(nn_1),3) );
n2 = bsxfun(@times, [a, b, depth2], rand(round(nn_2),3) );
n3 = bsxfun(@times, [a, b, depth3], rand(round(nn_3),3) );
n4 = bsxfun(@times, [a, b, depth4], rand(round(nn_4),3) );
n5 = bsxfun(@times, [a, b, depth5], rand(round(nn_5),3) );

% 3555
% 1535
% 2480
% 4605
% 905

x1=n1(:,1);
z1=n1(:,2);
y1=n1(:,3);

x2=n2(:,1);
z2=n2(:,2);
y2=540+n2(:,3);

x3=n3(:,1);
z3=n3(:,2);
y3=540+240+n3(:,3);

x4=n4(:,1);
z4=n4(:,2);
y4=540+240+380+n4(:,3);

x5=n5(:,1);
z5=n5(:,2);
y5=540+240+380+700+n5(:,3);

realx=fliplr([x1' x2' x3' x4' x5']);
realy=fliplr([y1' y2' y3' y4' y5']);
realz=fliplr([z1' z2' z3' z4' z5']);

rot_ran=2*pi*rand(1,length(realx));


figure(1)
plot3(realx,realz,realy,'.');
hold on
plot3(a/2,b/2,1000,'.r','Markersize',20);
hold on
plot3((a/2)+400,b/2,1000,'.r','Markersize',20);
hold off
view(3)
axis equal

% ELECx=400;
% ELECy=1000;
% ELECz=400;
% 
% cell_id=1:2000;
% 
% cnt=1;
% for k=1:length(x)
% rdist=(sqrt(((ELECx-(x(k)))^2)+(((ELECy-(y(k)))^2)+((ELECz-(z(k)))^2))));
% if rdist<15
% eli(cnt)=k;
% cnt=cnt+1;
% end
% end
% 
% eliminate=unique(eli);
% 
% x(eliminate)=[];
% y(eliminate)=[];
% z(eliminate)=[];
% rot_ran(eliminate)=[];

% save realx.dat realx -ascii
% save realy.dat realy -ascii
% save realz.dat realz -ascii
% save realang.dat rot_ran -ascii
% 
% save cell_cnt.dat tot_cell_count -ascii



% save realx.dat x -ascii
% save realy.dat y -ascii
% save realz.dat z -ascii
% 
% save realang.dat rot_ran -ascii



% x1=(((realx(11)+intx)*cos(pi))-((realz(11)+intz)*sin(pi)));
% y1=(realy(11)+inty);
% z1=(((realx(11)+intx)*sin(pi))+((realz(11)+intz)*cos(pi)));
% 
% net_ad_x1=x1(1,1)-(realx(11)+intx(1,1));
% net_ad_y1=y1(1,1)-(realy(11)+inty(1,1));
% net_ad_z1=z1(1,1)-(realz(11)+intz(1,1));
% 
% x_final=x1-net_ad_x1;
% y_final=y1-net_ad_y1;
% z_final=z1-net_ad_z1;
% 
% 
% figure(1)
% % plot3(x(11)+intx,z(11)+intz,y(11)+inty,'.k')
% plot(x(11)+intx,y(11)+inty,'.k')
% hold on
% % plot3(x1-net_ad_x1,z1-net_ad_z1,y1-net_ad_y1,'.r')
% plot(x1-net_ad_x1,y1-net_ad_y1,'.r')
% hold on
% plot3(0,0,0,'.r','Markersize',20)
% hold off
% % hold on
% % plot3(xe,ye,ze,'.k','Markersize',10)
% % hold off
% axis equal
% % xlim([-2000 2000])
% % ylim([-2000 2000])
% % zlim([-2000 2000])
% xlabel('x (\mum)')
% ylabel('y (\mum)')
% zlabel('z (\mum)')