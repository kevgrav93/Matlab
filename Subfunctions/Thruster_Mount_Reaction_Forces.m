F_T = 2450; %Thruster force

%distance variables from solidworks
Y1 = 0.045; 
Y2 = 0.13915; 

%Top flange calculations

F_B = (F_T*Y2)/Y1; %Sum of moments in  around A to solve for F_B
F_D = F_B;

F_A = F_B+F_T; %Sum of forces in Y to find F_A
F_C = F_A;