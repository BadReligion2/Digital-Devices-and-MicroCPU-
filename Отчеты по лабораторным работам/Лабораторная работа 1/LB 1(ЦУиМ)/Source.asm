.686 
.model flat,stdcall  
.stack 100h 

.data
X dw 87          ; Исходное значение X
Y dw 60          ; Исходное значение Y
Z dw -2          ; Исходное значение Z
M dw ?           ; Переменная для результата

.code

ExitProcess PROTO STDCALL :DWORD 

Start: 
    ; Циклический сдвиг X на 2 бита вправо и вычитание Y
    mov ax, X          ; Загружаем X в регистр AX
    ror ax, 2          ; Сдвигаем вправо на 2 бита
    sub ax, Y          ; Вычитаем Y

    ; Выполняем побитовую операцию AND между Z и Y, сдвинутым на 2 бита
    mov bx, Y          ; Загружаем Y в регистр BX
    ror bx, 2          ; Сдвигаем Y на 2 бита вправо
    and bx, Z          ; Выполняем AND с Z

    add ax, bx         ; Складываем результат
    mov M, ax          ; Сохраняем результат в M

exit: 
    Invoke ExitProcess, 0 
End Start