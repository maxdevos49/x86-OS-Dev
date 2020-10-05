#include <stdint.h>
#include <stddef.h>

#include "text_color_codes.h"

#ifndef __TEXT_PRINT__
#define __TEXT_PRINT__

#define DEFAULT_STYLE BACKGROUND_COLOR_BLUE | COLOR_WHITE

#define VGA_MEMORY (uint8_t *)0xb8000
#define VGA_WIDTH 80
#define VGA_HEIGHT 40

void set_cursor_position(uint16_t position);

uint16_t get_cursor_position();

uint16_t position_from_coords(uint8_t x, uint8_t y);

void clear_screen(uint64_t clear_color);

void print_string(const char *str, uint8_t color);

void print_char(char chr, uint8_t color);

const char *hex_to_string(uint64_t value, size_t size);

const char *integer_to_string(int64_t value);

const char *float_to_string(double value, uint8_t decimal_places);

#endif