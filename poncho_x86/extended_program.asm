[bits 16]

mov bx, EXTENDED_SPACE_SUCCESS
call print_string

jmp enter_protected_mode

%include "./print.asm"
%include "./gdt.asm"

enter_protected_mode:
    call enable_A20
    cli                            ; We must switch off interrupts until we have set-up the protected mode
                                    ; interrupt vector otherwise interrupts will run riot.

    lgdt [gdt_descriptor]          ; Load out global descriptor table, which defines the
                                    ; protected mode segments (e.g. for code and data)
    mov eax, cr0                   ; To make the switch to protected mode, we set
    or eax, 0x1                    ; the first bit of CRO, a control register
    mov cr0, eax

    jmp CODE_SEG:init_32_bit       ; Make a far jump(i.e. to a new segment) to out 32-bit
                                    ; code. This also forces the CPU to flush its cache of
                                    ; pre-fetched and real-mode decoded instructions, which
                                    ; can cause problems
enable_A20:
    in al, 0x92
    or al, 2
    out 0x92, al
    ret

; Global Variables
EXTENDED_SPACE_SUCCESS: db "We are successfully in extended space",0xA, 0xD, 0,

[bits 32]

%include "./cpu_id.asm"
%include "./simple_paging.asm"

init_32_bit:
    mov ax, DATA_SEG               ; Now in PM our old segments are meaningless,
    mov ds, ax                     ; so we point our segment registers to the
    mov ss, ax                     ; data sector we defined in our GDT
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000               ; Update our stack position so it is right at the top of free space
    mov esp, ebp

    call detect_cpu_id
    call detect_long_mode
    call setup_identity_paging
    call edit_gdt

    jmp CODE_SEG:init_64_bit

[bits 64]
[extern _start]

%include "./IDT.asm"

init_64_bit:
     
    call _start

    jmp $

times 2048-($-$$) db 0