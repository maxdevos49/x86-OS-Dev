;
; A simple boot sector program that demonstrates addressing
;

    mov ah, 0x0e    ; Enable teletype mode

    ; First attempt
    mov al, the_secret
    int 0x10            ; Does it print an X? --> NO it prints address

    ; Second attempt
    mov al, [the_secret]
    int 0x10            ; Does it print an X? --> NO becuse the_secret address is an offset of the program begininng

    ; Third attempt
    mov bx, the_secret
    add bx, 0x7c00
    mov al, [bx]
    int 0x10            ; Does this print an X? -> YES because we added the memory address offset and dereferenced the address

    ; Fourth attempt
    mov al, [0x7c1e]
    int 0x10            ; Does this print an X? --> YES because we precalculated the memory address and also derefrenced it for the value

the_secret: 
    db "X"

; Padding and magic bios number
times 510-($-$$) db 0
dw 0xaa55

[org 0x7c00] ; Indicates the program offset. Adding will result in only #2 printing 'X'.
