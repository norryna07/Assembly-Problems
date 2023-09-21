extern printf
extern scanf


section .data
    msg_int_x db 'Introduceti valoarea lui x : ', 0
    msg_int db 'Introduceti numarul de iteratii : ', 0
    msg_fin db 'Valoarea aproximativa a functiei sqrt(x) este : ', 0
    fmt_si db '%ld', 0
    fmt_pi db '%ld', 10, 0
    fmt_sf db '%lf', 0
    fmt_pf db '%lf', 10, 0 
    fmt db "%s", 10,  0
    one dq 1.0
    two dq 2.0

section .bss
    x resq 1
    n resq 1
    s resq 1

section .text
global main
main:
    enter 0, 0
    ;citim n
    mov rdi, fmt
    mov rsi, msg_int
    mov rax, 0
    call printf

    mov rdi, fmt_si
    mov rsi, n
    mov rax, 0
    call scanf

    ;citim x
    mov rdi, fmt
    mov rsi, msg_int_x
    mov rax, 0
    call printf

    mov rdi, fmt_sf
    mov rax, 1
    call scanf
    subsd xmm0, [one]
    movsd [x], xmm0


    ;calculam valoarea radicalului
    movsd xmm0, [one] ;valoarea aproximarii
    movsd xmm1, [one] ;valoarea termenului la ficare pas
    movsd xmm3, [one] ; k
    mov rcx, 1
    mov rax, [n]
    add rax, 1
    
st_loop:
    movsd xmm2, [one]
    divsd xmm2, [two]
    addsd xmm2, [one]
    subsd xmm2, xmm3

    mulsd xmm1, xmm2
    divsd xmm1, xmm3
    mulsd xmm1, [x]

    addsd xmm0, xmm1

    addsd xmm3, [one]
    inc rcx
    
    cmp rax, rcx
jne st_loop

    movsd [s], xmm0

    ;afisam rezultatul
    mov rdi, fmt
    mov rsi, msg_fin
    mov rax, 0
    call printf

    mov rdi, fmt_pf
    movsd xmm0, [s]
    mov rax, 1
    call printf

    mov rax, 60
    mov rdi, 0
    syscall

