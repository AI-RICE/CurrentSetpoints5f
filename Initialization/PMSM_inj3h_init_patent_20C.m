classdef PMSM_inj3h_init_patent_20C < PMSMBase1
    methods
        function obj = PMSM_inj3h_init_patent_20C()
            Rs = 0.19;
            Ld1 = 4.61e-3;
            Lq1 = 6e-3;
            Lm1 = 0;
            Ld3 = 1.22e-3;
            Lq3 = 1.97e-3;
            Lm3 = 0;
            Psi_PM1 = 0.241;
            Psi_PM3 = 0;
            Psi_PM3q = 0;
            m = 5;
            pp = 2;
            obj@PMSMBase1(Rs, Ld1, Lq1, Ld3, Lq3, Lm1, Lm3, Psi_PM1, Psi_PM3, Psi_PM3q, m, pp);
        end
    end
end