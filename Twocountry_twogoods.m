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
M_.fname = 'Twocountry_twogoods';
M_.dynare_version = '4.5.7';
oo_.dynare_version = '4.5.7';
options_.dynare_version = '4.5.7';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('Twocountry_twogoods.log');
M_.exo_names = 'cp';
M_.exo_names_tex = 'cp';
M_.exo_names_long = 'cp';
M_.exo_names = char(M_.exo_names, 'e2');
M_.exo_names_tex = char(M_.exo_names_tex, 'e2');
M_.exo_names_long = char(M_.exo_names_long, 'e2');
M_.endo_names = 'c1';
M_.endo_names_tex = 'c1';
M_.endo_names_long = 'c1';
M_.endo_names = char(M_.endo_names, 'c2');
M_.endo_names_tex = char(M_.endo_names_tex, 'c2');
M_.endo_names_long = char(M_.endo_names_long, 'c2');
M_.endo_names = char(M_.endo_names, 'k1');
M_.endo_names_tex = char(M_.endo_names_tex, 'k1');
M_.endo_names_long = char(M_.endo_names_long, 'k1');
M_.endo_names = char(M_.endo_names, 'k2');
M_.endo_names_tex = char(M_.endo_names_tex, 'k2');
M_.endo_names_long = char(M_.endo_names_long, 'k2');
M_.endo_names = char(M_.endo_names, 'a1');
M_.endo_names_tex = char(M_.endo_names_tex, 'a1');
M_.endo_names_long = char(M_.endo_names_long, 'a1');
M_.endo_names = char(M_.endo_names, 'a2');
M_.endo_names_tex = char(M_.endo_names_tex, 'a2');
M_.endo_names_long = char(M_.endo_names_long, 'a2');
M_.endo_names = char(M_.endo_names, 'lab1');
M_.endo_names_tex = char(M_.endo_names_tex, 'lab1');
M_.endo_names_long = char(M_.endo_names_long, 'lab1');
M_.endo_names = char(M_.endo_names, 'lab2');
M_.endo_names_tex = char(M_.endo_names_tex, 'lab2');
M_.endo_names_long = char(M_.endo_names_long, 'lab2');
M_.endo_names = char(M_.endo_names, 'y1');
M_.endo_names_tex = char(M_.endo_names_tex, 'y1');
M_.endo_names_long = char(M_.endo_names_long, 'y1');
M_.endo_names = char(M_.endo_names, 'y2');
M_.endo_names_tex = char(M_.endo_names_tex, 'y2');
M_.endo_names_long = char(M_.endo_names_long, 'y2');
M_.endo_names = char(M_.endo_names, 'inv1');
M_.endo_names_tex = char(M_.endo_names_tex, 'inv1');
M_.endo_names_long = char(M_.endo_names_long, 'inv1');
M_.endo_names = char(M_.endo_names, 'inv2');
M_.endo_names_tex = char(M_.endo_names_tex, 'inv2');
M_.endo_names_long = char(M_.endo_names_long, 'inv2');
M_.endo_names = char(M_.endo_names, 'tb1');
M_.endo_names_tex = char(M_.endo_names_tex, 'tb1');
M_.endo_names_long = char(M_.endo_names_long, 'tb1');
M_.endo_names = char(M_.endo_names, 'tb2');
M_.endo_names_tex = char(M_.endo_names_tex, 'tb2');
M_.endo_names_long = char(M_.endo_names_long, 'tb2');
M_.endo_names = char(M_.endo_names, 'imp1');
M_.endo_names_tex = char(M_.endo_names_tex, 'imp1');
M_.endo_names_long = char(M_.endo_names_long, 'imp1');
M_.endo_names = char(M_.endo_names, 'imp2');
M_.endo_names_tex = char(M_.endo_names_tex, 'imp2');
M_.endo_names_long = char(M_.endo_names_long, 'imp2');
M_.endo_names = char(M_.endo_names, 'd1');
M_.endo_names_tex = char(M_.endo_names_tex, 'd1');
M_.endo_names_long = char(M_.endo_names_long, 'd1');
M_.endo_names = char(M_.endo_names, 'd2');
M_.endo_names_tex = char(M_.endo_names_tex, 'd2');
M_.endo_names_long = char(M_.endo_names_long, 'd2');
M_.endo_names = char(M_.endo_names, 'h');
M_.endo_names_tex = char(M_.endo_names_tex, 'h');
M_.endo_names_long = char(M_.endo_names_long, 'h');
M_.endo_names = char(M_.endo_names, 'tb1_y');
M_.endo_names_tex = char(M_.endo_names_tex, 'tb1\_y');
M_.endo_names_long = char(M_.endo_names_long, 'tb1_y');
M_.endo_names = char(M_.endo_names, 'tb2_y');
M_.endo_names_tex = char(M_.endo_names_tex, 'tb2\_y');
M_.endo_names_long = char(M_.endo_names_long, 'tb2_y');
M_.endo_partitions = struct();
M_.param_names = 'gamma';
M_.param_names_tex = 'gamma';
M_.param_names_long = 'gamma';
M_.param_names = char(M_.param_names, 'delta');
M_.param_names_tex = char(M_.param_names_tex, 'delta');
M_.param_names_long = char(M_.param_names_long, 'delta');
M_.param_names = char(M_.param_names, 'alpha');
M_.param_names_tex = char(M_.param_names_tex, 'alpha');
M_.param_names_long = char(M_.param_names_long, 'alpha');
M_.param_names = char(M_.param_names, 'beta');
M_.param_names_tex = char(M_.param_names_tex, 'beta');
M_.param_names_long = char(M_.param_names_long, 'beta');
M_.param_names = char(M_.param_names, 'rhoH');
M_.param_names_tex = char(M_.param_names_tex, 'rhoH');
M_.param_names_long = char(M_.param_names_long, 'rhoH');
M_.param_names = char(M_.param_names, 'rhoN');
M_.param_names_tex = char(M_.param_names_tex, 'rhoN');
M_.param_names_long = char(M_.param_names_long, 'rhoN');
M_.param_names = char(M_.param_names, 'rhoA');
M_.param_names_tex = char(M_.param_names_tex, 'rhoA');
M_.param_names_long = char(M_.param_names_long, 'rhoA');
M_.param_names = char(M_.param_names, 'r');
M_.param_names_tex = char(M_.param_names_tex, 'r');
M_.param_names_long = char(M_.param_names_long, 'r');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 2;
M_.endo_nbr = 21;
M_.param_nbr = 8;
M_.orig_endo_nbr = 21;
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
erase_compiled_function('Twocountry_twogoods_static');
erase_compiled_function('Twocountry_twogoods_dynamic');
M_.orig_eq_nbr = 21;
M_.eq_nbr = 21;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 0 10 31;
 0 11 32;
 1 12 33;
 2 13 34;
 3 14 35;
 4 15 36;
 5 16 37;
 6 17 38;
 0 18 0;
 0 19 0;
 0 20 0;
 0 21 0;
 0 22 0;
 0 23 0;
 0 24 0;
 0 25 0;
 7 26 0;
 8 27 0;
 9 28 0;
 0 29 0;
 0 30 0;]';
M_.nstatic = 10;
M_.nfwrd   = 2;
M_.npred   = 3;
M_.nboth   = 6;
M_.nsfwrd   = 8;
M_.nspred   = 9;
M_.ndynamic   = 11;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:2];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(21, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(2, 1);
M_.params = NaN(8, 1);
M_.NNZDerivatives = [77; -1; -1];
M_.params( 1 ) = 2;
gamma = M_.params( 1 );
M_.params( 2 ) = .05;
delta = M_.params( 2 );
M_.params( 3 ) = .32;
alpha = M_.params( 3 );
M_.params( 4 ) = 0.98;
beta = M_.params( 4 );
M_.params( 7 ) = 0.42;
rhoA = M_.params( 7 );
M_.params( 6 ) = 0.04;
rhoN = M_.params( 6 );
M_.params( 8 ) = 0.04;
r = M_.params( 8 );
M_.params( 5 ) = 0.92;
rhoH = M_.params( 5 );
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 3 ) = 2.8;
oo_.steady_state( 4 ) = 2.8;
oo_.steady_state( 1 ) = .8;
oo_.steady_state( 2 ) = .8;
oo_.steady_state( 7 ) = .3;
oo_.steady_state( 8 ) = .3;
oo_.steady_state( 11 ) = 0.6;
oo_.steady_state( 12 ) = 0.6;
oo_.steady_state( 9 ) = 1;
oo_.steady_state( 10 ) = 1;
oo_.steady_state( 5 ) = 0;
oo_.steady_state( 6 ) = 0;
oo_.steady_state( 19 ) = 1;
oo_.exo_steady_state( 2 ) = 0;
oo_.exo_steady_state( 1 ) = 0.00;
if M_.exo_nbr > 0
	oo_.exo_simul = ones(M_.maximum_lag,1)*oo_.exo_steady_state';
end
if M_.exo_det_nbr > 0
	oo_.exo_det_simul = ones(M_.maximum_lag,1)*oo_.exo_det_steady_state';
end
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = (.024)^2;
steady;
options_.hp_filter = 6.25;
options_.irf = 80;
options_.order = 1;
options_.periods = 1000;
var_list_ = char('y1','imp1','tb1_y');
info = stoch_simul(var_list_);
options_.hp_filter = 6.25;
options_.irf = 80;
options_.order = 1;
options_.periods = 1000;
var_list_ = char('c1','k1','a1','lab1','inv1','d1','h');
info = stoch_simul(var_list_);
options_.hp_filter = 6.25;
options_.irf = 80;
options_.order = 1;
options_.periods = 1000;
var_list_ = char('k2','y2','inv2','imp2','tb2_y');
info = stoch_simul(var_list_);
save('Twocountry_twogoods_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('Twocountry_twogoods_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('Twocountry_twogoods_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('Twocountry_twogoods_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('Twocountry_twogoods_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('Twocountry_twogoods_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('Twocountry_twogoods_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
disp('Note: 3 warning(s) encountered in the preprocessor')
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
