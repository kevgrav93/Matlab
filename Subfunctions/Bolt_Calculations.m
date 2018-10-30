%Inputs
L_Shank = 0; %Full threads
L_Thread_G = 28; %Bolt thread length
L_G = 40; %Length of threads female in part
D_Nom = 12; %Bolt diameter (mm)
P = 1.75; %Pitch (mm)
F_T = 10025.9; %Applied Tensile force
F_S = 0; %Applied Shear force
E = 68.9*10^3; %Threaded material elastic modulus (female thread)

%Bolt and properties
S_Ty = 482.6; %70,000PSI = 482.6MPa
S_Sy = 0.577*S_Ty;
E_Bolt = 190*10^3; %190GPa

%Initial Safety Factor
FS=1;

%Contants
K_T = 0.2;

%Areas
A_Nom = (pi/4)*D_Nom^2;
A_T = (pi/4)*(D_Nom-0.9382*P)^2;
A_S = (pi/4)*(D_Nom-1.1226869*P)^2;

%Preload
F_PL = 0.64*S_Ty*A_T; %Preload force
T_PL = K_T*D_Nom*F_PL/1000; %Preload torque

%Bolt and grip stiffness
K_Shank = (A_Nom*E_Bolt)/(L_Shank);
K_Thread = (A_T*E_Bolt)/(L_Thread_G);
K_Bolt = 1/((1/K_Shank)+(1/K_Thread));
K_Grip = (pi*E*D_Nom*tand(30))/(2*log(5*((L_G*tand(30)+0.5*D_Nom)/(L_G*tand(30)+2.5*D_Nom))));

%Stress calculation
C = K_Bolt/(K_Bolt+K_Grip);
Sigma_PL = F_PL/A_T;
Sigma_T = (C*F_T)/A_T;
Tau_SH = F_S/A_S;

%Seperation force
F_Sep = F_PL/(1-C);

%Iterate until von misses stress is greater than yeild strength of
%bolt(failure) to find safety factor
Sigma_VM = 0;
while(Sigma_VM < S_Ty)
Sigma_VM = sqrt((Sigma_PL+FS*Sigma_T)^2+3*FS*Tau_SH^2);
FS=FS+0.1;
end

FS=FS-0.2;
disp(FS);
