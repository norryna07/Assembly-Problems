section .data
    msg_int db 'Introduceti un numar', 0xa
    len_int equ $-msg_int
    msg_poz db 'Numarul este pozitiv', 0xa
    len_poz equ $-msg_poz
    msg_neg db 'Numarul este negativ', 0xa
    len_neg equ $-msg_neg
    
section .bss
    car resb 1
    
section .text
global _start
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_int
    mov edx, len_int
    int 0x80
    
    mov eax, 4
    mov ebx, 2
    mov ecx, car
    mov edx, 1
    int 0x80
    
    mov eax, [car]
    cmp eax, '-'
    jne poz
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_neg
    mov edx, len_neg
    int 0x80
    jmp exit
poz:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_poz
    mov edx, len_poz
    int 0x80
exit:
    mov eax, 1
    mov ebx, 0
    int 0x80