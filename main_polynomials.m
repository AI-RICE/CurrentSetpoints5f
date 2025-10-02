close all;
clear all;
addpath(genpath('src'));
addpath('Initialization');

file_name_load = "data/IEEETIE_machine2_smooth.mat";
k_skip = 5;
mae_tol = 0.01;
n_iter = 100;
ns = [3, 3, 3];
ms = [0, 1, 2];
opts = optimoptions('lsqcurvefit', 'Display', 'off', 'MaxFunctionEvaluations', 1e4);

vars = load(file_name_load);
data = grid_to_data(vars.grid, k_skip);
for i_val = 1:data.n_val
    results = array2table(nan(data.n_seg,6), 'VariableNames', {'seg','m','n','rmse','mae','data_n'});
    for i_seg = 1:data.n_seg
        i_seg
        T = array2table(nan(length(ns),4), 'VariableNames', {'m','n','rmse','mae'});
        [x, y] = data.extract_data(i_seg, i_val);
        fitters = cell(length(ns), 1);
        for i_n = 1:length(ns)
            fitter = Fitter(ns(i_n), ms(i_n), opts);
            for i_iter = 1:n_iter
                p0 = randn(fitter.p_size, 1);
                [p, mae] = fitter.fit(p0, x, y);
                if i_iter == 1 || mae < mae_best
                    mae_best = mae;
                    p_best = p;
                end
                if mae <= mae_tol
                    break
                end
            end
            
            fitter.set_p(p_best);
            y_pred = fitter.predict(x);

            fitters{i_n} = fitter;
            T.m(i_n) = ms(i_n);
            T.n(i_n) = ns(i_n);
            T.rmse(i_n) = sqrt(mean((y_pred - y).^2));
            T.mae(i_n) = max(abs(y_pred-y));

            if T.mae(i_n) <= mae_tol
                break
            end
        end

        [~, i_min] = min(T.mae);
        fitter = fitters{i_min};
        [~, name] = data.i_to_val_name(i_val);
        file_name = "data/fitter/" + name + "_" + string(i_val) + "_" + string(i_seg) + "_" + string(k_skip) + ".mat";
        save(file_name, 'fitter');
    end
end
