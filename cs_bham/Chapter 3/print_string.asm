; Prints a string
; Parameters: bx -> Address to the beginning of a string
print_string:
    pusha                   ; Push all registers into stack

    print_string_loop:
        mov al, [bx]        ; Move the value of bx into al
        call print_char     ; Print the char in al
        cmp al, 0           ; Test if al is a null byte
        je print_string_end ; Jump if al equals a null byte
        add bx, 1           ; Add 1 to the address of bx
        jmp print_string_loop

    print_string_end:
    popa                    ; Pop all registers back to original state
    ret

    ; Prints a single char
    ; Parameters: al -> char ascii code
print_char:
    mov ah, 0x0e            ; Indicate we want teletype mode
    int 0x10                ; print using bios interrtupt
    ret

    ; Prints a hex value
    ; Parameters: dx -> hex value
print_hex:
    pusha


    ; First hex value
    push dx                 ; Store extra copy of bx
    shr dx, 12              ; shift dx 12 bits to the right
    mov bx, HEX_TABLE       ; Store HEX_TABLE address onto cx
    add bx, dx              ; Calculate HEX_TABLE address
    mov al, [bx]            ; Dereference HEX Symbol and put in ax
    mov [HEX_OUT+2], al     ; Store hex symbol in HEX_OUT
    pop dx                  ; Restore dx

    ; second hex value
    push dx
    shr dx, 8               ; shift dx 8 bits to the right
    and dx, 0x0f            ; remove bits at the beginning
    mov bx, HEX_TABLE       ; Store HEX_TABLE address onto cx
    add bx, dx              ; Calculate HEX_TABLE address
    mov al, [bx]            ; Dereference HEX Symbol and put in ax
    mov [HEX_OUT+3], al     ; Store hex symbol in HEX_OUT
    pop dx

    ; third hex value
    push dx
    shr dx, 4               ; shift dx 4 bits to the right
    and dx, 0x0f            ; Remove unneeded bits
    mov bx, HEX_TABLE       ; Store HEX_TABLE address onto cx
    add bx, dx              ; Calculate HEX_TABLE address
    mov al, [bx]            ; Dereference HEX Symbol and put in ax
    mov [HEX_OUT+4], al     ; Store hex symbol in HEX_OUT
    pop dx

    ; fourth hex value
    and dx, 0x0f            ; Remove unneeded bits
    mov bx, HEX_TABLE       ; Store HEX_TABLE address onto cx
    add bx, dx              ; Calculate HEX_TABLE address
    mov al, [bx]            ; Dereference HEX Symbol and put in ax
    mov [HEX_OUT+5], al     ; Store hex symbol in HEX_OUT

    mov bx, HEX_OUT         ; Move HEX_OUT address into bx
    call print_string       ; Print the string refreneced by bx

    popa
    ret

    ; Global Variables
HEX_OUT: db '0x0000', 0
HEX_TABLE: db '0123456789abcdef',0

