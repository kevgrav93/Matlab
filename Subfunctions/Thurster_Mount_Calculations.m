max_thrust_force = 2500;
Ft = max_thrust_force/8;
flange_t = 12; %12mm flange thcikness for weld calculations
weld_h = 3; %3mm Weld throat, might change depending on safety factor
weld_l = 0.34886; %Weld length = flange length
Sy = 276*10^6; %Aluminum 6061 T6 Yield Strength
Bolt_Sy = 482.6*10^6; %482.6MPa from mcmasster carr (316 SS)

%Top flange distance variables from solidworks
x1 = 0.02906; 
x2 = 0.1516; 
x3 = 0.2278; 
x4 = 0.35034;
x5 = 0.3794;
y1 = 0.0381; 
y2 = 0.16064; 

%Bottom flange distance variables from solidworks
y3 = 0.190;
y4 = 0.1519;
y5 = 0.02936;

%Top flange calculations
Fb_y = (Ft*(x1+x2+x3+x4))/x5; %Sum of moments around A in Z
Fa_y = Ft*4-Fb_y; %Sum of forces in Y

Ma_x = (2*Ft*y1+2*Ft*y2)/2;
Mb_x = Ma_x;

%Bottom flange calculations

MWeld_x = Ma_x+Mb_x+2*Ft*y4+2*Ft*y5+(Fa_y+Fb_y)*y3;
FWeld_y = 4*Ft+Fa_y+Fb_y;

%Weld calculations
SF = 70001; %initialise SF
while SF>70000
sigma = (3*MWeld_x*flange_t)/(weld_l*weld_h*(3*flange_t^2-6*flange_t*weld_h+4*weld_h^2));
tau = FWeld_y/(weld_l*weld_h);

sigma_total = sqrt(sigma^2+3*tau^2);

SF = Sy/sigma_total; %Safety factor of weld
weld_h=weld_h-0.1;
end

