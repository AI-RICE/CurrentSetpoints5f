classdef PMSM_inj3h_init_ZF_5f < PMSMBase1
    methods
        function obj = PMSM_inj3h_init_ZF_5f()
            Rs = 0.0255;
            Ld1 = 86e-6;
            Lq1 = 94e-6;
            Lm1 = 0;
            Ld3 = 67e-6;
            Lq3 = 40e-6;
            Lm3 = 0;
            Psi_PM1 = 0.01159;
            Psi_PM3 = 0.000178;
            Psi_PM3q = 0;
            m = 5;
            pp = 8;
            obj@PMSMBase1(Rs, Ld1, Lq1, Ld3, Lq3, Lm1, Lm3, Psi_PM1, Psi_PM3, Psi_PM3q, m, pp);
        end
    end
end