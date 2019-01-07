function D=multiple_calculation_for_Cal520(Q)
% Matrix Q is generate from combining every coverslips' normalized traces
[m,n]=size(Q);
D=zeros(m,3);g=1;
while g<=m
    D(g,1)=g;g=g+1;%time scale
end
g=1;
while g<=m
    D(g,2)=mean(Q(g,1:n));g=g+1;%Mean value of averaged trace
end
g=1;
while g<=m
    D(g,3)=std(Q(g,1:n))/sqrt(n);%Standard error of mean of averaged trace
    g=g+1;
end
plot (D(:,2));


