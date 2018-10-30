F_X =0;
F_Y =4900;
d = 199.15;
F_Z =0;
M_X = F_Y*d; %Nmm

H = 100;%Height of weld group
%L = %Length of weld
a = 3;%Weld throat thickness
B = 140; %Width of weld group

R_Y = H/2; %(mm)
R_X = H/2; %(mm)

%For 5th shape in table at mitcalc website
Y = (H^2)/(2*H+B);%Center of graity
A_W = 0.707*a*(2*H+B); %Per shigley
I_Wx = (2*H^3)/3-2*H^2*Y+(B+2*H)*Y^2; %Per shigley

Sigma_Per = (M_X*R_Y)/I_Wx;
Tau_Par = F_Y/A_W;

S_W = sqrt(Sigma_Per^2+Tau_Par^2);