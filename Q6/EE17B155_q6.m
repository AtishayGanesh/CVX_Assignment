Cn =  [1 -0.76 0.07 -0.96; -0.76 1 0.18 0.07; 0.07 0.18 1 0.41; -0.96 0.07 0.41 1];
on = ones(4,1);


cvx_begin
    variable C(4,4)
    minimize (norm(C-Cn,'fro'))
    subject to
        lambda_min(C) >=0;
        diag(C)-on == 0;
cvx_end

C