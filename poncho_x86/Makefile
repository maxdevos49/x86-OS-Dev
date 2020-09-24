.PHONY: clean all

CC = x86_64-elf-gcc
LD = x86_64-elf-ld
ECHO = echo
RM = rm -f
QEMU = qemu-system-x86_64
NASM = nasm

CFLAGS = -Ttext 0x8000 -ffreestanding -mno-red-zone -m64

BIN = kernel.flp
BINS = boot.bin
OBJS = extended_program.o kernel.o

all: $(BIN)

# Assembles, Compiles, and links executable
$(BIN): $(BINS) $(OBJS)
	@$(ECHO) Linking $@
	@$(LD) -T"linker.ld" -o kernel.bin
	@cat boot.bin kernel.bin > $(BIN)

# Compiles a c file into a object file
%.o: %.c	
	@$(ECHO) Compiling $<
	@$(CC) $(CFLAGS) -c $<

# Assembles a asm file into a object file
%.o: %.asm
	@$(ECHO) Assembling $<
	@$(NASM) -f elf64 $< -o $@

# Assembles a asm file into a binary file
%.bin: %.asm
	@$(ECHO) Assembling $<
	@$(NASM) -f bin $< -o $@



run: $(BIN)
	@$(ECHO) Running kernel in normal mode.
	@$(QEMU) -fda kernel.flp

# Cleans the directory of any generated files
clean: 
	@$(ECHO) Removing all generated files
	@$(RM) *.o *.bin *.out *.flp $(BIN) 