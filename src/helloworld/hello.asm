%include 'functions.asm'
global _start

section .data
  msg db 'Hello World!', 10
  len equ $-msg

section .text
  _start: mov eax, 4
          mov ebx, 1
          mov ecx, msg
          mov edx, len 
          int 80h 
          call exit
