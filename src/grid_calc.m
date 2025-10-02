function grid = grid_calc(IPM, W, calc_opt)
    W.change_om(0);
    [~, max_T_global] = reg_maxTorque(IPM, W, [], calc_opt.opts);
    
    grid = [];
    grid.c_mech_speed = 30/(pi*IPM.pp);
    grid.T = linspace(calc_opt.min_T, max_T_global, calc_opt.n_om);
    grid.om_vec = linspace(calc_opt.min_om/grid.c_mech_speed, IPM.nmax/grid.c_mech_speed, calc_opt.n_T);
    
    grid.max_T = nan(1, calc_opt.n_om);
    grid.isd1 = nan(calc_opt.n_T, calc_opt.n_om);
    grid.isd3 = nan(calc_opt.n_T, calc_opt.n_om);
    grid.isq1 = nan(calc_opt.n_T, calc_opt.n_om);
    grid.isq3 = nan(calc_opt.n_T, calc_opt.n_om);
    grid.mI = nan(calc_opt.n_T, calc_opt.n_om);
    grid.mU = nan(calc_opt.n_T, calc_opt.n_om);
    grid.epsIdiff = nan(calc_opt.n_T, calc_opt.n_om);
    grid.epsUdiff = nan(calc_opt.n_T, calc_opt.n_om);
    grid.clr = nan(calc_opt.n_T, calc_opt.n_om);

    for k_om = 1:calc_opt.n_om
        k_om
        W.change_om(grid.om_vec(k_om));
        [~, grid.max_T(1,k_om)] = reg_maxTorque(IPM, W, [], calc_opt.opts);
        is = [1;0;0;0];
        for k_T = 1:calc_opt.n_T
            if grid.T(k_T) > grid.max_T(1,k_om) || grid.T(k_T) > max_T_global
                break
            end
            is = reg_defTorque(IPM, grid.T(k_T), W, is, calc_opt.opts);
            [Im, eps_diff, ~, Um, beta_diff, mU13, U0rms, mU0] = W.maximal_IU(is);
            grid.isd1(k_T,k_om) = is(1);
            grid.isq1(k_T,k_om) = is(2);
            grid.isd3(k_T,k_om) = is(3);
            grid.isq3(k_T,k_om) = is(4);

            grid.mI(k_T,k_om) = Im;
            grid.mU(k_T,k_om) = Um;
            grid.epsIdiff(k_T,k_om) = eps_diff;
            grid.epsUdiff(k_T,k_om) = beta_diff;

            grid.mU13(k_T,k_om) = mU13;
            grid.U0rms(k_T,k_om) = U0rms;
            grid.mU0(k_T,k_om) = mU0;

            [peaks_I, peaks_U] = W.number_of_peaks(is, IPM);
            grid.clr(k_T,k_om) = 3*peaks_U + peaks_I;
        end
    end
end
