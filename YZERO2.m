function Yz = YZERO2(nb, ng, nl, nt)

Yz = zeros(nb);

%% Incorporation of elements corresponding to line impedances
fid = fopen('linedata.txt', 'r');
bb = textread('linedata.txt');
fclose(fid);

x = bb(:, 1);
y = bb(:, 2);
zp = bb(:, 4);
for i = 1:length(x)
    Yz(x(i), x(i)) = Yz(x(i), x(i)) + 1/zp(i);
    Yz(y(i), y(i)) = Yz(y(i), y(i)) + 1/zp(i);
    Yz(x(i), y(i)) = Yz(x(i), y(i)) - 1/zp(i);
    Yz(y(i), x(i)) = Yz(y(i), x(i)) - 1/zp(i);
end

%% incorporation of elements corresponding to transformers
fid=fopen('transformerdata.txt','r');
bb=textread('transformerdata.txt');
fclose(fid);
x=bb(:,1);
y=bb(:,3);
hvx=bb(:,2);
lvx=bb(:,4);
z=bb(:,6);
for i=1:length(x)
    if hvx(i)==0 & lvx(i)==0 %represents the case of grounded star at both ends
        Yz(x(i),x(i))=Yz(x(i),x(i))+1/z(i);
        Yz(y(i),y(i))=Yz(y(i),y(i))+1/z(i);
        Yz(x(i),y(i))=Yz(x(i),y(i))+(-1)*1/z(i);
        Yz(y(i),x(i))=Yz(y(i),x(i))+(-1)*1/z(i);
    end
    
    if hvx(i)==0 & lvx(i)==1 %represents the case of grounded star and ungrounded star
        Yz(x(i),x(i))=Yz(x(i),x(i))+0;
        Yz(y(i),y(i))=Yz(y(i),y(i))+0;
        Yz(x(i),y(i))=Yz(x(i),y(i))+0;
        Yz(y(i),x(i))=Yz(y(i),x(i))+0;
    end
    
    if hvx(i)==0 & lvx(i)==2 %represents the case of grounded star and delta
        Yz(x(i),x(i))=Yz(x(i),x(i))+1/z(i);
        Yz(y(i),y(i))=Yz(y(i),y(i))+0;
        Yz(x(i),y(i))=Yz(x(i),y(i))+0;
        Yz(y(i),x(i))=Yz(y(i),x(i))+0;
    end
    
    if hvx(i)==1 & lvx(i)==0 %represents the case of ungrounded star and grounded star
        Yz(x(i),x(i))=Yz(x(i),x(i))+0;
        Yz(y(i),y(i))=Yz(y(i),y(i))+0;
        Yz(x(i),y(i))=Yz(x(i),y(i))+0;
        Yz(y(i),x(i))=Yz(y(i),x(i))+0;
    end
    
    if hvx(i)==1 & lvx(i)==1 %represents the case of ungrounded star at both ends
        Yz(x(i),x(i))=Yz(x(i),x(i))+0;
        Yz(y(i),y(i))=Yz(y(i),y(i))+0;
        Yz(x(i),y(i))=Yz(x(i),y(i))+0;
        Yz(y(i),x(i))=Yz(y(i),x(i))+0;
    end
    
    if hvx(i)==1 & lvx(i)==2 %represents the case of ungrounded star and delta
        Yz(x(i),x(i))=Yz(x(i),x(i))+0;
        Yz(y(i),y(i))=Yz(y(i),y(i))+0;
        Yz(x(i),y(i))=Yz(x(i),y(i))+0;
        Yz(y(i),x(i))=Yz(y(i),x(i))+0;
    end
    
    if hvx(i)==2 & lvx(i)==0 %represents the case of delta and grounded star
        Yz(x(i),x(i))=Yz(x(i),x(i))+0;
        Yz(y(i),y(i))=Yz(y(i),y(i))+0;
        Yz(x(i),y(i))=Yz(x(i),y(i))+0;
        Yz(y(i),x(i))=Yz(y(i),x(i))+1/z(i);
    end
    
    if hvx(i)==2 & lvx(i)==1 %represents the case of delta and ungrounded star
        Yz(x(i),x(i))=Yz(x(i),x(i))+0;
        Yz(y(i),y(i))=Yz(y(i),y(i))+0;
        Yz(x(i),y(i))=Yz(x(i),y(i))+0;
        Yz(y(i),x(i))=Yz(y(i),x(i))+0;
    end
    
    if hvx(i)==2 & lvx(i)==2 %represents the case of delta at both ends
        Yz(x(i),x(i))=Yz(x(i),x(i))+0;
        Yz(y(i),y(i))=Yz(y(i),y(i))+0;
        Yz(x(i),y(i))=Yz(x(i),y(i))+0;
        Yz(y(i),x(i))=Yz(y(i),x(i))+0;
    end
end

%% incorporation of generator elements
fid=fopen('gendata.txt','r');
bb=textread('gendata.txt');
fclose(fid);

x=bb(:,1);
z=bb(:,3);
gnd=bb(:,4);
for i=1:length(x)
    if gnd(i)==1000
        Yz(x(i),x(i))=Yz(x(i),x(i))+0;
    end
    if gnd(i)~=1000
        Yz(x(i),x(i))=Yz(x(i),x(i))+1/(z(i)+3*gnd(i));
    end
end