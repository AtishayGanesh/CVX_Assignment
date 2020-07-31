
A = [-1 -1; -1 1; 1 -1; 2 1];
b = [1/2; 2; 2; 4];
c = [-2; -1];
A;
b;
c;
zer = [0;0];
zero = [0;0;0;0];
n = 2;
cvx_begin
    variable l(4)
    maximize ( -dot(b,l)+ sum(min(zer,c+A.'*l)))
    subject to 
        l >= zero;
cvx_end
p_opt = cvx_optval
