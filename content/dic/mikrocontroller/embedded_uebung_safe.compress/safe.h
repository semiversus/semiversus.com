#ifndef TRESOR_H
#define TRESOR_H

#include "hal.h"

void safe_init(void);
void safe_process(void);

extern timer_var_t timer_safe;

#endif
