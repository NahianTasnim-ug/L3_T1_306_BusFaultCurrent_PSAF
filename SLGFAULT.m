function done=SLGFAULT(nb,ng,nl,nt)
%formation of positive sequence Ybus
Yp=YPOSITIVE2(nb,ng,nl,nt);
%formation of zero sequence Ybus
Yz=YZERO2(nb,ng,nl,nt);
%% formation of positive and negative sequence Zbus
Zp=inv(Yp);
Zn=Zp;
%formation of zero sequence Zbus
check=diag(Yz);
k=find(check==0)
if length(k)==0
    Zz=inv(Yz);
end
if length(k)~=0
    Zz=pinv(Yz);
end
%% preparation of pre-fault voltage vectors
xxx=ones(nb);
vp0=xxx(:,1);
yyy=zeros(nb);
vn0=yyy(:,1);
vz0=vn0;
%calculation of fault current
fid=fopen('faultdata.txt','r');
b=textread('faultdata.txt');
fclose(fid);
bus=b(1);
imp=b(3);
ifp=vp0(bus)/((Zp(bus,bus)+Zn(bus,bus)+Zz(bus,bus)+3*imp)*j);
ifn=ifp;
ifz=ifp;
%% post fault voltage calculations
for i=1:nb
    vpf(i)=vp0(i)-Zp(i,bus)*ifp*j;
    vnf(i)=vn0(i)-Zn(i,bus)*ifn*j;
    vzf(i)=vz0(i)-Zz(i,bus)*ifz*j;
end
vpf_mag=abs(vpf);
vpf_phase=angle(vpf);
vnf_mag=abs(vnf);
vnf_phase=angle(vnf);
vzf_mag=abs(vzf);
vzf_phase=angle(vzf);


%% data entry into output file
fid=fopen('output.txt','w');
fprintf(fid,'The positive sequence Ybus\n\n');
for i=1:nb
    for k=1:nb
        fprintf(fid,'%-10.3f\t',Yp(i,k));
    end
    fprintf(fid,'\n\n');
end
fprintf(fid,'The positive sequence Zbus\n\n');
for i=1:nb
    for k=1:nb
        fprintf(fid,'%-10.3f\t',Zp(i,k));
    end
    fprintf(fid,'\n\n');
end

fprintf(fid,'The zero sequence Ybus\n\n');
for i=1:nb
    for k=1:nb
        fprintf(fid,'%-10.3f\t',Yz(i,k));
    end
    fprintf(fid,'\n\n');
end
fprintf(fid,'The zero sequence Zbus\n\n');
for i=1:nb
    for k=1:nb
        fprintf(fid,'%-10.3f\t',Zz(i,k));
    end
    fprintf(fid,'\n\n');
end

fprintf(fid,'Fault current\n\n');
fprintf(fid,'Magnitude   Angle(radians)\n');
fprintf(fid,'I1\n');
fprintf(fid,'%-10.3f %-10.3f\n\n',abs(ifp),angle(ifp));
fprintf(fid,'I2\n');
fprintf(fid,'%-10.3f %-10.3f\n\n',abs(ifn),angle(ifn));
fprintf(fid,'I0\n');
fprintf(fid,'%-10.3f %-10.3f\n\n',abs(ifz),angle(ifz));
fprintf(fid,'Printing of sequence components\n');
fprintf(fid,'Post Fault Voltages\n\n');
fprintf(fid,'Bus-number  Pos-seq-Magnitude  Pos-seq-Angle(radians)  Neg-seq-Magnitude  Neg-seq-Angle(radians)  Zero-seq-Magnitude  Zero-seq-Angle(radians)\n');
for i=1:length(vpf)
    fprintf(fid,'%-10.3f  %-10.3f  %-10.3f  %-10.3f  %-10.3f  %-10.3f  %-10.3f\n',i,abs(vpf(i)),vpf_phase(i),abs(vnf(i)),vnf_phase(i),abs(vzf(i)),angle(vzf(i)));
end

fprintf(fid,'\n\n');
fclose(fid);

done=1;