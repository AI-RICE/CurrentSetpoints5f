classdef PMSM_inj3h_init_reluctance < PMSMBase1
    methods
        function obj = PMSM_inj3h_init_reluctance()
            Rs = 0.19;
            Ld1 = 4.41e-3;
            Lq1 = 6.19e-3;
            Lm1 = 0;
            Ld3 = 1.31e-3;
            Lq3 = 1.31e-3;
            Lm3 = 0;
            Psi_PM1 = 0;
            Psi_PM3 = 0;
            Psi_PM3q = 0;
            m = 5;
            pp = 2;
            obj@PMSMBase1(Rs, Ld1, Lq1, Ld3, Lq3, Lm1, Lm3, Psi_PM1, Psi_PM3, Psi_PM3q, m, pp);
        end
    end
end