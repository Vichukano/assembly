global _start

section .bss
  buff resb 100

section .data
  size   equ 32
  msg    db  'Hello, '
  msglen equ $-msg

section .text 
  _start  push dword [msg+4] ; add string to buff
          push dword [msg]
          pop dword [buff]
          pop dword [buff+4]
          ;push params for read function
          push dword size
          push dword buff+msglen ;addres after msg string
          call read
          ;push params for write function
          push dword size 
          push dword buff
          call write
          jmp exit

  read:   push dword ebp
          mov ebp, esp
          mov eax, 3
          mov ebx, 0
          mov ecx, [ebp+8]
          mov edx, [ebp+12]
          int 80h
          pop dword ebp
          ret

  write:  push dword ebp 
          mov ebp, esp
          mov eax, 4
          mov ebx, 1
          mov ecx, [ebp+8]
          mov edx, [ebp+12]
          int 80h
          pop dword ebp
          ret
          
  exit:   mov eax, 1
          mov ebx, 0
          int 80h
