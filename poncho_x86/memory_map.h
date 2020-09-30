#include "type_defs.h"

#ifndef __MEMORY_MAP__
#define __MEMORY_MAP__

extern const uint8_t MEMORY_REGION_COUNT; // defined by detect_memory.asm

typedef struct memory_map_entry
{
    uint64_t base_address;
    uint64_t region_length;
    uint32_t region_type;
    uint32_t extended_attributes;
} memory_map_entry_t;

void print_memory_map(memory_map_entry_t* memory_map);

memory_map_entry_t** get_usable_memory_regions();
uint8_t get_usable_memory_regions_count();


#endif