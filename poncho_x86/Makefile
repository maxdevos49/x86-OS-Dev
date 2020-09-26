.PHONY: clean all debug

CC = x86_64-elf-gcc
CXX = x86_64-elf-g++
LD = x86_64-elf-ld
ECHO = echo
RM = rm
QEMU = qemu-system-x86_64
NASM = nasm
GDB = gdb

CFLAGS = -Wall -Ttext 0x8000 -ffreestanding -mno-red-zone -m64

BIN = kernel.flp
BINS = boot.bin
OBJS = extended_program.o binaries.o kernel.o io.o IDT.o text_print.o

all: $(BIN)

# Assembles, Compiles, and links executable
$(BIN): $(BINS) $(OBJS)
	@$(ECHO) Linking $@
	@$(LD) -T"linker.ld" -o kernel.bin $(OBJS)
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

# Run the executable in qemu
run: $(BIN)
	@$(ECHO) Running kernel in normal mode.
	@$(QEMU) -fda kernel.flp

# Run the executable in qemu with gdb attached
 # TODO work out gdb stuff
debug: $(BIN)
	@$(ECHO) Running kernel in debug mode.
	@$(QEMU) -s -S -fda kernel.flp


# Cleans the directory of any generated files
clean: 
	@$(ECHO) Removing all generated files
	@$(RM) -f *.o *.bin *.out *.flp *.log $(BIN) 