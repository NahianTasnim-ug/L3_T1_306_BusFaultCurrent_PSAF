function Yp = YPOSITIVE2(nb, ng, nl, nt)

%% Initialize Yp matrix
Yp = zeros(nb);

%% Incorporation of elements corresponding to line impedances

fid=fopen('linedata.txt','r');
bb=textread('linedata.txt');
fclose(fid);
x=bb(:,1);
y=bb(:,2);
zp=bb(:,3);

for i = 1:nl
    from_bus = x(i);
    to_bus = y(i);
    
    % Add positive sequence impedance to Yp matrix
    Yp(from_bus, from_bus) = Yp(from_bus, from_bus) + 1/zp(i);
    Yp(to_bus, to_bus) = Yp(to_bus, to_bus) + 1/zp(i);
    Yp(from_bus, to_bus) = Yp(from_bus, to_bus) - 1/zp(i);
    Yp(to_bus, from_bus) = Yp(to_bus, from_bus) - 1/zp(i);
end

%% Incorporation of generator elements

gendata = load('gendata.txt');

for i = 1:ng
    gen_bus = gendata(i, 1);
    pos_gen = gendata(i, 2);
    gnd = gendata(i,4);
    
% Add generator positive sequence impedance to Yp matrix
    Yp(gen_bus, gen_bus) = Yp(gen_bus, gen_bus) + 1/pos_gen;
     
end

%% Incorporation of transformer elements


fid=fopen('transformerdata.txt','r');
bb=textread('transformerdata.txt');
fclose(fid);
x=bb(:,1);
y=bb(:,3);
hvx=bb(:,2);
lvx=bb(:,4);
z_pos = bb(:,5);
for i=1:length(x)
    if hvx(i)==0 & lvx(i)==0 %represents the case of grounded star at both ends
        Yp(x(i),x(i))=Yp(x(i),x(i))+1/z_pos(i);
        Yp(y(i),y(i))=Yp(y(i),y(i))+1/z_pos(i);
        Yp(x(i),y(i))=Yp(x(i),y(i))+(-1)*1/z_pos(i);
        Yp(y(i),x(i))=Yp(y(i),x(i))+(-1)*1/z_pos(i);
    end
    
    if hvx(i)==0 & lvx(i)==1 %represents the case of grounded star and ungrounded star
        Yp(x(i),x(i))=Yp(x(i),x(i))+0;
        Yp(y(i),y(i))=Yp(y(i),y(i))+0;
        Yp(x(i),y(i))=Yp(x(i),y(i))+0;
        Yp(y(i),x(i))=Yp(y(i),x(i))+0;
    end
    
    if hvx(i)==0 & lvx(i)==2 %represents the case of grounded star and delta
        Yp(x(i),x(i))=Yp(x(i),x(i))+1/z_pos(i);  %CHECK
        Yp(y(i),y(i))=Yp(y(i),y(i))+0;
        Yp(x(i),y(i))=Yp(x(i),y(i))+0;
        Yp(y(i),x(i))=Yp(y(i),x(i))+0;
    end
    
    if hvx(i)==1 & lvx(i)==0 %represents the case of ungrounded star and grounded star
        Yp(x(i),x(i))=Yp(x(i),x(i))+0;
        Yp(y(i),y(i))=Yp(y(i),y(i))+0;
        Yp(x(i),y(i))=Yp(x(i),y(i))+0;
        Yp(y(i),x(i))=Yp(y(i),x(i))+0;
    end
    
    if hvx(i)==1 & lvx(i)==1 %represents the case of ungrounded star at both ends
        Yp(x(i),x(i))=Yp(x(i),x(i))+0;
        Yp(y(i),y(i))=Yp(y(i),y(i))+0;
        Yp(x(i),y(i))=Yp(x(i),y(i))+0;
        Yp(y(i),x(i))=Yp(y(i),x(i))+0;
    end
    
    if hvx(i)==1 & lvx(i)==2 %represents the case of ungrounded star and delta
        Yp(x(i),x(i))=Yp(x(i),x(i))+0;
        Yp(y(i),y(i))=Yp(y(i),y(i))+0;
        Yp(x(i),y(i))=Yp(x(i),y(i))+0;
        Yp(y(i),x(i))=Yp(y(i),x(i))+0;
    end
    
    if hvx(i)==2 & lvx(i)==0 %represents the case of delta and grounded star
        Yp(x(i),x(i))=Yp(x(i),x(i))+0;
        Yp(y(i),y(i))=Yp(y(i),y(i))+0;
        Yp(x(i),y(i))=Yp(x(i),y(i))+0;
        Yp(y(i),x(i))=Yp(y(i),x(i))+1/z_pos(i);
    end
    
    if hvx(i)==2 & lvx(i)==1 %represents the case of delta and ungrounded star
        Yp(x(i),x(i))=Yp(x(i),x(i))+0;
        Yp(y(i),y(i))=Yp(y(i),y(i))+0;
        Yp(x(i),y(i))=Yp(x(i),y(i))+0;
        Yp(y(i),x(i))=Yp(y(i),x(i))+0;
    end
    
    if hvx(i)==2 & lvx(i)==2 %represents the case of delta at both ends
        Yp(x(i),x(i))=Yp(x(i),x(i))+0;
        Yp(y(i),y(i))=Yp(y(i),y(i))+0;
        Yp(x(i),y(i))=Yp(x(i),y(i))+0;
        Yp(y(i),x(i))=Yp(y(i),x(i))+0;
    end
end




