classdef Data < handle
    properties
        segments
        omega
        T
        isd1
        isd3
        isq1
        isq3
        OM
        TT
        i_to_seg
        seg_to_i
        n_seg
        rows = {};
        cols = {};
        row_cols = {};
        n_val = 4;
    end

    methods
        function obj = Data(T, omega, segments, isd1, isd3, isq1, isq3, k_skip)
            obj.T = T;
            obj.omega = omega;
            obj.segments = segments;
            obj.isd1 = isd1;
            obj.isd3 = isd3;
            obj.isq1 = isq1;
            obj.isq3 = isq3;

            if nargin >= 8
                obj.select_k(k_skip)
            end
            obj.compute_data()
        end

        function [val, name] = i_to_val_name(obj, i)
            if i == 1
                val = obj.isd1;
                name = "isd1";
            elseif i == 2
                val = obj.isq1;
                name = "isq1";
            elseif i == 3
                val = obj.isd3;
                name = "isd3";
            elseif i == 4
                val = obj.isq3;
                name = "isq3";
            end
        end

        function val = i_to_val(obj, i)
            [val, ~] = obj.i_to_val_name(i);
        end

        function name = i_to_name(obj, i)
            [~, name] = obj.i_to_val_name(i);
        end

        function select_k(obj, k_skip)
            i_T = 1:k_skip:length(obj.T);
            i_omega = 1:k_skip:length(obj.omega);

            obj.omega = obj.omega(i_omega);
            obj.T = obj.T(i_T);
            obj.segments = obj.segments(i_T, i_omega);
            obj.isd1 = obj.isd1(i_T, i_omega);
            obj.isd3 = obj.isd3(i_T, i_omega);
            obj.isq1 = obj.isq1(i_T, i_omega);
            obj.isq3 = obj.isq3(i_T, i_omega);
        end

        function compute_data(obj)
            [obj.OM, obj.TT] = meshgrid(obj.omega, obj.T);

            segs = sort(unique(obj.segments(~isnan(obj.segments))));
            obj.n_seg = length(segs);
            obj.i_to_seg = dictionary(1:obj.n_seg, segs');
            obj.seg_to_i = dictionary(segs', 1:obj.n_seg);

            for i_seg = 1:obj.n_seg
                idx = obj.segments == obj.i_to_seg(i_seg);
                [row, col] = find(idx);
                row_col = find(idx);

                obj.rows{i_seg} = row;
                obj.cols{i_seg} = col;
                obj.row_cols{i_seg} = row_col;
            end
        end

        function [x, y] = extract_data(obj, i_seg, i_val)
            x1 = obj.omega(obj.cols{i_seg});
            x2 = obj.T(obj.rows{i_seg});
            x = [x1(:), x2(:)];
            
            val = obj.i_to_val(i_val);
            y = val(obj.row_cols{i_seg});
            y = y(:);
        end

        function [x, y] = extract_data_padded(obj, i_seg, i_val, k)
            val = obj.i_to_val(i_val);
            mask = padarray(obj.segments == obj.i_to_seg(i_seg), [k k], false, 'both');
            dist = bwdist(mask, 'cityblock');
            idx = dist <= k;
            [row, col] = find(idx);

            omega_padded = pad_equidistant(obj.omega, k);
            T_padded = pad_equidistant(obj.T, k);
            val_padded = padarray(val, [k k], 'replicate', 'both');

            x1 = omega_padded(col);
            x2 = T_padded(row);
            x = [x1(:), x2(:)];
            
            y = val_padded(idx);
            y = y(:);

            % TODO: smazat, pokud se prida replace nahore
            idx = ~isnan(y);
            x = x(idx,:);
            y = y(idx);
        end

        function plot_segments(obj)
            colors = load_colors();

            figure();
            hold on;
            for i_seg = 1:obj.n_seg
                color = repmat(colors(i_seg,:), length(obj.cols{i_seg}), 1);
                scatter(obj.omega(obj.cols{i_seg}), obj.T(obj.rows{i_seg}), [], color, '.', 'DisplayName', string(obj.i_to_seg(i_seg)));
            end
            legend show;
        end

        function plot_segments_separately(obj)
            for i_seg = 1:obj.n_seg
                figure();
                scatter(obj.omega(obj.cols{i_seg}), obj.T(obj.rows{i_seg}), '.', 'DisplayName', string(obj.i_to_seg(i_seg)));
                legend show;
            end            
        end

        function plot_data(obj, val, title_text, file_name, zlims)
            if nargin < 5
                zlims = [];
            end
            if nargin < 4
                file_name = "";
            end
            if nargin < 3
                title_text = "";
            end

            figure();
            surf(obj.OM, obj.TT, val, obj.segments, 'EdgeColor', 'none');
            xlabel('omega');
            ylabel('torque');            
            title(title_text);
            if ~isempty(zlims)
                zlim(zlims);
            end
            if file_name ~= ""
                print(gcf, file_name, '-dpng', '-r300')
            end
        end

        function plot_thresholds(obj, val, thr, title_text, file_name)
            if nargin < 5
                file_name = "";
            end
            if nargin < 4
                title_text = "";
            end

            idx = abs(val) >= thr;
            idx1 = idx & ~isnan(obj.segments);
            idx2 = ~idx & ~isnan(obj.segments);

            figure();
            hold on;
            scatter(obj.OM(idx2), obj.TT(idx2), '.', 'green');
            scatter(obj.OM(idx1), obj.TT(idx1), '.', 'red');
            xlabel('omega');
            ylabel('torque');
            title(title_text)
            if file_name ~= ""
                print(gcf, file_name, '-dpng', '-r300')
            end
        end
    end
end

function x_pad = pad_equidistant(x, k)
    d = x(2) - x(1);
    left = x(1) - d*(k:-1:1);
    right = x(end) + d*(1:k);
    x_pad = [left, x, right];
end
