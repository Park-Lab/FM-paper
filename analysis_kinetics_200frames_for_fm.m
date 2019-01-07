function [D,R]=analysis_kinetics_200frames_for_fm(Q,x)% Q is one Column of the original data from Metamorph, x is the number of frames we want to analyze after 20s
m=length(Q); c=m/200;i=1;j=1;p=1;% divide the data from 1 Column into a matrix (A) with 200 Row and n Column
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
    k(1,h)=mean(B(1:20,h));% k is the average of baseline (first 20 seconds of each dot)
    h=h+1;
end
C=zeros(m,n-1); g=1;h=1;% C is the matrix of data after normalized with baseline
while h<=n-1
    while g<=m
        C(g,h)=B(g,h)/k(1,h);
        g=g+1;
    end
    g=1;h=h+1;
end
r=x;D=zeros(r,3);g=1;h=sqrt(n-1);% make the output showing the x(1:x),y(mean intensity) and error bar
while g<=r
    D(g,1)=g;g=g+1;
end
g=1;
while g<=r
    D(g,2)=mean(C(g+20,1:n-1));g=g+1;
end
g=1;
while g<=r
    D(g,3)=std(C(g+20,1:n-1))/h;
    g=g+1;
end
plot(D(:,2));
hold on;% show the graph of normalized data
R=zeros(1,4);% R is the matrix of each coverslip's trace fitting constant which contains a,b,d and rsquare by sequence
[f,G]=fit(D(1:r,1),D(1:r,2),'a+b*exp(-d*x)');
R(1,1)=f.a;
R(1,2)=f.b;
R(1,3)=f.d;
R(1,4)=G.rsquare;
x=D(:,1);
y1=f.a+f.b*exp(-f.d*x);
plot(D(:,1),y1,'red');





