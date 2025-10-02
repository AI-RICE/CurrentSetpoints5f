close all;
clear all;
addpath(genpath('src'));
addpath('Initialization');

file_name_load = "data/IEEETIE_machine2_smooth.mat";
k_skip = 5;
vars = load(file_name_load);
data = grid_to_data(vars.grid, k_skip);
data_test = grid_to_data(vars.grid, 1);

% Error on the training samples
for i_val = 1:data.n_val
    results = array2table(nan(data.n_seg,6), 'VariableNames', {'seg','m','n','rmse','mae','data_n'});
    [~, name] = data.i_to_val_name(i_val);
    for i_seg = 1:data.n_seg
        file_name = "data/fitter/" + name + "_" + string(i_val) + "_" + string(i_seg) + "_" + string(k_skip) + ".mat";
        vars = load(file_name);
        fitter = vars.fitter;

        [x, y] = data.extract_data(i_seg, i_val);
        y_pred = fitter.predict(x);

        results.seg(i_seg) = data.i_to_seg(i_seg);
        results.m(i_seg) = fitter.m;
        results.n(i_seg) = fitter.n;
        results.rmse(i_seg) = sqrt(mean((y_pred - y).^2));
        results.mae(i_seg) = max(abs(y_pred-y));
        results.data_n(i_seg) = length(y);
    end
    results
end

% Error on the test samples
for i_val = 1:data_test.n_val
    [val, name] = data_test.i_to_val_name(i_val);
    
    val_pred = nan(size(val));
    for i_seg_old = 1:data.n_seg
        i_seg = data_test.seg_to_i(data.i_to_seg(i_seg_old));
        file_name = "data/fitter/" + name + "_" + string(i_val) + "_" + string(i_seg_old) + "_" + string(k_skip) + ".mat";
        vars = load(file_name);
        fitter = vars.fitter;

        [x, y] = data_test.extract_data(i_seg, i_val);
        y_pred = fitter.predict(x);

        val_pred(data_test.row_cols{i_seg}) = y_pred;
    end

    file_name = name + "_" + string(k_skip) + "_true.png";
    data_test.plot_data(val, name + ": true", file_name);

    file_name = name + "_" + string(k_skip) + "_pred.png";
    data_test.plot_data(val_pred, name + ": pred", file_name);

    file_name = name + "_" + string(k_skip) + "_diff.png";
    data_test.plot_data(abs(val-val_pred), name + ": error", file_name, [0,0.5]);

    for thr = [0.1, 0.2]
        file_name = name + "_" + string(k_skip) + "_" + string(thr) + ".png";
        data_test.plot_thresholds(val-val_pred, thr, name + ": error above " + string(thr), file_name);
    end
end