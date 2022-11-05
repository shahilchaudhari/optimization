clear all;
close all;
clc;

peaks
mycolors = [1 0 0; 1 1 0; 0 0 1];
colormap(mycolors);
title({['z = 3*(1-x)^2*exp(-(x^2) - '],...
    ['(y+1)^2)- 10*(x/5 - x^3 - y^5)*exp(-x^2-y^2) '], ...
    ['- 1/3*exp(-(x+1)^2 - y^2)']})
problem.solver = 'ga';
problem.fitnessfcn = @(x)peaks(x(1),x(2));
problem.nvars =2 ;
problem.lb = [-3 -3];
problem.ub = [3 3];

% mimimum point
hold on
h1 = plot3(0.2283,-1.6255,-6.5511);
h1.Color='k'
h1.Marker = 'hexagram';
h1.MarkerFaceColor = "g";
h1.MarkerSize = 15;
legend(h1,' global Minimum','Location','best');

hold off
f = gcf;
fig.PaperPositionMode = 'auto';
print('peaks_fuction_minimum','-dpng','-r0')

problem.options = gaoptimset('Display','Iter',...
    'popInitRange',[-3 -3; 3 3]);
%problem.options = gaoptimset("OutputFcn",@peaksPlotIterates,...
%    'Display',' iter',...
%    'popInitRange',[-3 -3; 3 3]);

[x,f,exitflag,Output] = ga(problem)