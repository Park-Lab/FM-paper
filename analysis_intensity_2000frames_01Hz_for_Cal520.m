function [C,D,E,F,G]=analysis_intensity_2000frames_01Hz_for_Cal520(Q)% Get the relative intensity of DeltF: (f-f0)/f0
D=analysis_intensity_2000frames_trace_for_Cal520(Q);% Get the Relative Intensity Matrix
[C,~,n] = split(D);% split relative intensity matrix to column 
E=zeros(100,n*12+1);a=1;
while a<=100
    E(a,1)=0.1*a;
    a=a+1;
end
i=1;j=1;k=1;% separate each column to 12 traces according to 12 pulse and each is 100 frames column
while i<=n
    while j<=12
        while k<=100
            E(k,12*(i-1)+j+1)=C{1,i}(k+98*j+89,1);
            k=k+1;
        end
        j=j+1;k=1;
    end
    i=i+1;j=1;
end
[~,b]=size(E);
plot (E(:,2:b));
F=zeros(b-1,1);% Matrix F is the matrix where to put peak value
i=2;
while i<=b
    c=mean(E(1:5,i));
    d=max(E(:,i));
    F(i-1,1)=d-c;
    i=i+1;
end
i=2;
G=zeros(b-1,4);
while i<=b
    [~,j]=max(E(:,i));
    [f,g]=fit(E(j:100,1),E(j:100,i),'a+b*exp(-d*x)');
    G(i-1,1)=f.a;
    G(i-1,2)=f.b;
    G(i-1,3)=g.rsquare;
    G(i-1,4)=f.d;
    i=i+1;
end
end
