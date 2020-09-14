DISK = /dev/disk2s1

.PHONY: clean all install

all: assemble

assemble: 
	nasm boot.asm -f bin -o boot.bin

run: all
	qemu-system-x86_64 boot.bin

install: all
	diskutil unmount $(DISK)
	sudo dd if=./kernel/boot.bin of=$(DISK)

clean: 
	rm -rf boot.bin