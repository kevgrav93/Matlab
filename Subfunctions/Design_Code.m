% Latest Revision: 30/10/2018

% =========================================================================
% Main design function. Executes all the analysis calculations and outputs
% calculate dimensions to text files for solidworks. Also outputs values
% and useful information to a log text file which is printed in the GUI
% window.
% =========================================================================

function Design_Code(horizontal_speed, depth, mission_time)
    %Check if this script is runned directly (not from MAIN.m)
    if ~exist('depth','var')
        cd 'Z:\2018\MCG4322A\Digital Files\SUB_1A\Matlab\'
        run MAIN.m; %Run MAIN.m instead
        return
    end
    
    %***text file paths***
    %LOG text file to be modified
    log_file = 'Z:\2018\MCG4322A\Digital Files\SUB_1A\Log\SUB_1A_LOG.TXT';
    %Solidworks file paths
    
    %***Enviroment constants***
    pho = 1027; %sea water average density (m3/kg)
    g = 9.81; %Gravitational acceleration (m/s^2)
    p_atm = 101000; %101kpa atmospheric pressure
    wave_height = 0.5; %0.5m waves (sea state 2 maximum)

    %***Submersible constants***
    crew =2; %2 operators
    life_support_time = 96; %96 hours required CO2 scrubber material

    %***Calculations***
    Horizontal_Max_Thrust = Horizontal_Thrust_Max_Speed(horizontal_speed,pho);
    Battery_Size = Battery_Size_Calculator(mission_time, Horizontal_Max_Thrust, Horizontal_Max_Thrust);
    
    Max_pressure = pho*g*depth; %Pressure at maximum depth in Pa.
    
   
    %{
    ***Write the log file (Note: This file is not used by SOLIDWORKS. 
    The contents of the file is outputted in the GUI. Useful for DEBUGGING***
    %}
    fid = fopen(log_file,'w+t');
	fprintf(fid,'***Personal Submersible Design***\n');
    fprintf(fid,strcat('Rated Depth =',32,num2str(depth),' meters.\n'));
    fprintf(fid,strcat('The pressure at maximum depth is :',32,num2str(Max_pressure/1000),' kPa.\n'));
	fprintf(fid,strcat('Maximum Speed =',32,num2str(horizontal_speed),' knots.\n'));
    fprintf(fid,strcat('The maximum mission time is :',32,num2str(mission_time),' hours.\n'));
    fprintf(fid,strcat('The required battery size is :',32,num2str(Battery_Size),' watt-hours.\n'));
	fclose(fid);
    
end

%Calculates the required force to keep the submersible moving at maximum
%speed. Flow is turbulent as per calculations in the modelling report.
function Max_Thruster_Power = Horizontal_Thrust_Max_Speed(horizontal_speed, pho)
    maximum_speed=horizontal_speed*0.51444444; %knots to m/s
    cf_cylinder = 0.0037; %skin friction drag coefficient soft tanks
    cf_sphere = 0.0032; %skin friction drag coefficient pressure hull
    cd_sphere=0.35; %sphere drag coefficient
    area1 = 2.54; %Frontal area of the sphere shaped pressure hull
    area2 = 8.80; %Wetted area of the cylinder shaped soft tank
    area3 = 10.18; %Weeted area of the sphere shaped pressure hull

    %Drag forces acting on submersible
    f_pressure_sphere_max = 0.5*cd_sphere*pho*maximum_speed^2*area1; 
    f_skin_cylinder_max = 0.5*cf_cylinder*pho*maximum_speed^2*area2; 
    f_skin_sphere_max = 0.5*cf_sphere*pho*maximum_speed^2*area3;

    %Thrust required to keep submersible moving at maximum speed
    power_max_speed = f_pressure_sphere_max+2*f_skin_cylinder_max+f_skin_sphere_max; %thrusters thrust required at max speed
    Max_Thruster_Power = power_max_speed/4; %4 horizontal thrusters
end