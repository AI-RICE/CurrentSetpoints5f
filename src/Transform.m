classdef Transform < handle
    properties
        matrix_i_to_u
        vector_i_to_u
        matrix_s_to_a
        matrix_is_to_ua
        vector_is_to_ua
        th
        om
        n_phases
        add_u0
        % Auxiliary variables
        matrix_i_to_u_fixed0
        matrix_i_to_u_fixed0_om
        vector_i_to_u0_om
    end
    
    methods
        function obj = Transform(P, om, add_u0, n_theta)
            if nargin < 4
                n_theta = 700;
            end
            n_theta = round(n_theta/(2*P.m))*2*P.m;
            
            obj.th = linspace(0, 2*pi, n_theta+1)';
            obj.n_phases = P.m;
            obj.add_u0 = add_u0;
            obj.compute_matrices_init(P)
            obj.compute_matrices(om)
        end

        function compute_matrices_init(obj, P)
            obj.matrix_i_to_u_fixed0 = P.Rs*eye(4);
            obj.matrix_i_to_u_fixed0_om = P.J*P.L; %resistance+reactance
            obj.vector_i_to_u0_om = P.J*P.Psi;
            obj.matrix_s_to_a = [cos(obj.th) -sin(obj.th) cos(3*obj.th) -sin(3*obj.th)]; %rotation
        end

        function compute_matrices(obj, om)
            obj.om = om;
            obj.matrix_i_to_u = obj.matrix_i_to_u_fixed0 + om*obj.matrix_i_to_u_fixed0_om; %resistance+reactance
            obj.vector_i_to_u = om*obj.vector_i_to_u0_om;
            obj.matrix_is_to_ua = obj.matrix_s_to_a*obj.matrix_i_to_u;
            obj.vector_is_to_ua = obj.matrix_s_to_a*obj.vector_i_to_u; %voltages-only induced by flux PM
        end

        function change_om(obj, om)
            obj.compute_matrices(om)
        end
        
        function ia = is_to_ia(obj, is)
            ia = obj.matrix_s_to_a * is;
        end

        function us = is_to_us(obj, is)
            us = obj.matrix_i_to_u * is + obj.vector_i_to_u;
        end

        function ua = us_to_ua(obj, us)
            ua = obj.matrix_s_to_a * us;
        end

        function [Ua, U0, Ua13] = is_to_ua(obj, is)
            Ua13 = obj.matrix_is_to_ua * is + obj.vector_is_to_ua;

            if obj.add_u0
                Uf = reshape(Ua13(1:(end-1)), [], obj.n_phases);
                U0 = -0.5*(min(Uf,[],2) + max(Uf,[],2));
                Ua = reshape(Uf + U0, [], 1);
                U0 = repmat(U0, obj.n_phases, 1);
                U0 = [U0; U0(1)];
                Ua = [Ua; Ua(1)];
            else
                Ua = Ua13;
                U0 = zeros(size(Ua13));
            end
        end

        function [mI, eps_diff, U, mU, beta_diff, mU13, U0rms, mU0] = maximal_IU(obj, is)
            [Ua, U0, Ua13] = obj.is_to_ua(is);
            mI = max(obj.is_to_ia(is));
            mU = max(Ua);
            mU13 = max(Ua13);
            U0rms = rms(U0);
            mU0 = max(U0);
            eps1 = atan2(is(2), is(1));
            eps3 = atan2(is(4), is(3));
            eps_diff = abs(mod(eps1*3+pi,2*pi) -  mod(eps3,2*pi));
            U = obj.is_to_us(is);
            beta1 = atan2(U(2), U(1));
            beta3 = atan2(U(4), U(3));
            beta_diff = abs(mod(beta1*3+pi,2*pi) -  mod(beta3,2*pi));
        end

        function [n_I, n_U] = number_of_peaks(obj, is, IPM, tol)
            if nargin < 4
                tol = 1e-4;
            end
            [mI, eps_diff, ~, mU, beta_diff, ~, ~, ~] = obj.maximal_IU(is);
            n_I = number_of_peaks(mI, IPM.Imax, eps_diff, tol);
            n_U = number_of_peaks(mU, IPM.Umax, beta_diff, tol);
        end
    end
end

function n = number_of_peaks(value, value_max, eps, tol)
    if abs(value-value_max) < tol
        if eps < tol*value_max
            n = 2;
        else
            n = 1;
        end
    else
        n = 0;
    end
end
