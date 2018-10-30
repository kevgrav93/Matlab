clear all; close all; clc
x = linspace(0,1000);
pho = 1027;
g = 9.81;
y = pho*g*x;
plot(x,y)
grid on
grid minor
ax=gca;
ax.GridAlpha=0.3;
title('Sea water pressure as a function of the depth')
ylabel('Pressure (Pa)')
xlabel('Depth (Meters)')