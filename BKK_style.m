%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

if isoctave || matlab_ver_less_than('8.6')
    clear all
else
    clearvars -global
    clear_persistent_variables(fileparts(which('dynare')), false)
end
tic0 = tic;
% Save empty dates and dseries objects in memory.
dates('initialize');
dseries('initialize');
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'BKK_style';
M_.dynare_version = '4.5.7';
oo_.dynare_version = '4.5.7';
options_.dynare_version = '4.5.7';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('BKK_style.log');
M_.exo_names = 'cp';
M_.exo_names_tex = 'cp';
M_.exo_names_long = 'cp';
M_.exo_names = char(M_.exo_names, 'eps_2');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_2');
M_.exo_names_long = char(M_.exo_names_long, 'eps_2');
M_.endo_names = 'net_ex_1';
M_.endo_names_tex = 'net\_ex\_1';
M_.endo_names_long = 'net_ex_1';
M_.endo_names = char(M_.endo_names, 'net_ex_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'net\_ex\_2');
M_.endo_names_long = char(M_.endo_names_long, 'net_ex_2');
M_.endo_names = char(M_.endo_names, 'h');
M_.endo_names_tex = char(M_.endo_names_tex, 'h');
M_.endo_names_long = char(M_.endo_names_long, 'h');
M_.endo_names = char(M_.endo_names, 'ex');
M_.endo_names_tex = char(M_.endo_names_tex, 'ex');
M_.endo_names_long = char(M_.endo_names_long, 'ex');
M_.endo_names = char(M_.endo_names, 'imp');
M_.endo_names_tex = char(M_.endo_names_tex, 'imp');
M_.endo_names_long = char(M_.endo_names_long, 'imp');
M_.endo_names = char(M_.endo_names, 'A_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'A\_1');
M_.endo_names_long = char(M_.endo_names_long, 'A_1');
M_.endo_names = char(M_.endo_names, 'A_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'A\_2');
M_.endo_names_long = char(M_.endo_names_long, 'A_2');
M_.endo_names = char(M_.endo_names, 'y_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'y\_1');
M_.endo_names_long = char(M_.endo_names_long, 'y_1');
M_.endo_names = char(M_.endo_names, 'y_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'y\_2');
M_.endo_names_long = char(M_.endo_names_long, 'y_2');
M_.endo_names = char(M_.endo_names, 'k_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'k\_1');
M_.endo_names_long = char(M_.endo_names_long, 'k_1');
M_.endo_names = char(M_.endo_names, 'n_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'n\_1');
M_.endo_names_long = char(M_.endo_names_long, 'n_1');
M_.endo_names = char(M_.endo_names, 'n_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'n\_2');
M_.endo_names_long = char(M_.endo_names_long, 'n_2');
M_.endo_names = char(M_.endo_names, 'k_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'k\_2');
M_.endo_names_long = char(M_.endo_names_long, 'k_2');
M_.endo_names = char(M_.endo_names, 'x_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'x\_1');
M_.endo_names_long = char(M_.endo_names_long, 'x_1');
M_.endo_names = char(M_.endo_names, 'x_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'x\_2');
M_.endo_names_long = char(M_.endo_names_long, 'x_2');
M_.endo_names = char(M_.endo_names, 'c_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'c\_1');
M_.endo_names_long = char(M_.endo_names_long, 'c_1');
M_.endo_names = char(M_.endo_names, 'c_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'c\_2');
M_.endo_names_long = char(M_.endo_names_long, 'c_2');
M_.endo_names = char(M_.endo_names, 'a_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'a\_1');
M_.endo_names_long = char(M_.endo_names_long, 'a_1');
M_.endo_names = char(M_.endo_names, 'a_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'a\_2');
M_.endo_names_long = char(M_.endo_names_long, 'a_2');
M_.endo_names = char(M_.endo_names, 'b_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'b\_1');
M_.endo_names_long = char(M_.endo_names_long, 'b_1');
M_.endo_names = char(M_.endo_names, 'b_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'b\_2');
M_.endo_names_long = char(M_.endo_names_long, 'b_2');
M_.endo_names = char(M_.endo_names, 'nx_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'nx\_1');
M_.endo_names_long = char(M_.endo_names_long, 'nx_1');
M_.endo_names = char(M_.endo_names, 'nx_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'nx\_2');
M_.endo_names_long = char(M_.endo_names_long, 'nx_2');
M_.endo_names = char(M_.endo_names, 'ir_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'ir\_1');
M_.endo_names_long = char(M_.endo_names_long, 'ir_1');
M_.endo_names = char(M_.endo_names, 'ir_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'ir\_2');
M_.endo_names_long = char(M_.endo_names_long, 'ir_2');
M_.endo_names = char(M_.endo_names, 'rx_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'rx\_1');
M_.endo_names_long = char(M_.endo_names_long, 'rx_1');
M_.endo_names = char(M_.endo_names, 'rx_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'rx\_2');
M_.endo_names_long = char(M_.endo_names_long, 'rx_2');
M_.endo_names = char(M_.endo_names, 'p_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'p\_1');
M_.endo_names_long = char(M_.endo_names_long, 'p_1');
M_.endo_names = char(M_.endo_names, 'p_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'p\_2');
M_.endo_names_long = char(M_.endo_names_long, 'p_2');
M_.endo_names = char(M_.endo_names, 'r_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'r\_1');
M_.endo_names_long = char(M_.endo_names_long, 'r_1');
M_.endo_names = char(M_.endo_names, 'r_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'r\_2');
M_.endo_names_long = char(M_.endo_names_long, 'r_2');
M_.endo_names = char(M_.endo_names, 'qa_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'qa\_1');
M_.endo_names_long = char(M_.endo_names_long, 'qa_1');
M_.endo_names = char(M_.endo_names, 'qa_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'qa\_2');
M_.endo_names_long = char(M_.endo_names_long, 'qa_2');
M_.endo_names = char(M_.endo_names, 'qb_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'qb\_1');
M_.endo_names_long = char(M_.endo_names_long, 'qb_1');
M_.endo_names = char(M_.endo_names, 'qb_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'qb\_2');
M_.endo_names_long = char(M_.endo_names_long, 'qb_2');
M_.endo_names = char(M_.endo_names, 'lambda_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'lambda\_1');
M_.endo_names_long = char(M_.endo_names_long, 'lambda_1');
M_.endo_names = char(M_.endo_names, 'lambda_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'lambda\_2');
M_.endo_names_long = char(M_.endo_names_long, 'lambda_2');
M_.endo_names = char(M_.endo_names, 'f_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'f\_1');
M_.endo_names_long = char(M_.endo_names_long, 'f_1');
M_.endo_names = char(M_.endo_names, 'f_2');
M_.endo_names_tex = char(M_.endo_names_tex, 'f\_2');
M_.endo_names_long = char(M_.endo_names_long, 'f_2');
M_.endo_partitions = struct();
M_.param_names = 'beta';
M_.param_names_tex = 'beta';
M_.param_names_long = 'beta';
M_.param_names = char(M_.param_names, 'mu');
M_.param_names_tex = char(M_.param_names_tex, 'mu');
M_.param_names_long = char(M_.param_names_long, 'mu');
M_.param_names = char(M_.param_names, 'gamma');
M_.param_names_tex = char(M_.param_names_tex, 'gamma');
M_.param_names_long = char(M_.param_names_long, 'gamma');
M_.param_names = char(M_.param_names, 'theta');
M_.param_names_tex = char(M_.param_names_tex, 'theta');
M_.param_names_long = char(M_.param_names_long, 'theta');
M_.param_names = char(M_.param_names, 'delta');
M_.param_names_tex = char(M_.param_names_tex, 'delta');
M_.param_names_long = char(M_.param_names_long, 'delta');
M_.param_names = char(M_.param_names, 'rho');
M_.param_names_tex = char(M_.param_names_tex, 'rho');
M_.param_names_long = char(M_.param_names_long, 'rho');
M_.param_names = char(M_.param_names, 'rhoA');
M_.param_names_tex = char(M_.param_names_tex, 'rhoA');
M_.param_names_long = char(M_.param_names_long, 'rhoA');
M_.param_names = char(M_.param_names, 'rhoN');
M_.param_names_tex = char(M_.param_names_tex, 'rhoN');
M_.param_names_long = char(M_.param_names_long, 'rhoN');
M_.param_names = char(M_.param_names, 'rhoH');
M_.param_names_tex = char(M_.param_names_tex, 'rhoH');
M_.param_names_long = char(M_.param_names_long, 'rhoH');
M_.param_names = char(M_.param_names, 'omega_1');
M_.param_names_tex = char(M_.param_names_tex, 'omega\_1');
M_.param_names_long = char(M_.param_names_long, 'omega_1');
M_.param_names = char(M_.param_names, 'omega_2');
M_.param_names_tex = char(M_.param_names_tex, 'omega\_2');
M_.param_names_long = char(M_.param_names_long, 'omega_2');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 2;
M_.endo_nbr = 39;
M_.param_nbr = 11;
M_.orig_endo_nbr = 39;
M_.aux_vars = [];
M_.Sigma_e = zeros(2, 2);
M_.Correlation_matrix = eye(2, 2);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 1;
erase_compiled_function('BKK_style_static');
erase_compiled_function('BKK_style_dynamic');
M_.orig_eq_nbr = 39;
M_.eq_nbr = 39;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 0 8 0;
 0 9 0;
 1 10 0;
 0 11 0;
 0 12 0;
 2 13 0;
 3 14 0;
 0 15 0;
 0 16 0;
 4 17 0;
 5 18 0;
 6 19 0;
 7 20 0;
 0 21 0;
 0 22 0;
 0 23 0;
 0 24 0;
 0 25 0;
 0 26 0;
 0 27 0;
 0 28 0;
 0 29 0;
 0 30 0;
 0 31 0;
 0 32 0;
 0 33 0;
 0 34 0;
 0 35 0;
 0 36 0;
 0 37 47;
 0 38 48;
 0 39 49;
 0 40 0;
 0 41 0;
 0 42 50;
 0 43 51;
 0 44 52;
 0 45 0;
 0 46 0;]';
M_.nstatic = 26;
M_.nfwrd   = 6;
M_.npred   = 7;
M_.nboth   = 0;
M_.nsfwrd   = 6;
M_.nspred   = 7;
M_.ndynamic   = 13;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:2];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(39, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(2, 1);
M_.params = NaN(11, 1);
M_.NNZDerivatives = [133; -1; -1];
M_.params( 1 ) = 0.99;
beta = M_.params( 1 );
M_.params( 2 ) = 0.34;
mu = M_.params( 2 );
M_.params( 3 ) = (-1);
gamma = M_.params( 3 );
M_.params( 4 ) = 0.36;
theta = M_.params( 4 );
M_.params( 5 ) = 0.1;
delta = M_.params( 5 );
M_.params( 6 ) = 0.9;
rho = M_.params( 6 );
M_.params( 7 ) = 0.42;
rhoA = M_.params( 7 );
M_.params( 8 ) = 0.04;
rhoN = M_.params( 8 );
M_.params( 9 ) = 0.92;
rhoH = M_.params( 9 );
M_.params( 10 ) = 0.9;
omega_1 = M_.params( 10 );
M_.params( 11 ) = 0.9;
omega_2 = M_.params( 11 );
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 3 ) = 1;
oo_.steady_state( 10 ) = 2.8;
oo_.steady_state( 13 ) = 2.8;
oo_.steady_state( 14 ) = 0.6;
oo_.steady_state( 15 ) = 0.6;
oo_.steady_state( 16 ) = 0.8;
oo_.steady_state( 17 ) = 0.8;
oo_.steady_state( 11 ) = 0.3;
oo_.steady_state( 12 ) = 0.3;
oo_.steady_state( 38 ) = 1;
oo_.steady_state( 39 ) = 1;
oo_.steady_state( 8 ) = 0.7;
oo_.steady_state( 9 ) = 0.7;
oo_.steady_state( 26 ) = 1;
oo_.steady_state( 27 ) = 1;
oo_.steady_state( 24 ) = 0.3;
oo_.steady_state( 25 ) = 0.3;
oo_.steady_state( 28 ) = 1;
oo_.steady_state( 29 ) = 1;
oo_.steady_state( 22 ) = 1.39e-09;
oo_.steady_state( 23 ) = (-3.30e-10);
oo_.exo_steady_state( 1 ) = 0;
oo_.steady_state( 6 ) = 0;
oo_.steady_state( 7 ) = 0;
oo_.steady_state( 18 ) = 0.733135;
oo_.steady_state( 19 ) = 0.153882;
oo_.steady_state( 20 ) = 0.153882;
oo_.steady_state( 21 ) = 0.733135;
oo_.steady_state( 30 ) = 0.04;
oo_.steady_state( 31 ) = 0.04;
oo_.steady_state( 32 ) = 0.642314;
oo_.steady_state( 34 ) = 0.642314;
oo_.steady_state( 33 ) = 0.642314;
oo_.steady_state( 35 ) = 0.642314;
oo_.steady_state( 36 ) = 1.3692;
oo_.steady_state( 37 ) = 1.3692;
if M_.exo_nbr > 0
	oo_.exo_simul = ones(M_.maximum_lag,1)*oo_.exo_steady_state';
end
if M_.exo_det_nbr > 0
	oo_.exo_det_simul = ones(M_.maximum_lag,1)*oo_.exo_det_steady_state';
end
steady;
oo_.dr.eigval = check(M_,options_,oo_);
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = .024;
options_.hp_filter = 6.25;
options_.irf = 80;
options_.order = 1;
options_.periods = 1000;
options_.graph_format = char('eps');
var_list_ = char('ex','imp','rx_1','nx_1');
info = stoch_simul(var_list_);
options_.hp_filter = 6.25;
options_.irf = 80;
options_.order = 1;
options_.periods = 1000;
options_.graph_format = char('eps');
var_list_ = char('ex','imp','a_2','b_1','rx_1','nx_1');
info = stoch_simul(var_list_);
options_.hp_filter = 6.25;
options_.irf = 80;
options_.order = 1;
options_.periods = 1000;
options_.graph_format = char('eps');
var_list_ = char('qa_1','qa_2','qb_1','qb_2');
info = stoch_simul(var_list_);
options_.hp_filter = 6.25;
options_.irf = 80;
options_.order = 1;
options_.periods = 1000;
options_.graph_format = char('eps');
var_list_ = char('a_1','c_1','k_1','y_1','f_1','h','n_1','A_1','r_1','ir_1','p_1');
info = stoch_simul(var_list_);
options_.hp_filter = 6.25;
options_.irf = 80;
options_.order = 1;
options_.periods = 1000;
options_.graph_format = char('eps');
var_list_ = char('k_2','n_2','A_2','y_2','f_2','nx_2','p_2','r_2','rx_2','ir_2','c_2','net_ex_2','qb_2');
info = stoch_simul(var_list_);
save('BKK_style_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('BKK_style_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('BKK_style_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('BKK_style_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('BKK_style_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('BKK_style_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('BKK_style_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
disp('Note: 5 warning(s) encountered in the preprocessor')
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
