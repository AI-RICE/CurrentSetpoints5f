close all;
clear all;
addpath(genpath('src'));
addpath('Initialization');

outpath = 'data';
if ~exist(outpath, 'dir')
    mkdir(outpath);
end

% IPM = PMSM_IEEETIE_machine1();
% IPM.set_max_pars(50, 200, 12000);
% file_save = 'IEEETIE_machine1';
IPM = PMSM_IEEETIE_machine2();
IPM.set_max_pars(30, 13, 1800);
file_save = 'IEEETIE_machine2';

calc_opt.n_T = 201;
calc_opt.n_om = 201;
calc_opt.min_T = 0;
calc_opt.min_om = 0;
calc_opt.opts = optimoptions('fmincon', 'display', 'off');

Vnonrot = false;
W = Transform(IPM, 0, Vnonrot);
grid = grid_calc(IPM, W, calc_opt);

save(fullfile(outpath, file_save), 'grid', 'Vnonrot', 'IPM');
