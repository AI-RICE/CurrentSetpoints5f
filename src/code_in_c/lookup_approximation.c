#include <stdio.h>
#include <math.h>

// 1D polynomial evaluation - Horner's method
double polyval(const double *p, int degree, double x) {
    double y = 0.0;
    for (int i = 0; i <= degree; i++) {
        y = y * x + p[i];
    }
    return y;
}

double polyval2d(double *c, int len_c, double x1, double x2, int deg) {
    if (deg > 5 || len_c == 0) return 0.0;

    // Pre-compute all needed powers
    double x1_2 = x1 * x1;
    double x1_3 = x1_2 * x1;
    double x1_4 = x1_3 * x1;
    double x1_5 = x1_4 * x1;

    double x2_2 = x2 * x2;
    double x2_3 = x2_2 * x2;
    double x2_4 = x2_3 * x2;
    double x2_5 = x2_4 * x2;

    double y = 0.0;

    switch(deg) {
        case 0:
            return (len_c > 0) ? c[0] : 0.0;

        case 1:
            y += (len_c > 0) ? c[0] : 0.0;                    // 1
            y += (len_c > 1) ? c[1] * x2 : 0.0;              // x2
            y += (len_c > 2) ? c[2] * x1 : 0.0;              // x1
            return y;

        case 2:
            y += (len_c > 0) ? c[0] : 0.0;                    // 1
            y += (len_c > 1) ? c[1] * x2 : 0.0;              // x2
            y += (len_c > 2) ? c[2] * x2_2 : 0.0;            // x2^2
            y += (len_c > 3) ? c[3] * x1 : 0.0;              // x1
            y += (len_c > 4) ? c[4] * x1 * x2 : 0.0;         // x1*x2
            y += (len_c > 5) ? c[5] * x1_2 : 0.0;            // x1^2
            return y;

        case 3:
            y += (len_c > 0) ? c[0] : 0.0;                    // 1
            y += (len_c > 1) ? c[1] * x2 : 0.0;              // x2
            y += (len_c > 2) ? c[2] * x2_2 : 0.0;            // x2^2
            y += (len_c > 3) ? c[3] * x2_3 : 0.0;            // x2^3
            y += (len_c > 4) ? c[4] * x1 : 0.0;              // x1
            y += (len_c > 5) ? c[5] * x1 * x2 : 0.0;         // x1*x2
            y += (len_c > 6) ? c[6] * x1 * x2_2 : 0.0;       // x1*x2^2
            y += (len_c > 7) ? c[7] * x1_2 : 0.0;            // x1^2
            y += (len_c > 8) ? c[8] * x1_2 * x2 : 0.0;       // x1^2*x2
            y += (len_c > 9) ? c[9] * x1_3 : 0.0;            // x1^3
            return y;

        case 4:
            y += (len_c > 0) ? c[0] : 0.0;                    // 1
            y += (len_c > 1) ? c[1] * x2 : 0.0;              // x2
            y += (len_c > 2) ? c[2] * x2_2 : 0.0;            // x2^2
            y += (len_c > 3) ? c[3] * x2_3 : 0.0;            // x2^3
            y += (len_c > 4) ? c[4] * x2_4 : 0.0;            // x2^4
            y += (len_c > 5) ? c[5] * x1 : 0.0;              // x1
            y += (len_c > 6) ? c[6] * x1 * x2 : 0.0;         // x1*x2
            y += (len_c > 7) ? c[7] * x1 * x2_2 : 0.0;       // x1*x2^2
            y += (len_c > 8) ? c[8] * x1 * x2_3 : 0.0;       // x1*x2^3
            y += (len_c > 9) ? c[9] * x1_2 : 0.0;            // x1^2
            y += (len_c > 10) ? c[10] * x1_2 * x2 : 0.0;     // x1^2*x2
            y += (len_c > 11) ? c[11] * x1_2 * x2_2 : 0.0;   // x1^2*x2^2
            y += (len_c > 12) ? c[12] * x1_3 : 0.0;          // x1^3
            y += (len_c > 13) ? c[13] * x1_3 * x2 : 0.0;     // x1^3*x2
            y += (len_c > 14) ? c[14] * x1_4 : 0.0;          // x1^4
            return y;

        case 5:
            y += (len_c > 0) ? c[0] : 0.0;                    // 1
            y += (len_c > 1) ? c[1] * x2 : 0.0;              // x2
            y += (len_c > 2) ? c[2] * x2_2 : 0.0;            // x2^2
            y += (len_c > 3) ? c[3] * x2_3 : 0.0;            // x2^3
            y += (len_c > 4) ? c[4] * x2_4 : 0.0;            // x2^4
            y += (len_c > 5) ? c[5] * x2_5 : 0.0;            // x2^5
            y += (len_c > 6) ? c[6] * x1 : 0.0;              // x1
            y += (len_c > 7) ? c[7] * x1 * x2 : 0.0;         // x1*x2
            y += (len_c > 8) ? c[8] * x1 * x2_2 : 0.0;       // x1*x2^2
            y += (len_c > 9) ? c[9] * x1 * x2_3 : 0.0;       // x1*x2^3
            y += (len_c > 10) ? c[10] * x1 * x2_4 : 0.0;     // x1*x2^4
            y += (len_c > 11) ? c[11] * x1_2 : 0.0;          // x1^2
            y += (len_c > 12) ? c[12] * x1_2 * x2 : 0.0;     // x1^2*x2
            y += (len_c > 13) ? c[13] * x1_2 * x2_2 : 0.0;   // x1^2*x2^2
            y += (len_c > 14) ? c[14] * x1_2 * x2_3 : 0.0;   // x1^2*x2^3
            y += (len_c > 15) ? c[15] * x1_3 : 0.0;          // x1^3
            y += (len_c > 16) ? c[16] * x1_3 * x2 : 0.0;     // x1^3*x2
            y += (len_c > 17) ? c[17] * x1_3 * x2_2 : 0.0;   // x1^3*x2^2
            y += (len_c > 18) ? c[18] * x1_4 : 0.0;          // x1^4
            y += (len_c > 19) ? c[19] * x1_4 * x2 : 0.0;     // x1^4*x2
            y += (len_c > 20) ? c[20] * x1_5 : 0.0;          // x1^5
            return y;
    }

    return y;
}

void lookup_approximation(double omega, double T, double *isd1, double *isq1, double *isd3, double *isq3)
{
    // Threshold polynomials & b_max values
    const double p01[5] = {1.6481e-25, -3.7616e-22, 2.705e-19, -5.732e-17, 7.5135};
    const double b01_max = 968.490183;
    const double p03[5] = {-9.2602884e-09, 3.7565759e-05, -0.057178353, 38.659717, -9780.5534};
    const double b03_max = 1116.647693;
    const double p12[5] = {2.9911e-25, -5.7199e-22, 3.5442e-19, -8.1573e-17, 8.2635};
    const double b12_max = 994.502570;
    const double p34[5] = {-1.7688052e-09, 7.8552048e-06, -0.013088527, 9.6908709, -2680.94};
    const double b34_max = 1163.017600;
    const double p36[5] = {-6.77624675e-09, 3.22701819e-05, -0.0576985001, 45.8574252, -13649.3882};
    const double b36_max = 1285.728209;
    const double p41[5] = {9.92485499e-08, -0.00038950984, 0.573266709, -374.966192, 91969.2029};
    const double b41_max = 994.502570;
    const double p45[5] = {-2.91265784e-08, 0.00012349691, -0.196363731, 138.759504, -36757.7416};
    const double b45_max = 1086.488403;
    const double p47[5] = {1.53949878e-08, -6.89747287e-05, 0.115855206, -86.4777807, 24214.122};
    const double b47_max = 1163.017600;
    const double p52[5] = {-7.431069541e-07, 0.00300459515, -4.555997921, 3070.65396, -776135.8564};
    const double b52_max = 1014.106109;
    const double p67[5] = {-1.240077e-10, 6.737391e-07, -0.001369386, 1.220811, -393.5305};
    const double b67_max = 1507.964474;

    // Coefficients for each condition
    int m_isd1_0 = 0;
    int n_isd1_0 = 3;
    static const double p_isd1_0_num[10] = {1.5591e-05, -0.16756, 9.8653e-06, -1.9164e-06, -5.1978e-07, -1.2571e-07, 1.6077e-08, 1.3362e-09, 2.5931e-12, -7.5673e-13};
    static const double p_isd1_0_den[1] = {1};
    int m_isd1_1 = 0;
    int n_isd1_1 = 3;
    static const double p_isd1_1_num[10] = {3.4493, -1.8473, 0.25182, -0.011917, -0.0033754, 0.00091581, -6.1542e-05, -3.2944e-07, 3.8857e-08, 5.3326e-12};
    static const double p_isd1_1_den[1] = {1};
    int m_isd1_2 = 2;
    int n_isd1_2 = 3;
    static const double p_isd1_2_num[10] = {-868378.4411, 310567.0489, -37160.61777, 1487.259234, 1408.359744, -831.4615974, 78.10433106, -0.0006569535499, 3.19062702e-05, -4.75203241e-10};
    static const double p_isd1_2_den[6] = {1, 842.69637, -98.632414, 3026.3055, -354.62181, 0.00028583765};
    int m_isd1_3 = 1;
    int n_isd1_3 = 3;
    static const double p_isd1_3_num[10] = {-1.0908, -0.045175, 0.060851, -0.0034926, -0.05267, 0.0019351, -2.0636e-05, 6.6e-05, -1.1367e-06, -1.6086e-08};
    static const double p_isd1_3_den[3] = {1, 0.037182, -0.0027557};
    int m_isd1_4 = 2;
    int n_isd1_4 = 3;
    static const double p_isd1_4_num[10] = {-19967865.8464, 1752741.45843, 41358.9486715, -4238.12446866, 46680.9142927, -4239.67895887, 63.7515038509, -30.2996069896, 1.62459389911, 0.00592285776073};
    static const double p_isd1_4_den[6] = {1, 11345.4917, -715.764859, -26.8414018, -2.89689136, 0.0080705318};
    int m_isd1_5 = 0;
    int n_isd1_5 = 3;
    static const double p_isd1_5_num[10] = {-963883.6406, -756.2198721, 3430.156243, 7.547673969, 2899.187059, -58.0246782, -3.615682483, -2.648509586, 0.06032512031, 0.0007088511217};
    static const double p_isd1_5_den[1] = {1};
    int m_isd1_6 = 2;
    int n_isd1_6 = 3;
    static const double p_isd1_6_num[10] = {554976568.9458, -16702455.00396, -188926.8411627, 4159.811222231, -1052050.86203, 21117.71127239, 171.7339514206, 626.5402012138, -6.279661460372, -0.1117930663801};
    static const double p_isd1_6_den[6] = {1, -64705.9358, 113.359849, 1085.51496, 39.8954325, -0.95235905};
    int m_isd1_7 = 2;
    int n_isd1_7 = 3;
    static const double p_isd1_7_num[10] = {-5790.4622, -36.756378, 26.403867, -0.53804565, -12.169179, 2.5456528, -0.084020699, 0.017577008, -0.0013505387, -4.979568e-06};
    static const double p_isd1_7_den[6] = {1, -17.398, 0.796588, 0.166818, 0.00235852, -9.69955e-05};
    int m_isq1_0 = 0;
    int n_isq1_0 = 3;
    static const double p_isq1_0_num[10] = {5.0981e-06, 4.089, -7.9241e-06, 5.9136e-07, -1.5463e-07, 3.1769e-09, 1.7549e-09, 2.6212e-10, -1.3761e-11, -1.1786e-13};
    static const double p_isq1_0_den[1] = {1};
    int m_isq1_1 = 0;
    int n_isq1_1 = 3;
    static const double p_isq1_1_num[10] = {19.029, -2.522, 0.768334, -0.0300019, -0.00582866, 0.00147963, -9.38403e-05, -1.56541e-08, 2.0947e-09, -3.29964e-13};
    static const double p_isq1_1_den[1] = {1};
    int m_isq1_2 = 1;
    int n_isq1_2 = 3;
    static const double p_isq1_2_num[10] = {-5.52129, -6.58558, 3.65365, -0.176706, -20.1616, 6.95423, -0.296679, 5.78386e-07, -6.90917e-08, 9.63515e-13};
    static const double p_isq1_2_den[3] = {1, 0.20141, 0.50553};
    int m_isq1_3 = 0;
    int n_isq1_3 = 3;
    static const double p_isq1_3_num[10] = {3.6226, 4.2655, -0.012258, 0.0001091, -0.0068117, -0.00021625, 7.4964e-06, 4.2496e-06, 4.6935e-08, -9.4393e-10};
    static const double p_isq1_3_den[1] = {1};
    int m_isq1_4 = 2;
    int n_isq1_4 = 3;
    static const double p_isq1_4_num[10] = {-164.63491, 4.0419086, -7866.4671, -292.82546, 312.66821, 587.64337, -17.76019, -0.47122086, -0.33897871, 0.00015911605};
    static const double p_isq1_4_den[6] = {1, -1808.4255, -79.874385, 147.37947, -4.3371959, -0.086984829};
    int m_isq1_5 = 0;
    int n_isq1_5 = 3;
    static const double p_isq1_5_num[10] = {-1954.4442, 1372.5376, 112.8773, -10.777316, -5.0771323, -4.6117828, 0.16100361, 0.023811535, 0.00092452432, -1.0239292e-05};
    static const double p_isq1_5_den[1] = {1};
    int m_isq1_6 = 1;
    int n_isq1_6 = 3;
    static const double p_isq1_6_num[10] = {-1927.2605, 69.387421, -5.4694975, 0.0020156239, 4.1079875, -0.031608677, 0.00029067245, -0.0028713296, 3.3189491e-05, 6.539276e-07};
    static const double p_isq1_6_den[3] = {1, -1.2295, 0.015244};
    int m_isq1_7 = 1;
    int n_isq1_7 = 3;
    static const double p_isq1_7_num[10] = {-1166698.4035, -0.61880524141, 6734.5048587, -189.74981962, 3694.3737551, -144.56589031, -0.73996610575, -3.1378182142, 0.084396576141, 0.00080506262313};
    static const double p_isq1_7_den[3] = {1, 36.5287, -0.311003};
    int m_isd3_0 = 0;
    int n_isd3_0 = 3;
    static const double p_isd3_0_num[10] = {4.5616e-06, -2.6808e-06, 9.7792e-07, -1.181e-07, -1.4598e-08, 1.9311e-09, 3.8184e-11, 9.7168e-12, -1.5177e-12, 2.5581e-15};
    static const double p_isd3_0_den[1] = {1};
    int m_isd3_1 = 0;
    int n_isd3_1 = 3;
    static const double p_isd3_1_num[10] = {3.8158, 0.0053382, -0.12018, 0.0069078, 8.651e-05, -2.5806e-05, 1.8846e-06, 2.4074e-08, -3.1804e-09, 7.8227e-13};
    static const double p_isd3_1_den[1] = {1};
    int m_isd3_2 = 1;
    int n_isd3_2 = 3;
    static const double p_isd3_2_num[10] = {-51.9883, -28.0825, 9.10166, -0.599852, 0.393906, -0.0955563, 0.00581007, -7.34997e-09, 8.30618e-10, 2.19301e-13};
    static const double p_isd3_2_den[3] = {1, 0.15089, -0.0022467};
    int m_isd3_3 = 2;
    int n_isd3_3 = 3;
    static const double p_isd3_3_num[10] = {4.68469, 26.9454, -1.75461, 0.0462904, 0.345649, -0.0644142, 0.00128832, -0.000392037, 3.39763e-05, 7.04858e-08};
    static const double p_isd3_3_den[6] = {1, 0.032714, -0.051362, -0.0052168, 0.00025543, -2.4375e-06};
    int m_isd3_4 = 2;
    int n_isd3_4 = 3;
    static const double p_isd3_4_num[10] = {103952453841.7034, -8005349582.974268, 464685.4862435203, 6506029.753432819, -242774496.0182129, 16214868.80827781, -181188.8520456168, 172037.2843591918, -6548.953019285909, -38.26584627395784};
    static const double p_isd3_4_den[6] = {1, -23488312.4303, 1510205.67437, 35157.6959081, 6913.94162013, -6.20784846636};
    int m_isd3_5 = 0;
    int n_isd3_5 = 3;
    static const double p_isd3_5_num[10] = {34978.8738, 34321.7108, 1690.52726, -221.696422, -385.715479, -96.3002645, 3.95183294, 0.779637034, 0.0141297338, -0.000293695121};
    static const double p_isd3_5_den[1] = {1};
    int m_isd3_6 = 1;
    int n_isd3_6 = 3;
    static const double p_isd3_6_num[10] = {-39782.4248, 1242.56697, 3.4853424, -0.183779488, 81.396864, -1.68193656, -0.004133353, -0.0549474072, 0.000558734357, 1.22967457e-05};
    static const double p_isd3_6_den[3] = {1, -0.65392, 0.026483};
    int m_isd3_7 = 2;
    int n_isd3_7 = 3;
    static const double p_isd3_7_num[10] = {307.709155, 821.276091, -11119.9922, 468.160854, 6433.89892, -420.622164, 12.7151824, -8.18519306, 0.274320873, 0.00258650348};
    static const double p_isd3_7_den[6] = {1, 14402.3345, -697.58156, -119.379519, -2.47563844, 0.0681633882};
    int m_isq3_0 = 0;
    int n_isq3_0 = 3;
    static const double p_isq3_0_num[10] = {0.001127, 0.099966, -0.00016857, 3.1577e-05, -2.0136e-06, 3.1773e-06, -2.6881e-07, -3.0227e-09, -1.05e-09, 2.8203e-12};
    static const double p_isq3_0_den[1] = {1};
    int m_isq3_1 = 0;
    int n_isq3_1 = 3;
    static const double p_isq3_1_num[10] = {-35.0798, 6.34702, -0.31098, 0.0134456, -9.96313e-07, 1.80059e-07, -6.89126e-09, 5.27505e-10, -6.53555e-11, -7.54166e-15};
    static const double p_isq3_1_den[1] = {1};
    int m_isq3_2 = 2;
    int n_isq3_2 = 3;
    static const double p_isq3_2_num[10] = {724360046.4804, -218771394.8553, 20639516.58649, -580224.5582224, -120410065.7427, 30603453.24649, -1932176.707245, -33.5714217759, 4.225265019035, 2.0618542199e-07};
    static const double p_isq3_2_den[6] = {1, -1514782.4552, 177448.74539, 4533241.2061, -530910.99246, 0.42749191356};
    int m_isq3_3 = 2;
    int n_isq3_3 = 3;
    static const double p_isq3_3_num[10] = {1.5803, -2.3803, -4.3635, 0.11992, -0.08047, -0.018286, 0.0040923, 0.00011705, 1.8988e-05, -4.1446e-08};
    static const double p_isq3_3_den[6] = {1, -1.067, 0.060469, 0.0048807, 0.0012777, -1.3423e-06};
    int m_isq3_4 = 2;
    int n_isq3_4 = 3;
    static const double p_isq3_4_num[10] = {4188344.332, -3059304.4343, 262517.71862, -6126.2737029, 13997.483223, 1648.306366, -109.77169554, -21.603762076, 0.15403151865, 0.0068257623581};
    static const double p_isq3_4_den[6] = {1, 56760.967, -3263.79016, -505.466016, 1.67492939, 0.2439765};
    int m_isq3_5 = 0;
    int n_isq3_5 = 3;
    static const double p_isq3_5_num[10] = {88597.8471, 12259.8471, 882.120658, -109.68003, -363.013478, -38.9649384, 1.90250753, 0.519324497, 0.00315055679, -0.000178521851};
    static const double p_isq3_5_den[1] = {1};
    int m_isq3_6 = 1;
    int n_isq3_6 = 3;
    static const double p_isq3_6_num[10] = {4.58275, 79.2057, -2.71186, 0.0200428, 0.0185883, -0.110286, 0.00201117, -2.15277e-05, 3.48302e-05, 1.7237e-09};
    static const double p_isq3_6_den[3] = {1, 0.12924, -0.0047237};
    int m_isq3_7 = 2;
    int n_isq3_7 = 3;
    static const double p_isq3_7_num[10] = {-9140467480.8957, 855450090.58315, -20281218.747346, 3.7724228946651, 18915655.636589, -1259517.0123259, 17836.052401148, -12880.338735039, 449.70305500875, 2.8911019898745};
    static const double p_isq3_7_den[6] = {1, 2612016.5536, -128433.56614, -30241.109125, -28.12711369, 17.260124909};

    // Now the full chain of conditions:
    if ((omega <= b01_max && T < polyval(p01, 4, omega)) ||
        (omega <= b03_max && omega > b01_max && T < polyval(p03, 4, omega)))
    {
        *isd1 = polyval2d(p_isd1_0_num, 10, omega, T, n_isd1_0) / polyval2d(p_isd1_0_den, 1, omega, T, m_isd1_0);
        *isq1 = polyval2d(p_isq1_0_num, 10, omega, T, n_isq1_0) / polyval2d(p_isq1_0_den, 1, omega, T, m_isq1_0);
        *isd3 = polyval2d(p_isd3_0_num, 10, omega, T, n_isd3_0) / polyval2d(p_isd3_0_den, 1, omega, T, m_isd3_0);
        *isq3 = polyval2d(p_isq3_0_num, 10, omega, T, n_isq3_0) / polyval2d(p_isq3_0_den, 1, omega, T, m_isq3_0);
    }
    else if ((omega <= b34_max && omega > b01_max && T < polyval(p34, 4, omega)) ||
             (omega <= b36_max && omega > b34_max && T < polyval(p36, 4, omega)))
    {
        *isd1 = polyval2d(p_isd1_3_num, 10, omega, T, n_isd1_3) / polyval2d(p_isd1_3_den, 3, omega, T, m_isd1_3);
        *isq1 = polyval2d(p_isq1_3_num, 10, omega, T, n_isq1_3) / polyval2d(p_isq1_3_den, 1, omega, T, m_isq1_3);
        *isd3 = polyval2d(p_isd3_3_num, 10, omega, T, n_isd3_3) / polyval2d(p_isd3_3_den, 6, omega, T, m_isd3_3);
        *isq3 = polyval2d(p_isq3_3_num, 10, omega, T, n_isq3_3) / polyval2d(p_isq3_3_den, 6, omega, T, m_isq3_3);
    }
    else if (omega <= b67_max && omega > b34_max && T < polyval(p67, 4, omega))
    {
        *isd1 = polyval2d(p_isd1_6_num, 10, omega, T, n_isd1_6) / polyval2d(p_isd1_6_den, 6, omega, T, m_isd1_6);
        *isq1 = polyval2d(p_isq1_6_num, 10, omega, T, n_isq1_6) / polyval2d(p_isq1_6_den, 3, omega, T, m_isq1_6);
        *isd3 = polyval2d(p_isd3_6_num, 10, omega, T, n_isd3_6) / polyval2d(p_isd3_6_den, 3, omega, T, m_isd3_6);
        *isq3 = polyval2d(p_isq3_6_num, 10, omega, T, n_isq3_6) / polyval2d(p_isq3_6_den, 3, omega, T, m_isq3_6);
    }
    else if (((omega <= b01_max && T >= polyval(p01, 4, omega)) ||
              (omega <= b41_max && omega > b01_max && T >= polyval(p41, 4, omega))) && T < polyval(p12, 4, omega))
    {
        *isd1 = polyval2d(p_isd1_1_num, 10, omega, T, n_isd1_1) / polyval2d(p_isd1_1_den, 1, omega, T, m_isd1_1);
        *isq1 = polyval2d(p_isq1_1_num, 10, omega, T, n_isq1_1) / polyval2d(p_isq1_1_den, 1, omega, T, m_isq1_1);
        *isd3 = polyval2d(p_isd3_1_num, 10, omega, T, n_isd3_1) / polyval2d(p_isd3_1_den, 1, omega, T, m_isd3_1);
        *isq3 = polyval2d(p_isq3_1_num, 10, omega, T, n_isq3_1) / polyval2d(p_isq3_1_den, 1, omega, T, m_isq3_1);
    }
    else if (((omega <= b12_max && T >= polyval(p12, 4, omega)) ||
              (omega <= b52_max && omega > b12_max && T >= polyval(p52, 4, omega))))
    {
        *isd1 = polyval2d(p_isd1_2_num, 10, omega, T, n_isd1_2) / polyval2d(p_isd1_2_den, 6, omega, T, m_isd1_2);
        *isq1 = polyval2d(p_isq1_2_num, 10, omega, T, n_isq1_2) / polyval2d(p_isq1_2_den, 3, omega, T, m_isq1_2);
        *isd3 = polyval2d(p_isd3_2_num, 10, omega, T, n_isd3_2) / polyval2d(p_isd3_2_den, 3, omega, T, m_isd3_2);
        *isq3 = polyval2d(p_isq3_2_num, 10, omega, T, n_isq3_2) / polyval2d(p_isq3_2_den, 6, omega, T, m_isq3_2);
    }
    else if (omega <= b45_max && omega > b12_max && T >= polyval(p45, 4, omega))
    {
        *isd1 = polyval2d(p_isd1_5_num, 10, omega, T, n_isd1_5) / polyval2d(p_isd1_5_den, 1, omega, T, m_isd1_5);
        *isq1 = polyval2d(p_isq1_5_num, 10, omega, T, n_isq1_5) / polyval2d(p_isq1_5_den, 1, omega, T, m_isq1_5);
        *isd3 = polyval2d(p_isd3_5_num, 10, omega, T, n_isd3_5) / polyval2d(p_isd3_5_den, 1, omega, T, m_isd3_5);
        *isq3 = polyval2d(p_isq3_5_num, 10, omega, T, n_isq3_5) / polyval2d(p_isq3_5_den, 1, omega, T, m_isq3_5);
    }
    else if (((omega <= b47_max && omega > b45_max && T >= polyval(p47, 4, omega)) ||
              (omega > b34_max)))
    {
        *isd1 = polyval2d(p_isd1_7_num, 10, omega, T, n_isd1_7) / polyval2d(p_isd1_7_den, 6, omega, T, m_isd1_7);
        *isq1 = polyval2d(p_isq1_7_num, 10, omega, T, n_isq1_7) / polyval2d(p_isq1_7_den, 3, omega, T, m_isq1_7);
        *isd3 = polyval2d(p_isd3_7_num, 10, omega, T, n_isd3_7) / polyval2d(p_isd3_7_den, 6, omega, T, m_isd3_7);
        *isq3 = polyval2d(p_isq3_7_num, 10, omega, T, n_isq3_7) / polyval2d(p_isq3_7_den, 6, omega, T, m_isq3_7);
    }
    else
    {
        *isd1 = polyval2d(p_isd1_4_num, 10, omega, T, n_isd1_4) / polyval2d(p_isd1_4_den, 6, omega, T, m_isd1_4);
        *isq1 = polyval2d(p_isq1_4_num, 10, omega, T, n_isq1_4) / polyval2d(p_isq1_4_den, 6, omega, T, m_isq1_4);
        *isd3 = polyval2d(p_isd3_4_num, 10, omega, T, n_isd3_4) / polyval2d(p_isd3_4_den, 6, omega, T, m_isd3_4);
        *isq3 = polyval2d(p_isq3_4_num, 10, omega, T, n_isq3_4) / polyval2d(p_isq3_4_den, 6, omega, T, m_isq3_4);
    }
}
