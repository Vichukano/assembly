global _start

section .data
    msg db 'Hello world!', 10
    len equ $-msg
    cnt equ 5

section .text
_start: xor rax, rax
        push rax

 again: mov rax, 4
        mov rbx, 1
        mov rcx, msg
        mov rdx, len
        int 80h
        pop rax
        inc rax
        push rax
        cmp rax, cnt 
        jl again 
        call exit

 exit:  mov rax, 1
        mov rbx, 0
        int 80h
        
