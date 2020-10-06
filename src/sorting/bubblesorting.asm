;simple digits sorting program
global _start
	
section .bss
input resb 32 ;store input array here

section .data
array_end equ 10 ;end of the line
acsi_const equ 48 ;constant to format acsiII symbol to digit
header_line dd '#################################################', 10
h_len equ $-header_line
info_line_one db 'Simple sorting program.', 10
inf_one_len equ $-info_line_one
info_line_two db 'Input max 32 digits without spaces. Example: 3215', 10
inf_two_len equ $-info_line_two
info_line_three db 'Expected output: 1235', 10
inf_three_len equ $-info_line_three
footer_line db '#################################################', 10
f_len equ $-footer_line
out_msg db 'Sorted: '
out_msg_len equ $-out_msg

;main
_start: call print_info
        call read
        call fmt_to_dgt
        mov edx, ecx ;the lenght of array
        call sorting
        call fmt_to_str
        call print_arr
        jmp exit

;print info
print_info: push dword ecx
            push dword edx
            mov ecx, header_line 
            mov edx, h_len 
            call print
            mov ecx, info_line_one
            mov edx, inf_one_len
            call print
            mov ecx, info_line_two
            mov edx, inf_two_len
            call print
            mov ecx, info_line_three
            mov edx, inf_three_len
            call print
            mov ecx, footer_line
            mov edx, f_len
            call print
            pop dword edx
            pop dword ecx

;ecx -> addr fo print, edx -> lenght of bytes for print
print: mov eax, 4
       mov ebx, 1
       int 80h
       ret

read: mov eax, 3
      mov ebx, 0
      mov ecx, input
      mov edx, 32 
      int 80h
      ret
      
;format acsiII symbols to digits
fmt_to_dgt: mov eax, 48
            mov esi, input
            xor ecx, ecx
.loop:      sub [esi + ecx], eax
            inc ecx ;size of array
            cmp [esi + ecx], byte 48 ;if not a digit end of the loop
            jge .loop
            ret
            
;sorting array of digits
sorting: xor ecx, ecx
         jmp inner_loop
        
inner_loop: mov al, [input + ecx] 
            mov ah, [input + 1 + ecx]
            cmp al, ah 
            jle next
            mov [input + ecx], ah 
            mov [input + 1 + ecx], al 
            jmp next

next: inc ecx
      cmp ecx, edx
      jl inner_loop
      je end_loop

end_loop: dec edx
          jnz sorting
          ret
        
;format digits to acsiII symbols
;ecx contains length of array
fmt_to_str: mov eax, 48
            mov esi, input
            xor ecx, ecx
.loop:      add [esi + ecx], eax
            inc ecx ;size of array
            cmp [esi + ecx], byte 0 ;end of the line
            jne .loop
            ret
            
;print result of sorting to stdout
;ecx contains length of array
print_arr: push dword array_end
           pop dword [input + ecx - 1] 
           mov eax, 4
           mov ebx, 1
           mov ecx, out_msg 
           mov edx, out_msg_len
           int 80h
           mov eax, 4
           mov ebx, 1
           mov ecx, input
           mov edx, 32
           int 80h
           ret

exit: mov eax, 1
      mov ebx, 0
      int 80h