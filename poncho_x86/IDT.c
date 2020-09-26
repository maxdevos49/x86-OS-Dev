#include "IDT.h"
#include "io.h"
#include "text_print.h"

extern IDT64_t _idt[256];
extern uint64_t isr1;
extern void load_IDT();

void init_IDT(){

    // uint8_t t;
    // for(t = 0; t < 256; t++){
        _idt[1].zero = 0;
        _idt[1].offset_low = (uint16_t)(((uint64_t)&isr1 & 0x000000000000ffff));
        _idt[1].offset_mid = (uint16_t)(((uint64_t)&isr1 & 0x00000000ffff0000) >> 16);
        _idt[1].offset_high = (uint32_t)(((uint64_t)&isr1 & 0xffffffff00000000) >> 32);
        _idt[1].ist = 0;
        _idt[1].selector = 0x08;
        _idt[1].types_attr = 0x8e;
    // }

    outb(0x21, 0xfd);
    outb(0xa1, 0xff);

    load_IDT();
}

extern void isr1_handler(){
    print_string(hex_to_string(inb(0x60), sizeof(uint8_t)), DEFAULT_STYLE);
    outb(0x20, 0x20);
    outb(0xa0, 0x20);
}
