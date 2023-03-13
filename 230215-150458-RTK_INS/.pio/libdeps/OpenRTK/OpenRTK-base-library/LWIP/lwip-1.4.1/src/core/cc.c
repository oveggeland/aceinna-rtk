#include <stdlib.h>
#include <stdint.h>
#include "lwip/cc.h"

uint32_t get_random_value(void)
{
       uint32_t num;
       uint8_t seed_value = 17;
       srand(seed_value);
       num = rand();
       return num;
}