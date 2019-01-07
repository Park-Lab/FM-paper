function [C,D]=analysis_kinetics_200frames_kinetics_single_for_Cal520(Q)% Q is one Column of the original data from Metamorph
B=analysis_intensity_200frames_trace_for_Cal520(Q);
m=length(Q);c=m/200;
C=zeros(60,c); 
j=1;
while j<=60
    C(j,1)=j;
    j=j+1;
end
i=2;n=1;h=141;
while i<=c
    while h<=200
        C(n,i)=B(h,i-1)*0.63;
        h=h+1;n=n+1;
    end
    i=i+1;n=1;h=141;
end
plot (C(:,2:c));
r=2;
D=zeros(c-1,4);% D is the matrix of every single trace fitting constant which contains a,b,d and rsquare by sequence
while r<=c
    [f,G]=fit(C(1:60,1),C(1:60,r),'a+b*exp(-d*x)');
    D(r-1,1)=f.a;D(r-1,2)=f.b;D(r-1,3)=f.d;
    D(r-1,4)=G.rsquare;
    r=r+1;
end % When using the program, you should use"[C,D]=analysis_kinetics_200frames_trace(Q,x)", otherwise it will only show you matrix (C)

