[org 0x7c00]   ; Tell the assembler where this code will be loaded

mov dx, 0x1fb6 ; Use dx as a parameter to our function
call print_hex ; Call function to print whats in bx

jmp $

; Include our print function
%include "print_string.asm"

; Padding and magic number for booting
times 510-($-$$) db 0
dw 0xaa55