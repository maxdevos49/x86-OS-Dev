#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#include "text_print.h"
#include "text_color_codes.h"
#include "IDT.h"
#include "keyboard.h"
#include "memory_map.h"
#include "heap.h"

extern const char Testing[];

void _start()
{
    clear_screen(BACKGROUND_COLOR_BLUE | COLOR_WHITE);
    set_cursor_position(0);

    init_IDT();
    main_keyboard_handler = keyboard_handler;

    print_string("\n\r", DEFAULT_STYLE);

    memory_map_entry_t **usable_memory_regions = get_usable_memory_regions();

    for (uint8_t i = 0; i < get_usable_memory_regions_count(); i++)
    {
        memory_map_entry_t *mem_map = usable_memory_regions[i];

        print_memory_map(mem_map);
    }

    initialize_heap(0x100000, 0x100000);
    void *test_address_1 = malloc(0x10);
    void *test_address_2 = malloc(0x10);
    void *test_address_3 = malloc(0x10);

    print_string(hex_to_string((uint64_t)test_address_1, sizeof(uint64_t)), DEFAULT_STYLE);
    print_string("\n\r", DEFAULT_STYLE);
    print_string(hex_to_string((uint64_t)test_address_2, sizeof(uint64_t)), DEFAULT_STYLE);
    print_string("\n\r", DEFAULT_STYLE);
    print_string(hex_to_string((uint64_t)test_address_3, sizeof(uint64_t)), DEFAULT_STYLE);
    print_string("\n\r", DEFAULT_STYLE);

    free(test_address_1);
    free(test_address_2);
    free(test_address_3);

    void *test_address_4 = malloc(0x10);
    print_string(hex_to_string((uint64_t)test_address_4, sizeof(uint64_t)), DEFAULT_STYLE);
    print_string("\n\r", DEFAULT_STYLE);
}
