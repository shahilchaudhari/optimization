clear;
clc;

v1=3;
v2=12;

dv = 1;

n = (v2-v1)/dv+1;

v = linspace(v1,v2,n);

P = 1.3+0.04.*v.^1.8;
Q = 2.5+6.2.*v.^0.8;

wp = 0.5;
wq = 1-wp;

Pn = P/sqrt(sum(P.^2));
Qn = Q/sqrt(sum(Q.^2));

Pwn = wp*Pn;
Qwn = wq*Qn;

p_best = min(Pwn);
p_worst = max(Pwn);
q_best = max(Qwn);
q_worst = min(Qwn);


d_best = sqrt((Pwn-p_best).^2+(Qwn-q_best).^2);
d_worst = sqrt((Pwn-p_worst).^2+(Qwn-q_worst).^2);

D = d_worst./(d_worst+d_best);

[P_sort,i] = sort(D,'descend');

% print
prt = ['Velocity (v)',num2str(v(i(1))),...
    ', Heat Dissipation rate (Q)',num2str(Q(i(1))),...
    ',Pumping power = ',num2str(P(i(1))),...
    ', Dmax = ',num2str(D(i(1)))];
disp(prt)

counter = 0;
while counter<n
    counter=counter+1;
    prt1 = ['Velocity (v)= ',num2str(v(counter)),...
        ', Heat Dissipation rate (Q)= ',num2str(Q(counter)),...
        ',Pumping power = ',num2str(P(counter)),...
        ',D = ',num2str(D(counter))];
    disp(prt1)
end