; ===========================================
; We my simulate a function as the fowllowing
; ===========================================

...
    jmp my_print_function
return_to_here:
...
...

my_print_function:
    mov ah, 0x0e       ; Enable teletype
    int 0x10           ; Print with bios whats in al
    jmp return_to_here ; Return to the label

; =================================
; CPU provides call and ret(return)
; =================================

my_print_function:
    mov ah, 0x0e        ; Enable Teletype mode 
    int 0x10            ; Print using interupt from bios
    ret                 ; Return to where we were called

; ===========================================================================
; We may need to use registers so it is wise to save there state in the stack
; ===========================================================================

some_function:
    pusha               ; Pushes all registers onto the stack
    mov bx, 10          ; Move the value 10 into register bx
    add bx, 20          ; Add 20 to the value of the bx register
    mov ah, 0x0e        ; Enable teletype mode
    int 0x10            ; Print using bios interupt
    popa                ; Pop all registers we previously pushed onto the stack restoring the register state
    ret                 ; Return to where we were called

