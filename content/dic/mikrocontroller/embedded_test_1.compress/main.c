#include "hal.h"
#include "game.h"

TIMERS(0); // TODO: add registred timers here

int main(void) {
	hal_init();
	game_init();
	while(1) {
		hal_process();
		game_process();
	}
	return 0;
}
