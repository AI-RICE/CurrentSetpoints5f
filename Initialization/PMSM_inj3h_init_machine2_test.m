classdef PMSM_inj3h_init_machine2_test < PMSMBase1
    methods
        function obj = PMSM_inj3h_init_machine2_test()
            Rs = 0.30;
            Ld1 = 50e-6;
            Lq1 = 50e-6;
            Lm1 = 0;
            Ld3 = 68e-6;
            Lq3 = 68e-6;
            Lm3 = 0;
            Psi_PM1 = 0.0115;
            Psi_PM3 = 0;
            Psi_PM3q = 0;
            m = 5;
            pp = 8;
            obj@PMSMBase1(Rs, Ld1, Lq1, Ld3, Lq3, Lm1, Lm3, Psi_PM1, Psi_PM3, Psi_PM3q, m, pp);
        end
    end
end