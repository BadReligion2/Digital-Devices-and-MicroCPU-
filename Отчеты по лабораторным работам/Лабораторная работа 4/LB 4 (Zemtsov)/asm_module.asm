.586                ; Указываем процессор (Pentium)
.MODEL flat, C      ; Используем плоскую модель памяти и соглашения языка C
.DATA               ; Начало сегмента данных

; Глобальная переменная для хранения текущего значения x
current_x DD 0.0    ; Выделяем 4 байта (float) и инициализируем нулем

.CODE               ; Начало сегмента кода

; Объявляем внешнюю функцию fun_el, которая реализована в C
extern fun_el:near

; Объявляем функцию CalcFuncValues как общедоступную (видимую из C)
public CalcFuncValues

; Начало процедуры CalcFuncValues с соглашениями языка C
CalcFuncValues proc C
    ; Пролог функции - сохраняем ebp и устанавливаем новый стековый фрейм
    push ebp
    mov ebp, esp
    
    ; Аргументы функции (по соглашению cdecl):
    ; [ebp+8]  - n (количество значений)
    ; [ebp+12] - указатель на массив результатов y
    ; [ebp+16] - начальное значение x (start)
    ; [ebp+20] - шаг (step)
    
    ; Загружаем параметры в регистры
    mov ecx, [ebp+8]    ; ecx = n (счетчик цикла)
    mov eax, [ebp+12]   ; eax = указатель на массив y
    
    ; Инициализируем current_x начальным значением start
    fld dword ptr [ebp+16]   ; Загружаем start в стек FPU
    fstp dword ptr [current_x] ; Сохраняем start в current_x
    
    ; Начало цикла вычисления значений функции
@@for_i:
    ; Сохраняем регистры, которые будут использоваться в функции fun_el
    push ecx            ; сохраняем счетчик цикла
    push eax            ; сохраняем указатель на массив y
    
    ; Подготавливаем аргумент для функции fun_el (текущее значение x)
    push dword ptr [current_x] ; Помещаем current_x в стек
    call fun_el         ; Вызываем функцию fun_el
    add esp, 4          ; Очищаем стек от аргумента (соглашение cdecl)
    
    ; Восстанавливаем регистры
    pop eax             ; восстанавливаем указатель на массив y
    pop ecx             ; восстанавливаем счетчик цикла
    
    ; Сохраняем результат (возвращаемое значение в ST(0)) в массив y
    mov edx, [ebp+8]    ; edx = n
    sub edx, ecx        ; edx = n - ecx (текущий индекс 0-based)
    fstp dword ptr [eax + edx*4] ; Сохраняем результат в y[i]
    
    ; Увеличиваем current_x на шаг
    fld dword ptr [current_x]   ; Загружаем current_x в стек FPU
    fadd dword ptr [ebp+20]     ; Прибавляем step
    fstp dword ptr [current_x]  ; Сохраняем новое значение обратно в current_x
    
    loop @@for_i        ; Повторяем цикл, пока ecx != 0
    
    ; Эпилог функции - восстанавливаем указатель стека и ebp
    mov esp, ebp
    pop ebp
    ret                 ; Возврат из функции
CalcFuncValues endp

End ; Конец модуля