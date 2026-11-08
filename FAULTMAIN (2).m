clear all;
clc;
%% main program for the fault analysis package
disp('DETERMINATION OF FAULTS IN POWER SYSTEM');
nb=input('enter the number of buses: ');
ng=input('enter the number of generators: ');
nl=input('enter the number of lines: ');
nt=input('enter the number of transformers: ');

%% the following section determines choice of function
choice=input('enter your choice 1) data entry 2) fault analysis\n');
if choice==1
    DATAENTRY(nb,ng,nl,nt);

end


if choice==2

    %% entry of fault data
    fault_bus=input('enter the faulted bus number: ');

    disp('1)Single line to ground fault');

    disp('2)Line to line fault with ground');

    fault_type=input('Enter the type of fault: ');
    fault_imp=input('Enter the fault impedance: ');
    fault=[fault_bus fault_type fault_imp];
    fid=fopen('faultdata.txt','w');
    fprintf(fid,'%6.2f %6.2f %6.2f\n',fault);
    fclose(fid);

    fid=fopen('faultdata.txt','r');
    b=textread('faultdata.txt');
    fclose(fid);

    if b(2)==1
        %SLG fault analysis
        done=SLGFAULT(nb,ng,nl,nt);
    end

    if b(2)==2
        %LLG fault analysis
        done=LLGFAULT(nb,ng,nl,nt);
    end
end

%%Check if the code ran
disp('The fault currents have been showed in the output file');