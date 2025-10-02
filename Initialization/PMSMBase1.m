classdef (Abstract) PMSMBase1 < PMSMBase
    properties
        Lsd1 % d-inductance, first harmonic
        Lsq1 % q-inductance, first harmonic
        Lsd3 % d-inductance, third harmonic
        Lsq3 % q-inductance, third harmonic
        Lm1 % mutual d - q inductance, first harmonic
        Lm3 % mutual d - q inductance, third harmonic
        Fmag1 % permanent magnet flux linkage, first harmonic
        Fmag3 % permanent magnet flux linkage, third harmonic
        Fmag3q 
        Psi
    end
    methods
        function obj = PMSMBase1(Rs, Ld1, Lq1, Ld3, Lq3, Lm1, Lm3, Psi_PM1, Psi_PM3, Psi_PM3q, m, pp)
            obj@PMSMBase(m, pp);
            obj.Rs = Rs;
            obj.Lsd1 = Ld1;
            obj.Lsq1 = Lq1;
            obj.Lsd3 = Ld3;
            obj.Lsq3 = Lq3;
            obj.Lm1 = Lm1;
            obj.Lm3 = Lm3;
            obj.Fmag1 = Psi_PM1;
            obj.Fmag3 = Psi_PM3;
            obj.Fmag3q = Psi_PM3q;
            obj.L = [[Ld1 Lm1; Lm1 Lq1], zeros(2,2); zeros(2,2), [Ld3 Lm3; Lm3 Lq3]];
            obj.Psi = [Psi_PM1; 0; Psi_PM3; Psi_PM3q];
            % Torque parameters
            T1 = m*pp/2*[-Lm1, (Ld1-Lq1)/2; (Ld1-Lq1)/2, Lm1];
            T3 = 3*m*pp/2*[-Lm3, (Ld3-Lq3)/2; (Ld3-Lq3)/2, Lm3];
            % TODO: rename to T and t?
            obj.A = [T1, zeros(2,2); zeros(2,2), T3];
            obj.b = m*pp/2*[0; Psi_PM1/2; -3*Psi_PM3q/2; 3*Psi_PM3/2];
            obj.check_data()
        end
    end
end
