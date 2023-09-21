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
    fmt db '%s', 10,  0
    two dq 2.0

section .bss
    n resq 1
    x resq 1
    s resq 1

section .text
    global main
main:
    enter 0, 0

    ;citim numarul n 
    mov rdi, fmt
    mov rsi, msg_int
    mov rax, 0
    call printf

    mov rdi, fmt_si
    mov rsi, n
    mov rax, 0
    call scanf

    ;citim numarul x 
    mov rdi, fmt
    mov rsi, msg_int_x
    mov rax, 0
    call printf

    mov rdi, fmt_sf
    mov rax, 1
    call scanf
    movsd [x], xmm0

    ;calculam valoarea aproximativa
    movsd xmm0, [x]
    divsd xmm0, [two]
    mov ecx, [n]
st_loop:
    movsd xmm1, [x]
    divsd xmm1, xmm0
    addsd xmm1, xmm0
    divsd xmm1, [two]

    movsd xmm0, xmm1

    loop st_loop

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