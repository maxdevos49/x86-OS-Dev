;=======================================================
; A Boot sector that prints a string using our function.
;=======================================================

[org 0x7c00]                ; Tell the assembler where this code will be loaded

mov bx, HELLO_MSG           ; Use bx as a parameter to our function
call print_string           ; Call function to print whats in bx

mov bx, GOODBYE_MSG         ; Use bx as a parameter of print_string
call print_string           ; call function to print

jmp $                       ; Hang

; Include our print function
%include "print_string.asm"    

; ====
; Data
; ====

HELLO_MSG:
    db 'Hello, World!', 0   ; <-- Zero tells our routine we are at the end of teh string

GOODBYE_MSG:
    db 'Goodbye!', 0

; ====================================
; Padding and magic number for booting
; ====================================

times 510-($-$$) db 0
dw 0xaa55