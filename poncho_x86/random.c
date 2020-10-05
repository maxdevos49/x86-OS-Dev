#include "random.h"

static uint64_t next = 1;

int rand()
{
    next = next * 1103515245 + 12345;
    return (unsigned int)(next / 65536) % 32768;
}

void srand(uint64_t seed)
{
    next = seed;
}