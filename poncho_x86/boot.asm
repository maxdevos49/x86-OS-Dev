
; Program offset
[org 0x7c00]      ; Offsets our compiled memory addresses

; Store boot drive number
mov [BOOT_DRIVE], dl

; init stack
mov bp, 0x7bff ; If kernel gets too big then this gets clobbered and it wont likely make it to the extended program
mov sp, bp


call read_disk

; Print a test string
mov bx, EXTENDED_STRING
call print_string


jmp PROGRAM_SPACE ; Go to the extended program

; Include files
%include "./print.asm"
%include "./disk.asm"

EXTENDED_STRING: db "Jumping to extended program",0xA, 0xD,0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55