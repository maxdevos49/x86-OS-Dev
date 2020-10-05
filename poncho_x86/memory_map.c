#include "memory_map.h"
#include "text_print.h"

#include <stddef.h>
#include <stdbool.h>

static uint8_t usable_memory_regions_count = 0;

void print_memory_map(memory_map_entry_t *memory_map)
{

    print_string("Memory Base: ", DEFAULT_STYLE);
    print_string(integer_to_string(memory_map->base_address), DEFAULT_STYLE);
    print_string("\r\n", DEFAULT_STYLE);

    print_string("Region Length: ", DEFAULT_STYLE);
    print_string(integer_to_string(memory_map->region_length), DEFAULT_STYLE);
    print_string("\r\n", DEFAULT_STYLE);

    print_string("Memory Type: ", DEFAULT_STYLE);
    print_string(integer_to_string(memory_map->region_type), DEFAULT_STYLE);
    print_string("\r\n", DEFAULT_STYLE);

    print_string("Region Attributes: ", DEFAULT_STYLE);
    print_string(hex_to_string(memory_map->extended_attributes, sizeof(uint32_t)), DEFAULT_STYLE);
    print_string("\r\n", DEFAULT_STYLE);
    print_string("\r\n", DEFAULT_STYLE);
}

bool memory_region_got = false;
memory_map_entry_t *usable_memory_regions[10];

memory_map_entry_t **get_usable_memory_regions()
{

    if (memory_region_got)
    {
        return usable_memory_regions;
    }

    uint8_t usable_region_index;
    for(uint8_t i = 0; i < MEMORY_REGION_COUNT; i++)
    {
        memory_map_entry_t* mem_map = (memory_map_entry_t*)0x5000;
        mem_map += i;

        if(mem_map->region_type == 1)
        {
            usable_memory_regions[usable_region_index] = mem_map;
            usable_region_index++;
        }
    }

    usable_memory_regions_count = usable_region_index;

    memory_region_got = true;

    return usable_memory_regions;
}

uint8_t get_usable_memory_regions_count(){
    return usable_memory_regions_count;
}