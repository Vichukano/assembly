	global _start
	
	section .data
	msg db 'Hello world!', 10
	len equ $ - msg
	cnt equ 5
	
	section .text
_start: xor eax, eax
        push dword eax
	
again: mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, len
	int 80h
	pop dword eax
	inc eax
	push dword eax
	cmp eax, cnt
	jl again
	jmp exit
	
exit:  mov eax, 1
	mov ebx, 0
	int 80h
