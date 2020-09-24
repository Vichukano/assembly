global _start

section .bss
  buff resb 100

section .data
  size   equ 32
  msg    db  'Hello, '
  msglen equ $-msg

section .text 
  _start:
          push qword [msg]
          pop qword [buff]
          mov eax, 3
          mov ebx, 0
          mov ecx, buff + msglen
          mov edx, size
          int 80h
          mov eax, 4
          mov ebx, 1
          mov ecx, buff
          mov edx, size
          int 80h
          call exit

  exit:   mov eax, 1
          mov ebx, 0
          int 80h
