section .data
    msg_int db 'Introduceti un text de cel mult 100 de caractere', 0xA
    len_int equ $-msg_int
    msg_fin db 'Sirul inversat este', 0xA
    len_fin equ $-msg_fin

section .bss
    sir resb 100
    aux resq 1

section .text
    global _start
_start:
    ;afisare mesaj initial
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_int
    mov edx, len_int
    int 0x80

    ;citire
    mov eax, sir
readloop:
    mov ecx, eax
    mov [aux], eax
    mov edx, 1
    mov eax, 3
    mov ebx, 2
    int 0x80

    mov eax, [aux]
    mov ebx, [eax]
    inc eax
    cmp ebx, 0xA
    jne readloop

    ;calcul numar caractere
    sub eax, 2
    mov [aux], eax
    sub eax, sir

    ;afisare mesaj final
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_fin
    mov edx, len_fin
    int 0x80

    ;afisare sir inversat
    mov eax, [aux]
printloop:
    mov [aux], eax

    mov eax, 4
    mov ebx, 1
    mov ecx, [aux]
    mov edx, 1
    int 0x80
    mov eax, [aux]
    dec eax
    cmp eax, sir
    jge printloop


    mov eax, 1
    mov ebx, 0
    int 0x80