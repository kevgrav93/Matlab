clear all; close all; clc
t = linspace(0,1000);
y0 = 3.1;
z = ode45(@(v,t)deceleration(t,v),t,y0);
time = z.x;
y = z.y;

plot(time,y)
grid on
grid minor
ax=gca;
ax.GridAlpha=0.3;
title('Deceleration from 3.1m/s up to rest')
ylabel('Speed (m/s)')
xlabel('Time (seconds)')
ylim([-1,4]);