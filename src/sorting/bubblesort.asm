;https://forum.nasm.us/index.php?topic=2358.0
;example of sorting upper
global _start

section .data
input db 7, 2, 6, 5, 1, 4 ;array of digits for sorting
data_len equ $-input

section .text
_start: mov edx, 5

outer_loop: xor ecx, ecx
            jmp inner_loop
        
inner_loop: mov eax, [input + ecx] 
            mov ebx, [input + 1 + ecx]
            cmp eax, ebx
            jge next
            mov [input + 1 + ecx], eax
            mov [input + ecx], ebx

next: inc ecx
      cmp ecx, edx
      jl inner_loop
      je endiner

endiner: dec edx
         jnz outer_loop
         call print
         call exit

print: mov eax, 4
       mov ebx, 1
       mov ecx, input
       mov edx, data_len
       int 80h
       ret

exit: mov eax, 1
      mov ebx, 0
      int 80h