#include <iostream>
#include <cmath>
using namespace std;

// ��������� ������� �������, ������� ����� ����������� � ���������� � C
extern "C" {
    void CalcFuncValues(int n, float* y, float start, float step);
    float fun_el(float x);
}

int main(int argc, char** argv) {
    // ��������� ��� ���������� �������
    const float start = 0.0f;    // ������ ��������� (0.0)
    const float step = 0.1f;      // ��� ���������� (0.1)
    const int n = 11;             // ���������� ����� (0.0, 0.1, ..., 1.0)

    // �������� ������ ��� ������� �����������
    float* y = new float[n];

    // �������� ������������ ������� ��� ���������� ��������
    CalcFuncValues(n, y, start, step);

    // ������� ���������� ����������
    cout << "Function values on interval [0, 1] with step 0.1:" << endl;
    for (int i = 0; i < n; i++) {
        float x = start + i * step;
        cout << "f(" << x << ") = " << y[i] << endl;
    }

    // ����������� ���������� ������
    delete[] y;
    return 0;
}

// ������� ��� ���������� �������� �������� �� �������� 9: f(x) = (tg(x) + sin(x)) / e^x
extern "C" float fun_el(float x) {
    float tg = tanf(x);       // ��������� ������� x
    float sin_x = sinf(x);    // ��������� ����� x
    float exp_x = expf(x);    // ��������� e^x
    return (tg + sin_x) / exp_x; // ���������� ��������� �� ������� �������� 9
}