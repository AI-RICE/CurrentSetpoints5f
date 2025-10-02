function data = grid_to_data(grid, k_skip)
    data = Data(grid.T, grid.c_mech_speed*grid.om_vec, grid.clr, grid.isd1, grid.isd3, grid.isq1, grid.isq3, k_skip);
end