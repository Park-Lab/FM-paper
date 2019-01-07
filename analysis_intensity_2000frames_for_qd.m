function B=analysis_intensity_2000frames_for_qd(Q)
m=length(Q); c=m/2000;i=1;j=1;p=1;% divide the data from 1 Column into a matrix (A) with 200 Row and n Column
A=zeros(2000,c);
while j<=c
    while i<=2000
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

plot(B) % show the graph of normalized data

