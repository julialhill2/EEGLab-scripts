filename= 'TEST1.23.17_TCF4SCN_thetaITC';
filename = [filename, '.xlsx'];

group=TCF4SCN;
[m,n]=size(group);
%this returns the size of the matrix of your data

nsubj=n;
%nsubj=length(nsubj);
%this automatically spits out the number of columns, i.e. your number of
%subjects

thetamax=zeros(1,nsubj);
theta_lat_max=zeros(1,nsubj);

for k=1:nsubj
    
    A=group(:,k);
    thetamax(k)=max(A);
    theta_lat_max(k)=find(A(:,1)==thetamax(k));
    theta_lat_max(k)=erptimes(theta_lat_max(k),1); 
    
     Z=erptimes;
     
    xlswrite(filename, thetamax, n, 'C1');
    xlswrite(filename, theta_lat_max, n, 'C2');
     

    
end