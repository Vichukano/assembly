compile: multyhello.asm
	nasm -f elf32 multyhello.asm
	ld -m elf_i386 multyhello.o -o multyhello

clear:
	rm multyhello.o multyhello