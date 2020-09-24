; A boot sector that boots a C kernel in 32-bit protected mode
[org 0x7c00]
KERNEL_OFFSET equ 0x1000    ; This is the memory offset to which we will load our kernel

mov [BOOT_DRIVE], dl        ; BIOS stores our boot drive in dl, so its
                            ; best to remember this for later
                
mov bp, 0x9000
mov sp, bp

mov bx, MSG_REAL_MODE   ; Announce that we are starting
call print_string       ; booting from 16-bit real mode

call load_kernel        ; Load our kernel

call switch_to_pm       ; Switch to protected mode, from which
                        ; we will not return

jmp $ 

; Include our useful, hard-earned routines
%include "print/print_string.asm"
%include "disk/disk_load.asm"
%include "pm/gdt.asm"
%include "pm/print_string_pm.asm"
%include "pm/switch_to_pm.asm"

[bits 16]

; load kernel
load_kernel:
    mov bx, MSG_LOAD_KERNEL ; Print a message to saw we are loading the kernel
    call print_string

    mov bx, KERNEL_OFFSET   ; Set-up parameters for out disk_load routine, so
    mov dh, 15              ; that we load the first 15 sectors (execluding
    mov dl, [BOOT_DRIVE]    ; the boot sector) from the boot disk (i.e. our 
    call disk_load          ; kernel code) to address KERNEL_OFFSET

    ret

[bits 32]
; This is where we arrive after switching to and initializing protected mode.
BEGIN_PM:

    mov ebx, MSG_PROT_MODE  ; Use our 32-bit print routine to announce we are 
    call print_string_pm    ; in protected mode

    call KERNEL_OFFSET      ; Now jump to the address of our loaded
                            ; kernel code, assume the brace position,
                            ; and cross your fingers. Here we go!

    jmp $                   ; Hang. Normaly we would not get here

; Gloabl variables
BOOT_DRIVE:         db 0
MSG_REAL_MODE:      db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE:      db "Successfully landed in 32-bit Protected Mode", 0
MSG_LOAD_KERNEL:    db "Loading kernel into memory.", 0

; Bootsector paddding
times 510-($-$$) db 0
dw 0xaa55