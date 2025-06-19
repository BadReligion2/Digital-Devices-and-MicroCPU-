#include <iostream>
#include <cmath>
using namespace std;

// Объявляем внешние функции, которые будут реализованы в ассемблере и C
extern "C" {
    void CalcFuncValues(int n, float* y, float start, float step);
    float fun_el(float x);
}

int main(int argc, char** argv) {
    // Параметры для вычисления функции
    const float start = 0.0f;    // Начало интервала (0.0)
    const float step = 0.1f;      // Шаг вычисления (0.1)
    const int n = 11;             // Количество точек (0.0, 0.1, ..., 1.0)

    // Выделяем память для массива результатов
    float* y = new float[n];

    // Вызываем ассемблерную функцию для вычисления значений
    CalcFuncValues(n, y, start, step);

    // Выводим результаты вычислений
    cout << "Function values on interval [0, 1] with step 0.1:" << endl;
    for (int i = 0; i < n; i++) {
        float x = start + i * step;
        cout << "f(" << x << ") = " << y[i] << endl;
    }

    // Освобождаем выделенную память
    delete[] y;
    return 0;
}

// Функция для вычисления значения элемента по варианту 9: f(x) = (tg(x) + sin(x)) / e^x
extern "C" float fun_el(float x) {
    float tg = tanf(x);       // Вычисляем тангенс x
    float sin_x = sinf(x);    // Вычисляем синус x
    float exp_x = expf(x);    // Вычисляем e^x
    return (tg + sin_x) / exp_x; // Возвращаем результат по формуле варианта 9
}