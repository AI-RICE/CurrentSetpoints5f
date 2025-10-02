close all
clear all

addpath('code_in_c');

file_name_load = "data/machine2/boundary.mat";
vars = load(file_name_load);
boundary = vars.boundary;
data = boundary.data;

% Print parameters for boundary (MATLAB)
for i = 1:data.n_seg
    for j = 1:data.n_seg
        b = boundary.boundary{i, j};
        if ~isempty(b)
            i_mod = data.i_to_seg(i);
            j_mod = data.i_to_seg(j);
            p_string = strjoin(string(b.p), '; ');
            fprintf('p%d%d = [%s];\n', i_mod, j_mod, p_string);
            fprintf('b%d%d_max = %f;\n', i_mod, j_mod, b.b_max);
        end
    end
end

% Print parameters for approximating functions (MATLAB)
k_skip_train = 5;
for i_val = 1:data.n_val
    [~, name] = data.i_to_val_name(i_val);
    for i_seg = 1:data.n_seg        
        file_name = "results/" + name + "_" + string(i_val) + "_" + string(i_seg) + "_" + string(k_skip_train) + ".mat";
        vars = load(file_name);
        fitter = vars.fitter;

        num_terms = (fitter.n+1)*(fitter.n+2)/2;
        p1 = fitter.p(1:num_terms);
        p2 = [1; fitter.p(num_terms+1:end)];
        p1_string = strjoin(string(p1), '; ');
        p2_string = strjoin(string(p2), '; ');

        fprintf('m_%s_%d = %d;\n', name, data.i_to_seg(i_seg), fitter.m);
        fprintf('n_%s_%d = %d;\n', name, data.i_to_seg(i_seg), fitter.n);        
        fprintf('p_%s_%d_num = [%s];\n', name, data.i_to_seg(i_seg), p1_string);
        fprintf('p_%s_%d_den = [%s];\n', name, data.i_to_seg(i_seg), p2_string);
    end
end

% Print parameters for boundary (C)
for i = 1:data.n_seg
    for j = 1:data.n_seg
        b = boundary.boundary{i, j};
        if ~isempty(b)
            i_mod = data.i_to_seg(i);
            j_mod = data.i_to_seg(j);
            p_string = strjoin(string(b.p), ', ');
            fprintf('const double p%d%d[%d] = {%s};\n', i_mod, j_mod, length(b.p), p_string);
            fprintf('const double b%d%d_max = %f;\n', i_mod, j_mod, b.b_max);
        end
    end
end

% Print parameters for approximating functions (C)
k_skip_train = 5;
for i_val = 1:data.n_val
    [~, name] = data.i_to_val_name(i_val);
    for i_seg = 1:data.n_seg        
        file_name = "results/" + name + "_" + string(i_val) + "_" + string(i_seg) + "_" + string(k_skip_train) + ".mat";
        vars = load(file_name);
        fitter = vars.fitter;

        num_terms = (fitter.n+1)*(fitter.n+2)/2;
        p1 = fitter.p(1:num_terms);
        p2 = [1; fitter.p(num_terms+1:end)];
        p1_string = strjoin(string(p1), ', ');
        p2_string = strjoin(string(p2), ', ');

        fprintf('int m_%s_%d = %d;\n', name, data.i_to_seg(i_seg), fitter.m);
        fprintf('int n_%s_%d = %d;\n', name, data.i_to_seg(i_seg), fitter.n);        
        fprintf('static const double p_%s_%d_num[%d] = {%s};\n', name, data.i_to_seg(i_seg), length(p1), p1_string);
        fprintf('static const double p_%s_%d_den[%d] = {%s};\n', name, data.i_to_seg(i_seg), length(p2), p2_string);
    end
end

% Print function calls (C)
k_skip_train = 5;
for i_seg = 1:data.n_seg
    for i_val = 1:data.n_val
        [~, name] = data.i_to_val_name(i_val);
        file_name = "results/" + name + "_" + string(i_val) + "_" + string(i_seg) + "_" + string(k_skip_train) + ".mat";
        vars = load(file_name);
        fitter = vars.fitter;

        num_terms = (fitter.n+1)*(fitter.n+2)/2;
        p1 = fitter.p(1:num_terms);
        p2 = [1; fitter.p(num_terms+1:end)];

        i = data.i_to_seg(i_seg);
        fprintf('*%s = ', name);
        fprintf('polyval2d(p_%s_%d_num, %d, omega, T, n_%s_%d)', name, i, length(p1), name, i);
        fprintf(' / ');
        fprintf('polyval2d(p_%s_%d_den, %d, omega, T, m_%s_%d)', name, i, length(p2), name, i);
        fprintf(';\n');
    end
end
