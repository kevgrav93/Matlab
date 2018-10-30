% Latest Revision: 30/10/2018

% =========================================================================
% Main lithium-ion battery size calculation based on required thruster power, 
% other electronics current draw and the total mission time 
% =========================================================================
function Battery_Size = Battery_Size_Calculator(Mission_Time, Horizontal_Thruster_Power_Max, Vertical_Thruster_Power_Max)
    %Electronics current and voltages
    CO2_Scrubber_Amp =2; %https://www.amronintl.com/ihchytech-carbon-dioxide-scrubber-with-canister-and-bracket-external-speed-control.html
    CO2_Scrubber_Volt =24; %https://www.amronintl.com/ihchytech-carbon-dioxide-scrubber-with-canister-and-bracket-external-speed-control.html
    CO2_Scrubber_Power=CO2_Scrubber_Amp*CO2_Scrubber_Volt;

    External_Lights_Power = External_Lights_Amp_Calculation;
    Internal_Lights_Power = Internal_Lights_Amp_Calculation;

    %Electric_Fans_Amp =;
    %Electric_Fans_Volt =;

    %Thrusters power IN required
    Thruster_Power = Thruster_Power_Calculation(Horizontal_Thruster_Power_Max, Vertical_Thruster_Power_Max);

    Total_Power = CO2_Scrubber_Power + External_Lights_Power + Internal_Lights_Power + Thruster_Power;

    Battery_Size = (Total_Power*Mission_Time); %watt-hour
end

function Power = External_Lights_Amp_Calculation
    DeepSea_Power = 106; %106W at 24V for LSL2000
    Burns_Power = 500; %Model 32E-016

    Power = 2*DeepSea_Power+2*Burns_Power; %watts 
end

function Power = Internal_Lights_Amp_Calculation
    Power = 50; %watts
end

function Power = Thruster_Power_Calculation(Horizontal_Thruster_Power_Max, Vertical_Thruster_Power_Max) 
    Power = Horizontal_Thruster_Power_Max*4+Vertical_Thruster_Power_Max*2; %watts
end