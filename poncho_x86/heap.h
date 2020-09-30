#include "type_defs.h"

#ifndef __HEAP__
#define __HEAP__

typedef struct memory_segment_header memory_segment_header_t;

struct memory_segment_header
{
    uint64_t memory_length;
    memory_segment_header_t *next_segment;
    memory_segment_header_t *previous_segment;
    memory_segment_header_t *next_free_segment;
    memory_segment_header_t *previous_free_segment;
    bool free;
};

void initialize_heap(uint64_t heap_address, uint64_t heap_length);
void *malloc(size_t size);

#endif