#include "hal.h"
#include "app.h"

TIMERS(&timer_app);

int main(void) {
	hal_init();
	app_init();
	while(1) {
		hal_process();
		app_process();
	}
	return 0;
}
