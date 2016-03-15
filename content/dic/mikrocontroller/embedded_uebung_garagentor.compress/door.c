#include "hal.h"
#include "door.h"

#define DOOR_OPENED 0
#define DOOR_OPENING 1
#define DOOR_CLOSED 2
#define DOOR_CLOSING 3

#define KEY_UP 0
#define KEY_DOWN 1
#define LIMIT_UP 2
#define LIMIT_DOWN 3

#define MOTOR_UP 2
#define MOTOR_DOWN 3

static uint8_t state;

void door_init(void) {
}

void door_process(void) {
	// process next state
	switch (state) {
		case DOOR_OPENED:
			break;
		case DOOR_OPENING:
			break;
		case DOOR_CLOSED:
			break;
		case DOOR_CLOSING:
			break;
	}

	// output function
	switch (state) {
		case DOOR_OPENED:
			break;
		case DOOR_OPENING:
			break;
		case DOOR_CLOSED:
			break;
		case DOOR_CLOSING:
			break;
	}
}