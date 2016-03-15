#ifndef COUNTDOWN_H
#define COUNTDOWN_H

#include "hal.h"

extern timer_var_t timer_app;

void app_init(void);
void app_process(void);

#endif
