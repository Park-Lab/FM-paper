function [C,D]=analysis_kinetics_200frames_trace_for_fm(Q,x)% Q is one Column of the original data from Metamorph, x is the number of frames we want to analyze after 20s
m=length(Q); c=m/200;i=1;j=1;p=1;% divide the original data from one Column into a matrix (A) with 200 Row and n Column
A=zeros(200,c);
while j<=c
    while i<=200
        A(i,j)=Q(p,1);p=p+1;
        i=i+1;
    end
    j=j+1;i=1;
end
[m,n]=size(A);B=zeros(m,n-1);% remove the background(supposed to be the last Column of matrix A)
v=1;w=1;
while w<=n-1
    while v<=m
        B(v,w)=A(v,w)-A(v,n);v=v+1;
    end
    v=1;w=w+1;
end
k=zeros(1,n-1);
h=1;
while h<=n-1
    k(1,h)=mean(B(1:20,h));% k is the average of baseline (first 20 seconds of each dot); h column, each column (each area) has only 1 averaged baseline from their frist 20 dots
    h=h+1;
end
C=zeros(x,n); g=1;h=1;l=22;% C is the matrix of data after normalized with baseline after 20s, the first 20s' normalized intensity is nor needed for the exponential decay fitting
while g<=x
    C(g,h)=g;
    g=g+1;
end
g=1;h=h+1;
while h<=n
    while g<=x
        C(g,h)=B(l,h-1)/k(1,h-1);
        g=g+1;l=l+1;
    end
    g=1;l=22;h=h+1;
end
plot(C);
axis([0 x 0 1.2]);
r=2;
D=zeros(c-1,6);% D is the matrix of every single trace fitting constant which contains a,b,d and rsquare by sequence
s=x;% s is how many frames we want to analyze after stimulation which is decided by entering the x value of the equation
while r<=c
    [f,G]=fit(C(1:s,1),C(1:s,r),'a+b*exp(-d*x)+e*exp(-f*x)');
    D(r-1,1)=f.a;D(r-1,2)=f.b;D(r-1,3)=f.e;
    D(r-1,4)=f.d;D(r-1,5)=f.f;D(r-1,6)=G.rsquare;
    r=r+1;
end % When using the program, you should use"[C,D]=analysis_kinetics_200frames_trace(Q,x)", otherwise it will only show you matrix (C)

