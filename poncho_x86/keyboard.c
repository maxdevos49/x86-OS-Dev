#include "keyboard.h"
#include "text_print.h"
#include "IDT.h"

bool left_shift_pressed = false;
bool right_shift_pressed = false;
uint8_t last_scan_code;

void standard_keyboard_handler(uint8_t scan_code, char chr)
{
    if (chr != 0)
    {
        switch (left_shift_pressed | right_shift_pressed)
        {
        case true:
            print_char(chr - 32, DEFAULT_STYLE);
            break;
        case false:
            print_char(chr, DEFAULT_STYLE);
            break;
        }
    }
    else
    {
        switch (scan_code)
        {
        case 0x8e: //Backspace press
            set_cursor_position(get_cursor_position() - 1);
            print_char(' ', DEFAULT_STYLE);
            set_cursor_position(get_cursor_position() - 1);
            break;
        case 0x2a: //left shift press
            left_shift_pressed = true;
            break;
        case 0xaa: //left shift release
            left_shift_pressed = false;
            break;
        case 0x36: //right shift press
            right_shift_pressed = true;
            break;
        case 0xb6: //right shift release
            right_shift_pressed = false;
            break;
        case 0x9c: //enter
            print_string("\n\r", DEFAULT_STYLE);
            break;
        }
    }
}

void keyboard_handler_0xE0(uint8_t scan_code)
{
    switch (scan_code)
    {
    case 0x50: //down arrow
        set_cursor_position(get_cursor_position() + VGA_WIDTH);
        break;
    case 0x48:
        set_cursor_position(get_cursor_position() - VGA_WIDTH);
        break;
    }
}

void keyboard_handler(uint8_t scan_code, char chr)
{

    switch (last_scan_code)
    {
    case 0xe0:
        keyboard_handler_0xE0(scan_code);
        break;
    default:
        standard_keyboard_handler(scan_code, chr);
    }

    last_scan_code = scan_code;
}