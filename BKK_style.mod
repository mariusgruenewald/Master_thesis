var net_ex_1,net_ex_2, h,ex,imp,A_1,A_2,y_1,y_2,k_1, n_1, n_2, k_2, x_1, x_2, c_1, c_2, a_1, a_2, b_1, b_2,nx_1,nx_2,ir_1,ir_2,rx_1,rx_2,p_1,p_2, r_1,r_2,qa_1,qa_2,qb_1,qb_2,lambda_1,lambda_2,f_1,f_2;
varexo cp, eps_2;

parameters beta, mu, gamma, theta, delta, rho, rhoA, rhoN, rhoH omega_1 omega_2;

beta = 0.99;
mu   = 0.34;
gamma = -1;
theta = 0.36;
delta = 0.1;
rho = 0.9;
rhoA = 0.42;
rhoN = 0.04;
rhoH = 0.92;
omega_1 = 0.9;
omega_2 = 0.9;

model;
//shock
A_1 = rhoA * A_1(-1) + h;
A_2 = rhoA * A_2(-1) -eps_2;
n_1 = rhoN * n_1(-1) + h;
n_2 = rhoN * n_2(-1) - eps_2;
h = rhoH * h(-1) - cp;

//output
f_1=exp(A_1)*k_1(-1)^theta*exp(n_1)^(1-theta);
f_2=exp(A_2)*k_2(-1)^theta*exp(n_2)^(1-theta);

//feasibility constraints
x_1+c_1= (omega_1*a_1^((rho-1)/rho)+(1-omega_2)*b_1^((rho-1)/rho))^(rho/(rho-1));
x_2+c_2= ((1-omega_1)*a_2^((rho-1)/rho)+omega_2*b_2^((rho-1)/rho))^(rho/(rho-1));

// capital formation
k_1 = x_1+(1-delta)*k_1(-1);
k_2 = x_2+(1-delta)*k_2(-1);

// intermediate good
a_1+ a_2 = f_1;
b_1+ b_2 = f_2;

// Lagrangian
lambda_1 = c_1^gamma /c_1;
lambda_2 = c_2^gamma /c_2;

// interest rate in terms of intermediate good
r_1 =  theta*f_1/k_1(-1);
r_2 =  theta*f_2/k_2(-1);

// intermediate good pricing
qa_1 = omega_1*a_1^((rho-1)/rho-1)*(omega_1*a_1^((rho-1)/rho)+(1-omega_2)*b_1^((rho-1)/rho))^(rho/(rho-1)-1);
qb_1 = (1- omega_2)*b_1^(((rho-1)/rho)-1)* ((omega_1)*a_1^((rho-1)/rho)+(1-omega_2)*b_1^((rho-1)/rho))^(rho/(rho-1)-1);
qa_2 = (1-omega_1)*a_2^(((rho-1)/rho)-1)*((1-omega_1)*a_2^((rho-1)/rho)+omega_2*b_2^((rho-1)/rho))^(rho/(rho-1)-1);
qb_2 = omega_2*b_2^(((rho-1)/rho)-1)*((1-omega_1)*a_2^((rho-1)/rho)+omega_2*b_2^((rho-1)/rho))^(rho/(rho-1)-1);

//foc to capital
beta*lambda_1(1)*(qa_1(1) * r_1(1)+1-delta)=lambda_1;
beta*lambda_2(1)*(qb_2(1) * r_2(1)+1-delta)=lambda_2;

//foc to a_1
lambda_1* qa_1 =lambda_2* qa_2;

//foc to b_1
lambda_1* qb_1= lambda_2* qb_2;

// gdp    
y_1=qa_1*f_1;
y_2=qb_2*f_2;

//net export ratio
nx_1=(qa_1*a_2-qb_1*b_1)/y_1;
nx_2=(qb_2*b_1-qa_2*a_2)/y_2;

//import ratio
a_1*ir_1=b_1;
b_2*ir_2=a_2;

//terms of trade
qa_1*p_1=qb_1;
qb_2*p_2=qa_2;

//real exchange rate
rx_1=qa_1/qa_2;
rx_2=qa_2/qa_1;

// exports & imports
ex = qa_1*a_2;
imp = qb_1*b_1;
net_ex_1 = qa_1*a_2-qb_1*b_1;
net_ex_2 = qb_2*b_1-qa_2*a_2;


end;

initval;
h=1;
k_1=2.8;
k_2=2.8;
x_1=0.6;
x_2=0.6;
c_1=0.8;
c_2=0.8;
n_1=0.3;
n_2=0.3;
f_1=1;
f_2=1;
y_1=0.7;
y_2=0.7;
rx_1=1;
rx_2=1;
ir_1=0.3;
ir_2=0.3;
p_1=1;
p_2=1;
nx_1=1.39e-09;
nx_2=-3.30e-10;
cp=0;
A_1=0;
A_2=0;
a_1=0.733135;
a_2=0.153882;
b_1=0.153882;
b_2=0.733135;
r_1 =  0.04;
r_2 =  0.04;
qa_1 = 0.642314;
qb_1 = 0.642314;
qa_2 = 0.642314;
qb_2 = 0.642314;
lambda_1 = 1.3692;
lambda_2 = 1.3692;
end;

steady;
check;

shocks;
var cp=.024;

end;

stoch_simul(dr_algo=0, order =1, hp_filter = 6.25, periods=1000, irf = 80,graph_format = eps)ex imp rx_1 nx_1;
stoch_simul(dr_algo=0, order =1, hp_filter = 6.25, periods=1000, irf = 80,graph_format = eps)ex imp a_2 b_1 rx_1 nx_1;
stoch_simul(dr_algo=0, order =1, hp_filter = 6.25, periods=1000, irf = 80,graph_format = eps)qa_1 qa_2 qb_1 qb_2;
stoch_simul(dr_algo=0, order =1, hp_filter = 6.25, periods=1000, irf = 80,graph_format = eps)a_1 c_1 k_1 y_1 f_1 h n_1 A_1 r_1 ir_1 p_1;
stoch_simul(dr_algo=0, order =1, hp_filter = 6.25, periods=1000, irf = 80,graph_format = eps)k_2 n_2 A_2 y_2 f_2 nx_2 p_2 r_2 rx_2 ir_2 c_2 net_ex_2 qb_2;