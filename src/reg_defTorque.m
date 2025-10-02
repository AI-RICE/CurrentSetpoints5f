function [is,exitflag] = reg_defTorque(IPM, tor, W, is0, opts)
    if nargin < 5
        opts = [];
    end
    if nargin < 4 || isempty(is0)
        is0 = [1;0;0;0];
    end

    function [cond,ceq] = mycon(is)
        % TODO: change to linear constraint
        cond = [W.is_to_ua(is)-IPM.Umax; W.is_to_ia(is)-IPM.Imax];
        ceq = is'*IPM.A*is + 2*IPM.b'*is - tor;
    end

    [is,~,exitflag] = fmincon(@(is) is'*is,is0,[],[],[],[],[],[],@(is) mycon(is), opts);
end

