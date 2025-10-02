classdef Boundary < handle
    properties
        n_deg
        data
        n_boundary = 0;
        i_to_b
        boundary
    end
    methods
        function obj = Boundary(n_deg, data)
            obj.n_deg = n_deg;
            obj.data = data;
            obj.boundary = cell(data.n_seg, data.n_seg);
        end

        function fit_boundary(obj)
            obj.add_boundary(0, 1, 1);
            obj.add_boundary(1, 2, 1);
            obj.add_boundary(0, 3, 1);
            obj.add_boundary(3, 4, 1);
            obj.add_boundary(3, 6, 2);
            obj.add_boundary(4, 1, 1);
            obj.add_boundary(4, 5, 1);
            obj.add_boundary(4, 7, 1);
            obj.add_boundary(5, 2, 1);
            obj.add_boundary(6, 7, 1);
        end

        function add_boundary(obj, i, j, axis)
            b = extract_boundary(obj.data.segments, i, j, obj.data.omega, obj.data.T, axis);
            p = polyfit(b(:,1), b(:,2), obj.n_deg);
            b_min = min(b(:,1));
            b_max = max(b(:,1));

            i_new = obj.data.seg_to_i(i);
            j_new = obj.data.seg_to_i(j);
            obj.boundary{i_new, j_new} = struct('p', p, 'b', b, 'b_min', b_min, 'b_max', b_max);
            obj.n_boundary = obj.n_boundary + 1;
            obj.i_to_b(obj.n_boundary) = i_new + (j_new - 1) * obj.data.n_seg;
        end

        function [p, b_min, b_max] = get_boundary(obj, i, j)
            b = obj.boundary{obj.data.seg_to_i(i), obj.data.seg_to_i(j)};
            p = b.p;
            b_min = b.b_min;
            b_max = b.b_max;
        end

        function seg = get_segment(obj, omega, T)
            [p01, ~, b01_max] = obj.get_boundary(0, 1);
            [p12, ~, b12_max] = obj.get_boundary(1, 2);
            [p03, ~, b03_max] = obj.get_boundary(0, 3);
            [p34, ~, b34_max] = obj.get_boundary(3, 4);
            [p36, ~, b36_max] = obj.get_boundary(3, 6);
            [p41, ~, b41_max] = obj.get_boundary(4, 1);
            [p45, ~, b45_max] = obj.get_boundary(4, 5);
            [p47, ~, b47_max] = obj.get_boundary(4, 7);
            [p52, ~, b52_max] = obj.get_boundary(5, 2);
            [p67, ~, b67_max] = obj.get_boundary(6, 7);

            if (omega <= b01_max && T < polyval(p01, omega)) || (omega <= b03_max && omega > b01_max && T < polyval(p03, omega))
                seg = 0;
            elseif (omega <= b34_max && omega > b01_max && T < polyval(p34, omega)) || (omega <= b36_max && omega > b34_max && T < polyval(p36, omega))
                seg = 3;
            elseif omega <= b67_max && omega > b34_max && T < polyval(p67, omega)
                seg = 6;
            elseif ((omega <= b01_max && T >= polyval(p01, omega)) || (omega <= b41_max && omega > b01_max && T >= polyval(p41, omega))) && T < polyval(p12, omega)
                seg = 1;
            elseif ((omega <= b12_max && T >= polyval(p12, omega)) || (omega <= b52_max && omega > b12_max && T >= polyval(p52, omega)))
                seg = 2;
            elseif omega <= b45_max && omega > b12_max && T >= polyval(p45, omega)
                seg = 5;
            elseif ((omega <= b47_max && omega > b45_max && T >= polyval(p47, omega)) || (omega > b34_max))
                seg = 7;
            else
                seg = 4;
            end
        end

        function segments_new = create_segments(obj)
            segments = obj.data.segments;
            segments_new = nan(size(segments));

            for i = 1:size(segments,1)
                i
                for j = 1:size(segments,2)
                    omega = obj.data.omega(j);
                    T = obj.data.T(i);
                    segments_new(i,j) = obj.get_segment(omega, T);
                end
            end
            % TODO: this is a bit of a hack.
            segments_new(isnan(segments)) = nan;
        end

        function plot_boundary(obj)
            figure()
            hold on;
            for i = 1:obj.n_boundary
                b = obj.boundary{obj.i_to_b(i)}.b;
                plot(b(:,1), b(:,2));
            end

            figure();
            hold on;
            for i = 1:obj.n_boundary                
                p = obj.boundary{obj.i_to_b(i)}.p;
                b_min = obj.boundary{obj.i_to_b(i)}.b_min;
                b_max = obj.boundary{obj.i_to_b(i)}.b_max;
                omega_range = linspace(b_min, b_max, 100);
                plot(omega_range, polyval(p, omega_range));
            end
        end
    end
end

function b = extract_boundary(clr, i, j, vals_x, vals_y, dims)
    if dims == 1
        b = extract_boundary_along_y(clr, i, j, vals_x, vals_y);
    elseif dims == 2
        b = extract_boundary_along_x(clr, i, j, vals_x, vals_y);
    else
        error('Dimension not known');
    end
end

function b = extract_boundary_along_x(clr, i, j, vals_x, vals_y)
    [m, n] = size(clr);
    b = zeros(0, 2);
    for k = 1:m
        idx = find(clr(k,:) == i);
        if ~isempty(idx)
            idx_max = max(idx);
            if idx_max < n && ismember(clr(k,idx_max+1), j)
                add1 = 0.5*(vals_x(idx_max)+vals_x(idx_max+1));
                add2 = vals_y(k);
                b = [b; add1, add2];
            end
        end
    end
    b = sortrows(b(:, [2, 1]));
    b = b(:, [2, 1]);
end

function b = extract_boundary_along_y(clr, i, j, vals_x, vals_y)
    [m, n] = size(clr);
    b = zeros(0, 2);
    for k = 1:n
        idx = find(clr(:,k) == i);
        if ~isempty(idx)
            idx_max = max(idx);
            if idx_max < m && clr(idx_max+1,k) == j
                add1 = vals_x(k);
                add2 = 0.5*(vals_y(idx_max)+vals_y(idx_max+1));
                b = [b; add1, add2];
            end
        end
    end
    b = sortrows(b);
end