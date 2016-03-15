#include "safe.h"
#include "hal.h"

TIMERS(&timer_safe);

int main(void) {
	hal_init();
	safe_init();
	while(1) {
		safe_process();
		hal_process();
	}
	return 0;
}
