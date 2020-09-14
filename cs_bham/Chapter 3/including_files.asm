; =================================================
; Sometimes it would be nice to include other files
; =================================================

; Simply inserts the included file into the base file
%include "calling_functions.asm"

; ...
mov al, 'H'             ; Store 'H' in al so it can be printed
call my_print_function  ; Call function from included file