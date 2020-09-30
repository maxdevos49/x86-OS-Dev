#include "heap.h"

memory_segment_header_t *first_free_memory_segment;

void initialize_heap(uint64_t heap_address, uint64_t heap_length)
{
    first_free_memory_segment = (memory_segment_header_t *)heap_address;
    first_free_memory_segment->memory_length = heap_length - sizeof(memory_segment_header_t);
    first_free_memory_segment->next_segment = NULL;
    first_free_memory_segment->previous_segment = NULL;
    first_free_memory_segment->next_free_segment = NULL;
    first_free_memory_segment->free = true;
}

void *malloc(size_t size)
{
    uint64_t remainder = size % 8;
    size -= remainder;

    if (remainder != 0)
        size += 8;

    memory_segment_header_t *current_memory_segment = first_free_memory_segment;

    while (true)
    {
        if (current_memory_segment->memory_length >= size)
        {

            if (current_memory_segment->memory_length != size)
            {
                memory_segment_header_t *new_segment_header =
                    (memory_segment_header_t *)((uint64_t)current_memory_segment + sizeof(memory_segment_header_t) + size);

                new_segment_header->free = true;
                new_segment_header->memory_length = ((uint64_t)current_memory_segment->memory_length) - (sizeof(memory_segment_header_t) + size);
                new_segment_header->next_free_segment = current_memory_segment->next_free_segment;
                new_segment_header->next_segment = current_memory_segment->next_segment;
                new_segment_header->previous_segment = current_memory_segment;
                new_segment_header->previous_free_segment = current_memory_segment->previous_free_segment;

                current_memory_segment->next_free_segment = new_segment_header;
                current_memory_segment->next_segment = new_segment_header;
            }

            if (current_memory_segment == first_free_memory_segment)
            {
                first_free_memory_segment = current_memory_segment->next_free_segment;
            }

            current_memory_segment->free = false;
            current_memory_segment->memory_length = size;

            if (current_memory_segment->previous_free_segment != NULL)
            {
                current_memory_segment->previous_free_segment->next_free_segment =
                    current_memory_segment->next_free_segment;
            }

            if (current_memory_segment->next_free_segment != NULL)
            {
                current_memory_segment->next_free_segment->previous_free_segment = current_memory_segment;
            }

            return current_memory_segment + 1;
        }

        if (current_memory_segment->next_free_segment == NULL)
        {
            return NULL; //Should never technically happen unless hit the physical ram limit of the system
        }

        current_memory_segment = current_memory_segment->next_free_segment;
    }

    return 0;// should never get here;
}