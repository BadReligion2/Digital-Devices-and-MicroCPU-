#include <math.h>

// Добавляем префикс _ для совместимости с ассемблером
double __cdecl _c_func(double x) {
    if (fabs(cos(x)) < 1e-9) {
        return NAN;
    }
    return tan(x) + sin(x);
}