%This function is the main "design" function.
function Design_code(axial_force, number_of_weights, shaft_length)
    %Check if the user tries to run this file directly
    if ~exist('axial_force','var')
        cd Z:\groupABC\MATLAB\
        run Z:\groupABC\MATLAB\Main.m; %Run Main.m instead
        return
    end
    
    %DESIGN CALCULATIONS done here. Feel free to use as many subfunctions as necessary.
    
    default_diameter = 0.5; %Units (mm). Sets an initial diameter value.
    strength_al = 31; %Units (MPa). Assuming 1100-0 Al alloy, 
                           %Source: Fundamentals of Machine Component Design” Robert C. Juvinall and Kurt M, Marshek, Wiley; 5th edition.
    
    new_diameter = calc_shaft_diameter(default_diameter, strength_al, axial_force, number_of_weights, shaft_length); %A call to a subfunction to calculate the new shaft diameter.

    %Declaring text files to be modified
    %Files
    log_file = 'Z:\\groupABC\\Log\\groupABC_LOG.TXT';
    shaft_file = 'Z:\\groupABC\\SolidWorks\\Equations\\shaft.txt';
        
	%Write the log file (NOT USED BY SOLIDWORKS, BUT USEFUL TO DEBUG PROGRAM AND REPORT RESULTS IN A CLEAR FORMAT)
	%Please only create one log file for the complete project but try to keep the file easy to read by adding blank lines and sections...
    fid = fopen(log_file,'w+t');
	fprintf(fid,'***Shaft Design***\n');
    fprintf(fid,strcat('Axial force =',32,num2str(axial_force),' (kN).\n'));
	fprintf(fid,strcat('Shaft length =',32,num2str(shaft_length),' (mm).\n'));
	fprintf(fid,strcat('There will be',32,num2str(number_of_weights),' weights on the end of the shaft.\n'));
    fprintf(fid,strcat('We assume that the shaft is made of 1100-0 Aluminm alloy.\n'));
    fprintf(fid,strcat('Optimized shaft diameter =',32,num2str(new_diameter),' (mm).\n'));
	fclose(fid);

	%Write the equations file(s) (FILE(s) LINKED TO SOLIDWORKS).
	%You can make a different file for each section of your project (ie one for steering, another for brakes, etc...)
	%or one single large file that includes all the equations. Its up to you!
    fid = fopen(shaft_file,'w+t');
    fprintf(fid,strcat('"Diameter"=',num2str(new_diameter),'\n'));
    fprintf(fid,strcat('"Length"=',num2str(shaft_length),'\n'));
    fclose(fid);
end

%An example of subfunction. 
%Make note that the inputs within the paranthesis have different names than
%the arguments named in the function call. Names themselves do not matter,
%as only the data they contain in passed.
function new_diameter = calc_shaft_diameter(diameter, str, axial_force, number_of_weights, shaft_length)

	%Eq. (##) <- Add a reference to the equation in your report.
    %In this case, we calculate the Von Mises stress from inputs. Ignore
    %Torque input (as it is zero for this example).
	
    force = number_of_weights*10; %Units (kN)
    n = 0;   %Initial safety factor
    
    %Optimization loop, change diameter until safety factor 'n' > 1.5
    while n<1.5
        diameter = diameter + 0.001;
        stress = (((4*axial_force)/(pi*(diameter^2)))+((32*force*shaft_length)/(pi*(diameter^3))));    
        n = str/stress;
    end
    
    new_diameter = diameter;
end