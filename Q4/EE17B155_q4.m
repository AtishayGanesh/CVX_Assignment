load('Q4_data.mat')%#ok<*AGROW>

n = 10;
m = 4;
xi = xs(:,1:end-1);
xo = xs(:,2:end);
ob1 = [];
ob2 = [];
ob3 = [];
% cvx_begin
%     variable A(n,n)
%     variable B(n,m)
%     minimize (sum(sum((xo-A*xi-B*us).^2)))
% cvx_end

for l =  10:2:70
    cvx_begin
        variable A(n,n)
        variable B(n,m)
        minimize (sum(sum((xo-A*xi-B*us).^2))+l*sum(sum(abs(A)))+l*sum(sum(abs(B))))
    cvx_end
    ob1 = [ob1;cvx_optval];
    ct = sum(abs(A)>0.01,'all')+sum(abs(B)>0.01,'all');
    ob2 = [ob2;ct];
end
figure(1)
plot(ob1,ob2,'b-');
grid
ob3 = ob1/max(ob1)+ob2/max(ob2);
figure(2)
plot(10:2:70,ob3,'b-')
