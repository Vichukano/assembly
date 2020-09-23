section .text
exit:  xor eax, eax
       inc eax
       xor ebx, ebx
       int 80h
