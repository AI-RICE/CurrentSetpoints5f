function CO = make_plots_colors(data)
    colors = load_colors();
    [m, n] = size(data.segments);
    CO = zeros(m, n, 3);
    for i = 1:m
        for j = 1:n
            if ~isnan(data.segments(i,j))
                CO(i,j,:) = colors(data.seg_to_i(data.segments(i,j)), :);
            end
        end
    end
end