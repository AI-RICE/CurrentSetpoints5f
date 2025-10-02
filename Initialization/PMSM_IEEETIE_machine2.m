classdef PMSM_IEEETIE_machine2 < PMSMBase2
    methods
        function obj = PMSM_IEEETIE_machine2()
            m = 5;
            pp = 8;
            Rs_vec = [0.0191; 0.0514; 0.0805; 0.0801];
            L = [0.0920   -0.0286   -0.0141    0.0010;
                -0.0133    0.1090   -0.0008   -0.0092;
                -0.0088    0.0037    0.0725   -0.0466;
                -0.0041   -0.0053    0.0475    0.0722]*1e-3;
            Psi_vec = [0.0115; 0.0018; 0; 0];
            TPsi_vec = [0.0122; 0.0005; 0.0001; 0];
            obj@PMSMBase2(m, pp, Rs_vec, L, Psi_vec, TPsi_vec);
        end
    end
end