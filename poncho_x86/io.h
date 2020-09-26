#ifndef __IO__
#define __IO__

#include "type_defs.h"

void outb(uint16_t port, uint8_t val);
uint8_t inb(uint16_t port);

#endif