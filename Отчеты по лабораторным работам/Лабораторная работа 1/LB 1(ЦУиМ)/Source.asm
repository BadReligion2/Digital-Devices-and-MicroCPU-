.686 
.model flat,stdcall  
.stack 100h 

.data
X dw 87          ; �������� �������� X
Y dw 60          ; �������� �������� Y
Z dw -2          ; �������� �������� Z
M dw ?           ; ���������� ��� ����������

.code

ExitProcess PROTO STDCALL :DWORD 

Start: 
    ; ����������� ����� X �� 2 ���� ������ � ��������� Y
    mov ax, X          ; ��������� X � ������� AX
    ror ax, 2          ; �������� ������ �� 2 ����
    sub ax, Y          ; �������� Y

    ; ��������� ��������� �������� AND ����� Z � Y, ��������� �� 2 ����
    mov bx, Y          ; ��������� Y � ������� BX
    ror bx, 2          ; �������� Y �� 2 ���� ������
    and bx, Z          ; ��������� AND � Z

    add ax, bx         ; ���������� ���������
    mov M, ax          ; ��������� ��������� � M

exit: 
    Invoke ExitProcess, 0 
End Start