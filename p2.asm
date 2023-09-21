extern printf

section .data
    msg db "Una dintre radacini este %f", 0ah
    a dq 0.0 
    b dq 4.0
    e dq 0.001
    d dq 2.0
    i dq 5.0
    j dq 6.0
    f dq 0.0
section .bss
    mij resq 1
section .text
    global main

main:
    enter 0, 0
    movsd xmm0, [a]      
    movsd xmm1, [b]

    bis_loop:
        movsd xmm2, xmm0           
        addsd xmm2, xmm1          
        divsd xmm2, [d]      
        movsd  [mij], xmm2 
        
        movsd xmm3, xmm2           
        movsd xmm4, xmm2
        
        mulsd xmm3, xmm3 ; am ridicat mij la patrat
        mulsd xmm4, [i]
        addsd xmm3, xmm4
        subsd xmm3, [j] ; f(mij)
        
        movsd xmm5, xmm0
        movsd xmm6, xmm0 ; f(a)
        
        mulsd xmm5, xmm5
        mulsd xmm6, [i]
        addsd xmm5, xmm6
        subsd xmm5, [j]
        
        ucomisd xmm3, [f]
        je final
        
        movsd xmm7, xmm3
        mulsd xmm7, xmm5
        ucomisd xmm5, [f]
        
        jbe prima_ramura
        movsd xmm0, [mij]
        jmp continue_loop
        
    prima_ramura:
        movsd xmm1, [mij]
        
    continue_loop:
        movsd xmm8, xmm1
        subsd xmm8, xmm0
        ucomisd xmm8, [e]
        ja bis_loop
    
    final:
         mov rdi, msg        
         mov rax, 1                  
         movsd xmm0, [mij]           
         call printf                 
        
    mov rax, 60        
    mov rdi, 0      
    syscall