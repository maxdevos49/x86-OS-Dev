mov ah, 0x02         ; Bios read sector function
mov dl, 0            ; Read drive 0
mov ch, 3            ; Select cylinder 3
mov dh, 1            ; Select the track on the second side of the floopy
                        ; disk, since this count has base 0
mov cl, 4            ; Select the 4th secor on the track - not
                        ; the 5th, since this has a base of 1
mov al, 5            ; Read 5 sectors from the stasrt point

; Lastly, set the address that we'd like BIOS to read the sectors to,
; which BIOS expects to find in ES:BX
; (i.e. segment ES with offset BX).
mov bx, 0xa000       ; Indiectly set ES to 0xa000
mov es, bx
mov bx, 0x1234       ; SET BX to 0x1234
; In Our case, data will be read to 0xa000:0x1234, which the CPU
; will translate to physical address 0xa1234

int 0x13             ; Now issue the BIOS interupt to do the actual read.

jc disk_error   ; jc is annother jumping instruction, that jumps
                    ; only if the carry flag was set
; This jumps if what BIOS reported as the number of sectors
; actually read in AL is not equal to the number we expected.
cmp al, <no. sectors expected>
jne disk_error

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

; Global variables
DISK_ERROR_MSG: db "Disk read Error";