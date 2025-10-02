close all;
clear all;
addpath(genpath('src'));
addpath('Initialization');

file_name_load = "data/IEEETIE_machine2.mat";
file_name_save = "data/IEEETIE_machine2_smooth.mat";
k_skip = 1;
n_deg = 4;
vars = load(file_name_load);
data = grid_to_data(vars.grid, k_skip);

boundary = Boundary(n_deg, data);
boundary.fit_boundary()
boundary.plot_boundary()
segments_new = boundary.create_segments();

data_new = Data(data.T, data.omega, segments_new, data.isd1, data.isd3, data.isq1, data.isq3);

data.plot_segments();
data_new.plot_segments();

vars.grid.clr = segments_new;
vars.boundary = boundary;

save(file_name_save, '-struct', 'vars');
