function [C,E]=analysis_intensity_200frames_trace_for_fm(Q)
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
    k(1,h)=mean(B(1:20,h));% k is the average of baseline (first 20 seconds of each dot); h column, each column (each area) has only 1 averaged baseline from their frist 20 dots
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
plot(C) % show the graph of normalized data
n=n-1;
E=zeros(n,1);
while i<=n
    E(i,1)=1-mean(C(141:200,i));
    i=i+1;
end;
end





