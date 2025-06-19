.686
.model flat, stdcall
.stack 100h

.data
array db 16, 10, 13, 25, 13, 31, 29, 13, 42, 56, 13, 15, 13, 5, 2, 1  ; 16 элементов
count dd 16                        ; Количество элементов в массиве (теперь dd для совместимости)
target_value db 13                 ; Целевое значение (13)
sum dd 0.0                         ; Переменная для результата суммы (вещественное)

.code
ExitProcess PROTO STDCALL :DWORD 

Start:
    mov ecx, [count]               ; Загружаем количество элементов в ECX
    xor esi, esi                   ; Обнуляем индексный регистр ESI
    
    fldz                           ; Загружаем 0.0 в ST(0) (инициализируем сумму)

sum_loop:
    mov al, [array + esi]          ; Загружаем текущий элемент массива в AL
    cmp al, target_value           ; Сравниваем элемент с 13
    jne next_element               ; Если не равно 13, переходим к следующему элементу
    
    ; Преобразуем и добавляем элемент к сумме
    movzx eax, al                  ; Расширяем байт до двойного слова без знака
    push eax                       ; Помещаем значение в стек
    fild dword ptr [esp]           ; Загружаем целое число из стека в ST(0)
    add esp, 4                     ; Восстанавливаем указатель стека
    faddp st(1), st(0)             ; Добавляем к сумме в ST(1) и извлекаем из стека FPU

next_element:
    inc esi                        ; Увеличиваем индекс
    loop sum_loop                  ; Уменьшаем ECX и повторяем, если не ноль

    fstp [sum]                     ; Сохраняем результат из ST(0) в sum и извлекаем из стека FPU

exit:
    Invoke ExitProcess, 0
End Start