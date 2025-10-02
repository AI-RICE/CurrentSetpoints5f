classdef (Abstract) PMSMBase2 < PMSMBase
    properties
        Psi
        TPsi
    end
    methods
        function obj = PMSMBase2(m, pp, Rs_vec, L, Psi_vec, TPsi_vec)
            obj@PMSMBase(m, pp);
            obj.Rs = diag(Rs_vec);
            obj.L = L;
            obj.Psi = Psi_vec;
            obj.TPsi = TPsi_vec;
            obj.A = zeros(4);
            obj.b = m*pp/4*obj.J*obj.TPsi;
            obj.check_data()
        end
    end
end