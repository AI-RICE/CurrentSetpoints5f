classdef PMSM_inj3h_init_patent_20C_Ansys_iter < PMSMBase1
    methods
        function obj = PMSM_inj3h_init_patent_20C_Ansys_iter()
            Rs = 0.19;
            Ld1 = 4.69e-3;
            Lq1 = 8.5e-3;
            Lm1 = 0;
            Ld3 = 1.86e-3;
            Lq3 = 1.88e-3;
            Lm3 = 0;
            Psi_PM1 = 0.241;
            Psi_PM3 = 0.0277;
            Psi_PM3q = -0.0101;
            m = 5;
            pp = 2;
            obj@PMSMBase1(Rs, Ld1, Lq1, Ld3, Lq3, Lm1, Lm3, Psi_PM1, Psi_PM3, Psi_PM3q, m, pp);
        end
    end
end