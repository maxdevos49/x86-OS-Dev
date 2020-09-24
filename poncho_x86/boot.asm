
; Program offset
[org 0x7c00]      ; Offsets our compiled memory addresses

; Store boot drive number
mov [BOOT_DRIVE], dl

; init stack
mov bp, 0x9000
mov sp, bp

; Print a test string
mov bx, TEST_STRING
call print_string

call read_disk

jmp PROGRAM_SPACE ; Go to the extended program

; Include files
%include "./print.asm"
%include "./disk.asm"

; Global Variables
TEST_STRING: db "Gooood Moooorning Vietnam!",0xA, 0xD,0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55