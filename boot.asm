mov ah, 0x0e    ; Enable Teletype mode for bios 
mov al, 65      ; Put our desired character to print in correct register
int 0x10        ; Bios interupt to print

loop: 

    ; Challenge Code start
    inc al
    add al, 32
    int 0x10
    sub al, 32
    ; Challenge Code End

    inc al
    int 0x10

    cmp al, 89
    jl loop     ; jump if previous compare is less then the second value
    
jmp $                   ; Make an infinite loop
TIMES 510-($-$$) db 0   ; Compiles this line into exexutable how ever many needed times to make the executable 5q2 bytes, Not actually machine code
db 0x55, 0xaa           ; Define special bytes that the processor will recognize as bootable