.586                ; ��������� ��������� (Pentium)
.MODEL flat, C      ; ���������� ������� ������ ������ � ���������� ����� C
.DATA               ; ������ �������� ������

; ���������� ���������� ��� �������� �������� �������� x
current_x DD 0.0    ; �������� 4 ����� (float) � �������������� �����

.CODE               ; ������ �������� ����

; ��������� ������� ������� fun_el, ������� ����������� � C
extern fun_el:near

; ��������� ������� CalcFuncValues ��� ������������� (������� �� C)
public CalcFuncValues

; ������ ��������� CalcFuncValues � ������������ ����� C
CalcFuncValues proc C
    ; ������ ������� - ��������� ebp � ������������� ����� �������� �����
    push ebp
    mov ebp, esp
    
    ; ��������� ������� (�� ���������� cdecl):
    ; [ebp+8]  - n (���������� ��������)
    ; [ebp+12] - ��������� �� ������ ����������� y
    ; [ebp+16] - ��������� �������� x (start)
    ; [ebp+20] - ��� (step)
    
    ; ��������� ��������� � ��������
    mov ecx, [ebp+8]    ; ecx = n (������� �����)
    mov eax, [ebp+12]   ; eax = ��������� �� ������ y
    
    ; �������������� current_x ��������� ��������� start
    fld dword ptr [ebp+16]   ; ��������� start � ���� FPU
    fstp dword ptr [current_x] ; ��������� start � current_x
    
    ; ������ ����� ���������� �������� �������
@@for_i:
    ; ��������� ��������, ������� ����� �������������� � ������� fun_el
    push ecx            ; ��������� ������� �����
    push eax            ; ��������� ��������� �� ������ y
    
    ; �������������� �������� ��� ������� fun_el (������� �������� x)
    push dword ptr [current_x] ; �������� current_x � ����
    call fun_el         ; �������� ������� fun_el
    add esp, 4          ; ������� ���� �� ��������� (���������� cdecl)
    
    ; ��������������� ��������
    pop eax             ; ��������������� ��������� �� ������ y
    pop ecx             ; ��������������� ������� �����
    
    ; ��������� ��������� (������������ �������� � ST(0)) � ������ y
    mov edx, [ebp+8]    ; edx = n
    sub edx, ecx        ; edx = n - ecx (������� ������ 0-based)
    fstp dword ptr [eax + edx*4] ; ��������� ��������� � y[i]
    
    ; ����������� current_x �� ���
    fld dword ptr [current_x]   ; ��������� current_x � ���� FPU
    fadd dword ptr [ebp+20]     ; ���������� step
    fstp dword ptr [current_x]  ; ��������� ����� �������� ������� � current_x
    
    loop @@for_i        ; ��������� ����, ���� ecx != 0
    
    ; ������ ������� - ��������������� ��������� ����� � ebp
    mov esp, ebp
    pop ebp
    ret                 ; ������� �� �������
CalcFuncValues endp

End ; ����� ������