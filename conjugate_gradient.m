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

countmax = 10; % maximum count for iteration
errTol = 10^-10; %convergence
label = 0;
count = 0;


while label==0
    count = count+1;
    % label = 1;

    DYDX1 = single(subs(dydx1,{x1,x2},{X1,X2}));
    DYDX2 = single(subs(dydx2,{x1,x2},{X1,X2}));

   if count==1
       d2 = [DYDX1; DYDX2];
   else
       c2 = [DYDX1; DYDX2];
       b = ((norm(c2))/norm(c1))^2;
       d2 = -c2+b*d1;
   end

   % objective function for minimization
   y_new = 2*(X1+d2(1)*a)^2-2*(X1+d2(1)*a)*(X2+d2(2)*a)+2*(X2+d2(2)*a)^2;

   dy_newda = diff(y_new,a);

   % Equation the derivative of the objective function
   %is equal to zero for minimization

   r = solve(dy_newda,a);

   % value of alpha at which the objective function is minimum
   alpha = single(r);

   X1new = X1+d2(1)*alpha;
   X2new = X2+d2(2)*alpha;

   err = (X1new-X1)^2+(X2new-X2)^2; %residual
   X1 = X1new;
   X2 = X2new;

   c1 = [DYDX1;DYDX2];
   y = 2*((X1+DYDX1*alpha)^2)-2*(X1+DYDX1*alpha)*(X2+DYDX2*alpha)+(X2+DYDX2*alpha)^2;

   if count==1
       d1 = -c1;
   else
       d1 = d2;
   end

   if count==countmax || err<errTol
       label = 1;
   end

   % print
   prt = ['Itr = ',num2str(count),...
       ',x1 = ',num2str(X1),...
       ',x2 = ',num2str(X2),...
       ', y = ',num2str(y),...
       ' err = ',num2str(err),...
       ', alpha = ',num2str(alpha)];
   disp(prt)
end