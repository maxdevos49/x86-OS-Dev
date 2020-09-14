mov bx, 30

; ------------- If, else if, and else in assembly----------------
; if(bx <= 4){
; mov al, 'A'
; }else if(bx < 40){
; mov al, 'B'
; }else{
; mov al, 'C'
; }
cmp     bx, 4
jle     if_block
jl      if_else_block
mov     al, 'C'
jmp     if_end

if_block:
mov     al, 'A'
jmp     if_end

if_else_block:
mov     al, 'B'
jmp     if_end

if_end:
mov ah, 0x0e
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55