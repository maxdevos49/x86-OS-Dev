CC = x86_64-elf-gcc
CXX = x86_64-elf-g++
LD = x86_64-elf-ld
ECHO = echo
RM = rm
QEMU = qemu-system-x86_64
NASM = nasm
GDB = gdb
MKDIR = mkdir

CFLAGS = -O1 -Wall -Ttext 0x8000 -ffreestanding -mno-red-zone -m64

BIN = kernel.flp
BINS = $(addprefix $(BINDIR)/, boot.bin)
OBJS = $(addprefix $(OBJDIR)/, extended_program.o binaries.o kernel.o io.o IDT.o text_print.o keyboard.o memory_map.o heap.o random.o)
OBJDIR = obj
BINDIR = bin
DISTDIR = dist

all: $(BIN)

# Assembles, Compiles, and links executable
$(BIN): $(BINDIR) $(OBJDIR) $(DISTDIR) $(BINS) $(OBJS)
	@$(ECHO) Linking $@
	@$(LD) -T"linker.ld" -o $(BINDIR)/kernel.bin $(OBJS)
	@cat $(BINDIR)/boot.bin $(BINDIR)/kernel.bin > $(DISTDIR)/$(BIN)

# Compiles a c file into a object file
$(OBJDIR)/%.o: %.c	
	@$(ECHO) Compiling $<
	@$(CC) $(CFLAGS) -c $< -o $@

# Assembles a asm file into a object file
$(OBJDIR)/%.o: %.asm
	@$(ECHO) Assembling $<
	@$(NASM) -f elf64 $< -o $@

# Assembles a asm file into a binary file
$(BINDIR)/%.bin: %.asm
	@$(ECHO) Assembling $<
	@$(NASM) -f bin $< -o $@

$(OBJDIR):
	@$(ECHO) Creating $@ directory
	@$(MKDIR) $(OBJDIR)

$(BINDIR):
	@$(ECHO) Creating $@ directory
	@$(MKDIR) $(BINDIR)

$(DISTDIR):
	@$(ECHO) Creating $@ directory
	@$(MKDIR) $(DISTDIR)

# Run the executable in qemu
run: $(BIN)
	@$(ECHO) Running kernel in qemu.
	@$(QEMU) -fda kernel.flp

.PHONY: clean
clean: 
	@$(ECHO) Removing all generated files
	@$(RM) -rf $(DISTDIR) $(OBJDIR) $(BINDIR)