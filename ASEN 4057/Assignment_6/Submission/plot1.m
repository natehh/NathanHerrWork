%Weston Luke HW6 3/14/19
clear
clc
load Optimum_1_10000_0p5.txt
sx=Optimum_1_10000_0p5(:,1);
sy=Optimum_1_10000_0p5(:,2);
mx=Optimum_1_10000_0p5(:,3);
my=Optimum_1_10000_0p5(:,4);
%plot circle
r=6371000;
t=(0:pi/150:2*pi);
a=r*cos(t);
b=r*sin(t);
hold on
title('minimum fuel trajectory')
xlabel('x distance (miles)') 
ylabel('y distance (miles)') 
plot(a,b)
%plot moon
plot(mx,my)
%plot space craft
plot(sx,sy)
legend({'earth','Moon','spacecraft'},'Location','southeast')
hold off