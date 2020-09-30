compile: readstring.asm
	nasm -f elf32 readstring.asm
	ld -m elf_i386 readstring.o -o readstring

clear:
	rm readstring.o readstring