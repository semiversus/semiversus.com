#include "hal.h"
#include "door.h"

TIMERS(0); // registred timers

int main(void) {
	// initialisation
	hal_init();
	door_init();

	while(1) {
		// main loop state machines
		hal_process();
		door_process();
	}
	return 0;
}
