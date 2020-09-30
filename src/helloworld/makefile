compile: hello.asm
	nasm -f elf32 hello.asm
	ld -m elf_i386 hello.o -o hello

clear:
	rm hello.o hello
