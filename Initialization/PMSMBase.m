classdef (Abstract) PMSMBase < handle
    properties
        m % number of phases
        pp % number of polepairs
        J
        kp
        L
        Rs
        A
        b
        Imax % maximum current
        Umax % maximum voltage
        nmax % maximum rotation
    end
    methods
        function obj = PMSMBase(m, pp)
            obj.m = m;
            obj.pp = pp;
            obj.kp = m / 2;
            obj.J = [0 -1 0 0; 1 0 0 0; 0 0 0 -3; 0 0 3 0];
        end

        function check_data(obj)
            obj.check_matrix(obj.A, false, 'A')
            obj.check_matrix(obj.L, false, 'L')
            obj.check_matrix(obj.Rs, true, 'Rs')
            obj.check_vector(obj.b, 'b')
        end

        function check_matrix(obj, A, scalar_allowed, name)
            if size(A,1) ~= size(A,2)
                error('Matrix %s must be square.', name);
            end
            if ~scalar_allowed && size(A,1) ~= obj.m - 1
                error('Matrix %s must be square and sized to number of phases.', name);
            end
        end

        function check_vector(obj, a, name)
            if size(a,1) ~= obj.m - 1 || size(a,2) ~= 1
                error('Vector %s must be a column vector with length equal to number of phases.', name);
            end
        end

        function set_max_pars(obj, Imax, Umax, nmax)
            obj.Imax = Imax;
            obj.Umax = Umax;
            obj.nmax = nmax;
        end
    end
end
