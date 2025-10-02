function [is,tor,exitflag] = reg_maxTorque(IPM, W, is0, opts)
    if nargin < 4
        opts = [];
    end
    if nargin < 3 || isempty(is0)
        is0 = [1;0;0;0];
    end

    function [cond,ceq] = mycon(is)
        cond = [W.is_to_ua(is)-IPM.Umax; W.is_to_ia(is)-IPM.Imax];
        ceq = [];
    end
    [is,tor_neg,exitflag] = fmincon(@(is) -(is'*IPM.A*is+2*IPM.b'*is),is0,[],[],[],[],[],[],@(is) mycon(is),opts);
    tor = -tor_neg;
end

