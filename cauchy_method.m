clear;
clc;

X1 = 3; 
X2 = 5;

syms x1 x2 a
y = 2*(x1^2)-2*x1*x2+x2^2; % objective function


% derivative of objective function with respect to x1
dydx1 = diff(y,x1);

% derivative of objective function with respect to x2
dydx2 = diff(y,x2);

% value of derivatives
DYDX1 = single(subs(dydx1,{x1,x2},{X1,X2}));

% value of derivatives
DYDX2 = single(subs(dydx2,{x1,x2},{X1,X2}));    

countmax = 15; % maximum count for iteration
errTol = 10^-16; %convergence
label = 0;
count = 0;


while label==0
    count = count+1;
    % label = 1;

    DYDX1 = single(subs(dydx1,{x1,x2},{X1,X2}));
    DYDX2 = single(subs(dydx2,{x1,x2},{X1,X2}));
    
    y_new = 2*((X1+DYDX1*a)^2)-2*(X1+DYDX1*a)*(X2+DYDX2*a)+(X2+DYDX2*a)^2;

    % Equating the derivative of the objective function
    % is equal to zero for minimization
    dy_newda = diff(y_new,a);
    r = solve(dy_newda,a);

    % value of alpha at which tho objective funtion is minumum
    alpha = single(r);
    X1new = X1+DYDX1*alpha;
    X2new = X2+DYDX2*alpha;

    err = (X1new-X1).^2+(X2new-X2).^2;

    X1 = X1new;
    X2 = X2new;

    if count==countmax || err < errTol
        label=1;
    end

    prt = ['Itr = ',num2str(count),...
        ' ,x1 = ',num2str(X1),...
        ' ,x2 = ',num2str(X2),...
        ' ,err = ',num2str(err),... 
        ' ,alpha = ',num2str(alpha)];
        
    disp(prt)

end
