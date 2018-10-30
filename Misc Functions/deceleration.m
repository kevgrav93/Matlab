function deceleration = f(v,t)
pho = 1027; %sea water density
thrust = 0; %90% of maximum thrust in reverse
m= 5891; %submarine mass with crew
cf_cylinder = 0.0037; %skin friction drag coefficient soft tanks
cf_sphere = 0.0032; %skin friction drag coefficient pressure hull
cd_sphere=0.35; %sphere drag coefficient
area1 = 2.54; %Frontal area of the sphere shaped pressure hull
area2 = 8.80; %Wetted area of the cylinder shaped soft tank\
area3 = 10.18; %Weeted area of the sphere shaped pressure hull

f_pressure_sphere = 0.5*cd_sphere*pho*v^2*area1; 
f_skin_cylinder = 0.5*cf_cylinder*pho*v^2*area2; 
f_skin_sphere = 0.5*cf_sphere*pho*v^2*area3;

deceleration =(-f_pressure_sphere-2*f_skin_cylinder-f_skin_sphere*2-thrust)/m;
end