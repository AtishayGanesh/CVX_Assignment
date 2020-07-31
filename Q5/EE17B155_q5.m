load('Q5_data.mat')

s = sin(a);

one = ones(1,20)
cvx_begin
    variable z(1,4)
    variable t(1,20)
    minimize(one*t.')
    subject to
    -s+z*A.'-t <=0;
     s-z*A.'-t <=0;
cvx_end

plot(a,s,'r-',a,z*A.','b-')
