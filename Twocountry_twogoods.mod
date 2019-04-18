% This is the simple code for the DSGE model of my master thesis.
% 
% Generally, I follow a two-country model. Endogenizing
% health and productivity w.r.t. health. 
% Treat variables in a stochastic way -> more credible them deterministic
%
%----------------------------------------------------------------
% 1. Defining variables
%----------------------------------------------------------------


% 19 variables
var c1 c2 k1 k2 a1 a2 lab1 lab2 y1 y2 inv1 inv2 tb1 tb2 imp1 imp2 d1 d2 h tb1_y tb2_y;

% Declaring exogenous shock variables
varexo cp e2;

% Defining parameters
parameters gamma delta alpha beta rhoH rhoN rhoA r;

% Assigning values to parameters
% FIND SOURCES FOR VALUES
gamma=2;
delta=.05;
alpha=.32;
beta= 0.98;
rhoA= 0.42;
rhoN = 0.04;
// in-sample population autocorrelation
r = 0.04;
rhoH = 0.92;
// 0.92 as being the autocorrelation in health data for my sample

%--------------------------------------------------------------------------
% 2.     Writing the characterizing equations  
%--------------------------------------------------------------------------


model;
// Households
exp(c2)+exp(k2)-exp(k2(-1))*(1-delta) + exp(d2) = exp(a2)*exp(lab2)^(1-alpha)*exp(k2(-1))^alpha + (1+r)* exp(d2(-1));
exp(c1)^(-gamma) = beta*exp(c1(+1))^(-gamma)*(alpha*exp(a1(+1))*exp(k1)^(alpha-1)*exp(lab1(+1))^(1-alpha) +1-delta);
exp(c2)^(-gamma) = beta*exp(c2(+1))^(-gamma)*(alpha*exp(a2(+1))*exp(k2)^(alpha-1)*exp(lab2(+1))^(1-alpha) +1-delta);
exp(c1)+exp(k1)-exp(k1(-1))*(1-delta) + exp(d1) = exp(a1)*exp(lab1)^(1-alpha)*exp(k1(-1))^alpha + (1+r)* exp(d1(-1));
exp(c1)^(-gamma) = beta * (1+r) * exp(c1(+1))^(-gamma);
exp(c2)^(-gamma) = beta * (1+r) * exp(c2(+1))^(-gamma);

// Stochastic processes
a1=rhoA*a1(-1)+h;
a2=rhoA*a2(-1)-e2;
lab1 = rhoN * lab1(-1) + h;
lab2 = rhoN * lab2(-1) - e2;

// Production
y1 = exp(a1) * exp(lab1)^(1-alpha) * exp(k1(-1))^(alpha);
y2 = exp(a2) * exp(lab2)^(1-alpha) * exp(k2(-1))^(alpha);

// Miscalleneous
inv1 = k1(+1) - (1-delta)*k1;
inv2 = k2(+1) - (1-delta)*k2;
tb1 = y1 - c1 - inv1;
tb2 = y2 - c2 - inv2;
imp1 = c1 + inv1;
imp2 = c2 + inv2;
h = rhoH * h(-1) - cp;
tb1_y = tb1 / y1;
tb2_y = tb2 / y2;
end;

%--------------------------------------------------------------------------
% 3.      Initialize values (to avoid "no steady-state" solution)
%--------------------------------------------------------------------------


initval;
k1=2.8;
k2=2.8;
c1=.8;
c2=.8;
lab1 = .3;
lab2 = .3;
inv1 = 0.6;
inv2 = 0.6;
y1 = 1;
y2 = 1;
a1=0;
a2=0;
h=1;
e2=0;
cp=0.00;
end;

%--------------------------------------------------------------------------
% 4.        Defining the shock
%--------------------------------------------------------------------------


shocks;
var cp;
stderr .024;
/* 0.024 is the standard deviation of the case prevalence (in percent)
in the 2014 Ebola outbreak */
end;

%--------------------------------------------------------------------------
% 5.      Declare to solve for steady-state and simulation details
%--------------------------------------------------------------------------

steady;
stoch_simul(dr_algo=0, order =1, hp_filter = 6.25, periods=1000, irf = 80)y1 imp1 tb1_y;
stoch_simul(dr_algo=0, order =1, hp_filter = 6.25, periods=1000, irf = 80)c1 k1 a1 lab1 inv1 d1 h;
stoch_simul(dr_algo=0, order =1, hp_filter = 6.25, periods=1000, irf = 80)k2 y2 inv2 imp2 tb2_y;
