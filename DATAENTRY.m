function x=DATAENTRY(nb,ng,nl,nt)

%% entry of generator data
for i=1:ng
    disp('data entry for generator');
    disp(i);
    gen_bus(i)=input('enter the bus number at which the generator is connected: ');
    pos_gen(i)=input('enter the positive/negative sequence impedance of the generator: ');
    zero_gen(i)=input('enter the zero sequence impedance of the generator: ');
    gen_ground(i)=input('if the generator is grounded enter the grounding impedance and if ungrounded enter 1000: ');
end
gen_bus; %CHECK
gen=[gen_bus' pos_gen' zero_gen' gen_ground'];
gen=gen'; %each column is a single gen
fid=fopen('gendata.txt','w');
fprintf(fid,'%6.2f %6.2f %6.2f %6.2f\n',gen);
fclose(fid);

%% entry of line data
for i=1:nl
    disp('data entry for line');
    disp(i);
    start_bus(i)=input('enter the starting bus number: ');
    end_bus(i)=input('enter the ending bus number: ');
    pos_line(i)=input('enter the positive/negative sequence impedance of the line: ');
    zero_line(i)=input('enter the zero sequence impedance of the line: ');

   

end


linedata=[start_bus' end_bus' pos_line' zero_line'];
linedata=linedata'; %each column is a single line
fid=fopen('linedata.txt','w');

fprintf(fid,'%6.2f %6.2f %6.2f %6.2f\n',linedata);

fclose(fid);

%% entry of transformer data
for i=1:nt
    disp('data entry for transformer');
    disp(i)
    hv_bus(i)=input('enter the HV bus of the transformer');
    hv_code(i)=input('enter the connection code [0: Y grounded; 1:Y ungrounded; 2:delta');
    lv_bus(i)=input('enter the LV bus of the transformer');
    lv_code(i)=input('enter the connection code [0: Y grounded; 1: Y ungrounded; 2: delta]');
    pos_trans(i)=input('enter the positive/negative sequence impedance of the transformer');
    zero_trans(i)=input('enter the zero sequence impedance of the transformer');
end
transdata=[hv_bus' hv_code' lv_bus' lv_code' pos_trans' zero_trans'];
transdata=transdata'; %each column is a single trans
fid=fopen('transformerdata.txt','w');
fprintf(fid,'%6.2f %6.2f %6.2f %6.2f %6.2f %6.2f\n',transdata);
fclose(fid);
