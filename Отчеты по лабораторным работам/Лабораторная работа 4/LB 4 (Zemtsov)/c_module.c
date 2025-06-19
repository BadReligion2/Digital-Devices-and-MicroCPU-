#include <math.h>

// ��������� ������� _ ��� ������������� � �����������
double __cdecl _c_func(double x) {
    if (fabs(cos(x)) < 1e-9) {
        return NAN;
    }
    return tan(x) + sin(x);
}