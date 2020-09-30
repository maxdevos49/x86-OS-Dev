#ifndef __TYPE_DEFS__
#define __TYPE_DEFS__

typedef char int8_t;           // -128 to 127
typedef unsigned char uint8_t; // 0 to 255

typedef short int16_t;           // −32,768 to 32,767
typedef unsigned short uint16_t; // 0 and 65,535

typedef int int32_t;           // -2147483648 to 2147483647
typedef unsigned int uint32_t; // 0 to 4294967295

typedef long long int64_t;           // -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807
typedef unsigned long long uint64_t; // 0 to 18,446,744,073,709,551,615

typedef unsigned long size_t;

#define bool uint8_t
#define true 1
#define false 0

#define NULL (void*)0

#endif