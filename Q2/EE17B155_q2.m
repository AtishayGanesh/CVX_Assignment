xstart = [-1;0.7];%#ok<*AGROW>
f = @(x) (exp(x(1)+ 3*x(2)-0.1)+exp(x(1)- 3*x(2)-0.1)+exp(-x(1)-0.1));
f1 = @(x)[
    exp(x(1)+ 3*x(2)-0.1)+exp(x(1)- 3*x(2)-0.1)-exp(-x(1)-0.1);
    3*exp(x(1)+ 3*x(2)-0.1)-3*exp(x(1)- 3*x(2)-0.1)
];

f2 = @(x)[
    exp(x(1)+ 3*x(2)-0.1)+exp(x(1)- 3*x(2)-0.1)+exp(-x(1)-0.1),...
    3*exp(x(1)+ 3*x(2)-0.1)-3*exp(x(1)- 3*x(2)-0.1); 
    3*exp(x(1)+ 3*x(2)-0.1)-3*exp(x(1)- 3*x(2)-0.1),...
    9*exp(x(1)+ 3*x(2)-0.1)+9*exp(x(1)- 3*x(2)-0.1)

];
stop = 0.01;


choice = 3; 
% choice 1: GD, choice 2: Backtracking GD, choice 3: Newton's method


x = xstart;
x_array = x;
ct=1;

if choice ==1
    disp('GD with fixed step size ')
    while 1
        delx = -f1(x);
        x = x+0.1*delx;
        x_array = [x_array x]; 
        ct = ct + 1;
        if norm(delx)<stop, break; end
        if any(isnan(x))
            disp('Too high a step size');
            break; 
        end

    end
elseif choice==2
    alpha = 0.1;
    beta = 0.5;
    disp('GD with step size chosen by Backtracking Line Search')

    while 1

        delx = -f1(x);
        t = 1;
        while f(x+t*delx)>f(x)+alpha*t*f1(x).'*delx, t=beta*t; end
        x = x+t*delx;
        x_array = [x_array x]; 
        ct = ct+ 1;

        if norm(delx)<stop, break; end
        if any(isnan(x))
            disp('Too high a step size');
            break; 
        end
    end

elseif choice ==3
    alpha = 0.1;
    beta = 0.5;
    disp('Newton method with backtracking line search')
    while 1
        delx = -inv(f2(x))*f1(x);
        t = 1;
        while f(x+t*delx)>f(x)+alpha*t*f1(x).'*delx, t=beta*t; end
        x = x+t*delx;
        x_array = [x_array x]; 
        ct = ct+ 1;
        if norm(f1(x))<stop, break; end
        if any(isnan(x))
            disp('Too high a step size');
            break; 
        end
    end
end
disp(x)
plot(x_array(1,1),x_array(2,1),'rx')
hold on
for i = 2:ct
    plot(x_array(1,i),x_array(2,i),'rx')
    draw_line(x_array(:,i-1),x_array(:,i))
    hold on
    
end
    
