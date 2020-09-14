mov ah, 0x0e           ; Enable teletype mode
mov al, '/'
int 0x10


loop:
    call nextRan       ; Generate next random number
    ; mov al, ah         ; Move random bumber into bx
    ; int 0x10
    ; mov ax, 2          ; move 2 into ax
    div ax             ; 2 mod ax = ah
    cmp ah, 1          ; Compare ah = 0 or ah = 1
    je elseBranch      ; Jump to else branch if ah == 1
    call backwardBrace ; print back brace
    jmp loop           ; jump to loop

elseBranch:
    call forwardBrace
    jmp loop
ret

; Generates a random number
; inputs: none
; clobbers DX. Returns AX = new random number
nextRan:
    mov ax, 25173      ; LCG Multiplier
    mul dx     ; DX:AX = LCG multiplier * seed
    add ax, 13849      ; Add LCG increment value
    mov dx, ax      ; Update seed = return value
ret

; Prints the forward brace
; inputs: none
; returns: none
forwardBrace:
    mov ah, 0x0e           ; Enable teletype mode
    mov al, '/'
    int 0x10
ret

; Prints the backward brace
; inputs: none
; returns: none
backwardBrace:
    mov ah, 0x0e           ; Enable teletype mode
    mov al, '\'
    int 0x10
ret


TIMES 510-($-$$) db 0
db 0x55, 0xaa