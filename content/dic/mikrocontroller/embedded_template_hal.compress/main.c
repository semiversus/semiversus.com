#include "hal.h"

TIMERS(0); // registred timers

int main(void) {
	// initialisation
	hal_init();

	while(1) {
		// main loop state machines
		hal_process();

	}
	return 0;
}
