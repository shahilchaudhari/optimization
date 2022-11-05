clear all
close all
clc 


% optimization of famous function
%rastring = @(x, y) 20 + x.^2 + y.^2 - 10*(cos(2*pi*x) + cos(2*pi*y));
%rosenbrock = @(x,y) 100*(x.^2-y).^2+(1-x).^2;
peak = @(x,y) 3*(1-x).^2.*exp(-(x.^2) - (y+1).^2) - 10*(x/5 - x.^3 - y.^5).*exp(-x.^2-y.^2) - 1/3*exp(-(x+1).^2 - y.^2) 

%--------------- ploting rastring function
%rf3 = @(x, y) rastring(x/10, y/10);
%fsurf(rf3,[-30 30],"ShowContours","on")
%title("rastriginsfcn([x/10,y/10])")

%------------ ploting rosenbrock function
%fsurf(@(x,y)log(1+rosenbrock(x,y)),[0,2])
%title('log(1 + 100*(x(1)^2 - x(2))^2 + (1 - x(1))^2)')
%view(-13,78)
%hold on
%h1 = plot3(1,1,0.1,'r*','MarkerSize',12);
%legend(h1,'Minimum','Location','best');
%hold off

%-----------ploting peak function
fsurf(@(x,y) peak(x,y),[-5,5])
title(['3*(1-x)^2*exp(-(x^2) - (y+1)^2) - 10*(x/5 - x^3 - y^5)*exp(-x^2-y^2) - 1/3*exp(-(x+1)^2 - y^2)'])
view(-15,20)


rng default % For reproducibility

% rastring  upper and lower bound
%x = optimvar("x","LowerBound",-100,"UpperBound",100);
%y = optimvar("y","LowerBound",-100,"UpperBound",100);

% rosbrock upper and lower bound
%x = optimvar("x","LowerBound",-3,"UpperBound",3);
%y = optimvar("y","LowerBound",-3,"UpperBound",3);

% peak function upper and lower bound
x = optimvar("x","LowerBound",-3,"UpperBound",3);
y = optimvar("y","LowerBound",-3,"UpperBound",3);

%ras objective function
%prob = optimproblem("Objective",rastring(x,y))

% rosenbrock objective function
%prob = optimproblem("Objective",rosenbrock(x,y))

% peak obejective function
prob = optimproblem("Objective",-peak(x,y))

% display the iteration
options = optimoptions("ga","PlotFcn","gaplotbestf")

[sol2,fval2] = solve(prob,"Solver","ga","Options",options)
