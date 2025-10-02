classdef PMSM_inj3h_init_patent_20C_Psi3pos_zpresnenepro50Nm < PMSMBase1
    methods
        function obj = PMSM_inj3h_init_patent_20C_Psi3pos_zpresnenepro50Nm()
            Rs = 0.19;
            Ld1 = 4.94e-3;
            Lq1 = 10.62e-3;
            Lm1 = 0;
            Ld3 = 2.05e-3;
            Lq3 = 2.14e-3;
            Lm3 = 0;
            Psi_PM1 = 0.241;
            Psi_PM3 = 0.0367;
            Psi_PM3q = -0.0152;
            m = 5;
            pp = 2;
            obj@PMSMBase1(Rs, Ld1, Lq1, Ld3, Lq3, Lm1, Lm3, Psi_PM1, Psi_PM3, Psi_PM3q, m, pp);
        end
    end
end