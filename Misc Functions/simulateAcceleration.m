function []=simulateAcceleration(speed)
%clear all; close all; clc
t = linspace(0,20);
y0 = 0;
z = ode45(@(v,t)acceleration(t,v,speed),t,y0);
time = z.x;
y = z.y;

figure;
plot(time,y)
grid on
grid minor
ax=gca;
ax.GridAlpha=0.3;
title('Acceleration from rest up to 3.1m/s')
ylabel('Speed (m/s)')
xlabel('Time (seconds)')
end