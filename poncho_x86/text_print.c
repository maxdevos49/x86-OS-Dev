#include "text_print.h"
#include "io.h"
uint16_t cursor_position;
char hex_string_output[18];

void set_cursor_position(uint16_t position)
{
    outb(0x3d4, 0x0f);
    outb(0x3d5, (uint8_t)(position & 0xff));
    outb(0x3d4, 0x0e);
    outb(0x3d5, (uint8_t)((position >> 8) & 0xff));

    cursor_position = position;
}

uint16_t position_from_coords(uint8_t x, uint8_t y)
{
    // modulo 2000 keeps the cursor within the bounds of the screen
    return (y * VGA_WIDTH + x) % 2000;
}

void clear_screen(uint64_t clear_color)
{
    uint64_t value = 0;
    value += clear_color << 8;
    value += clear_color << 24;
    value += clear_color << 40;
    value += clear_color << 56;

    for (uint64_t *i = (uint64_t *)VGA_MEMORY; i < (uint64_t *)(VGA_MEMORY + 4000); i++)
    {
        *i = value;
    }
}

void print_string(const char *str, uint8_t color)
{
    uint8_t *char_ptr = (uint8_t *)str;
    uint16_t index = cursor_position;

    while (*char_ptr != 0)
    {

        switch (*char_ptr)
        {
        case 10:
            index += VGA_WIDTH;
            break;
        case 13:
            index -= index % VGA_WIDTH;
            break;
        default:
            *(VGA_MEMORY + index * 2) = *char_ptr;
            *(VGA_MEMORY + index * 2 + 1) = color;
            index++;
            break;
        }

        char_ptr++;
    }

    set_cursor_position(index);
}

const char *hex_to_string(const uint64_t value, size_t size)
{
    size = size * 2;
    uint8_t *ptr;
    uint8_t temp;
    uint8_t i;

    for (i = 0; i < size; i++)
    {
        ptr = ((uint8_t *)&value + i);
        temp = ((*ptr & 0xf0) >> 4);
        hex_string_output[(size - (i * 2 + 1)) + 1] = temp + (temp > 9 ? 55 : 48);
        temp = ((*ptr & 0x0f));
        hex_string_output[(size - (i * 2)) + 1] = temp + (temp > 9 ? 55 : 48);
    }

    //add the "0x" at the beginning
    hex_string_output[0] = '0';
    hex_string_output[1] = 'x';

    //null terminate string
    hex_string_output[size + 2] = 0;

    return hex_string_output;
}