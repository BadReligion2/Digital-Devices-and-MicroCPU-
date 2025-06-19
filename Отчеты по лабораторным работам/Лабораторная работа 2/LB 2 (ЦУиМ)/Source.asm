.686
.model flat, stdcall
.stack 100h
.data
    X dw 99C5h
    Y dw 2A6Ch
    Z dw 80CFh
    M dw 0
    R dw 0
.code
ExitProcess PROTO STDCALL :DWORD
Start:
    ; ����� �������� ������������
    call MainProcedure
    Invoke ExitProcess, 0
    ; �������� ������������
MainProcedure:
    ; ����� ������ � X
    mov ax, X
    xchg ah, al
    mov X, ax

    ; ����� ������ � Y
    mov ax, Y
    xchg ah, al
    mov Y, ax

    ; ����� ������ � Z
    mov ax, Z
    xchg ah, al
    mov Z, ax

    ; ���������� M = X' + Y' + Z'
    mov ax, X
    add ax, Y
    add ax, Z
    mov M, ax

    ; �������� ������� M >= 012Bh
    cmp ax, 012Bh
    jge M_GreaterOrEqual
    jl M_Less

M_GreaterOrEqual:
    ; R = -M
    neg ax
    mov R, ax
    jmp Check_R_Sign

M_Less:
    ; R = M + 388Ah
    add ax, 388Ah
    mov R, ax

Check_R_Sign:
    ; �������� ����� R
    mov ax, R
    test ax, ax
    js R_Negative
    jns R_Positive

R_Positive:
    ; ������� � ���1 (R or 0FF0h)
    or ax, 0FF0h
    mov R, ax
    jmp Exit_Program

R_Negative:
    ; ������� � ���2 (-R xor 5555h)
    neg ax
    xor ax, 5555h
    mov R, ax

Exit_Program:
    ret

End Start