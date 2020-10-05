#include <stdint.h>
#include <stdbool.h>

#ifndef __KEYBOARD__
#define __KEYBOARD__

void keyboard_handler(uint8_t scan_code, char chr);

#endif