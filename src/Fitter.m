classdef Fitter < handle
    properties
        n
        m        
        fun
        p_size
        opts
        p
    end
    methods
        function obj = Fitter(n, m, opts)
            if nargin < 3
                opts = [];
            end
            obj.n = n;
            obj.m = m;
            obj.fun = rational2d_fun(n, m);
            obj.p_size = (n+1)*(n+2)/2 + (m+1)*(m+2)/2 - 1;
            obj.opts = opts;
        end

        function [p, mae] = fit(obj, p0, x, y)
            p = lsqcurvefit(obj.fun, p0, x, y, [], [], obj.opts);
            y_pred = obj.fun(p, x);
            mae = max(abs(y_pred-y));
        end

        function set_p(obj, p)
            obj.p = p;
        end

        function y = predict(obj, x)
            y = obj.fun(obj.p, x);
        end
    end
end

function fun = rational2d_fun(n, m)
    % n: degree numerator, m: degree denominator
    % Returns a function handle for use with lsqcurvefit
    % Coefficients: [a00, a10, a01, ..., b10, b01, ...] (denominator b00 fixed at 1)
    num_terms = (n+1)*(n+2)/2;

    fun = @(p, x) ...
        polyval2d(p(1:num_terms), x(:,1), x(:,2), n) ./ ...
            polyval2d([1; p(num_terms+1:end)], x(:,1), x(:,2), m);
end

function y = polyval2d(c, x1, x2, deg)
    % Evaluates a 2D polynomial of degree 'deg' with coefficients c
    idx = 1;
    y = zeros(size(x1));
    for i = 0:deg
        for j = 0:(deg-i)
            y = y + c(idx) .* x1.^i .* x2.^j;
            idx = idx + 1;
        end
    end
end


