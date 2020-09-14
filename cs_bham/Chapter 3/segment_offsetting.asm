; A Simple boot sector program that demonstrates segment offsetting

mov ah, 0x0e            ; Enable teletype mode

mov al, [the_secret]
int 0x10                ; Does this print F? Nope because the_secret is an address offset

mov bx, 0x7c0           ; Cant directly set ds, so set bx
mov ds, bx              ; copy bx to ds
mov al, [the_secret]
int 0x10                ; Does this print X? Yes because the ds register is implied?

mov al, [es:the_secret] ; Tell the cpu to use the es (not ds/default) segment
int 0x10                ; Does this print an X? Nope because the es register does not know where to start

mov bx, 0x7c0
mov es, bx              ; Tell es where to find its offset
mov al, [es:the_secret]
int 0x10                ; Does this print an X? Yes because the es register offset was set

jmp $

the_secret:
    db 'X'

    ; Padding and magic number
times 510-($-$$) db 0
dw 0xaa55