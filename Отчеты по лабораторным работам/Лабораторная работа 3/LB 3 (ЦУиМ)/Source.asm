.686
.model flat, stdcall
.stack 100h

.data
array db 16, 10, 13, 25, 13, 31, 29, 13, 42, 56, 13, 15, 13, 5, 2, 1  ; 16 ���������
count dd 16                        ; ���������� ��������� � ������� (������ dd ��� �������������)
target_value db 13                 ; ������� �������� (13)
sum dd 0.0                         ; ���������� ��� ���������� ����� (������������)

.code
ExitProcess PROTO STDCALL :DWORD 

Start:
    mov ecx, [count]               ; ��������� ���������� ��������� � ECX
    xor esi, esi                   ; �������� ��������� ������� ESI
    
    fldz                           ; ��������� 0.0 � ST(0) (�������������� �����)

sum_loop:
    mov al, [array + esi]          ; ��������� ������� ������� ������� � AL
    cmp al, target_value           ; ���������� ������� � 13
    jne next_element               ; ���� �� ����� 13, ��������� � ���������� ��������
    
    ; ����������� � ��������� ������� � �����
    movzx eax, al                  ; ��������� ���� �� �������� ����� ��� �����
    push eax                       ; �������� �������� � ����
    fild dword ptr [esp]           ; ��������� ����� ����� �� ����� � ST(0)
    add esp, 4                     ; ��������������� ��������� �����
    faddp st(1), st(0)             ; ��������� � ����� � ST(1) � ��������� �� ����� FPU

next_element:
    inc esi                        ; ����������� ������
    loop sum_loop                  ; ��������� ECX � ���������, ���� �� ����

    fstp [sum]                     ; ��������� ��������� �� ST(0) � sum � ��������� �� ����� FPU

exit:
    Invoke ExitProcess, 0
End Start