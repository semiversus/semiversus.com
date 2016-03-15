#include "safe.h"
#include "hal.h"

timer_var_t timer_safe;

static uint16_t code_stored, code_actual; 
static uint8_t digits_entered;

static enum safe_state_t {CLOSED, WRONG_CODE, OPEN, NEW_CODE, SHOW_NEW_CODE} safe_state;

void safe_init(void) {
	code_stored=1234; // initial code 
	digits_entered=0;
	safe_state=CLOSED;
	timer_safe=TIMER_DISABLED;
}

void safe_process(void) {
	uint8_t key=hal_key_get(); // handle keys (0 - no key is pressed, 1 to 4 - corresponding key was pressed

	// handle input and timer
	switch (safe_state) {
		case CLOSED:
			hal_lcd_printf(0,0,"CLOSED	");
			if (key) {
				code_actual=code_actual*10+key;
				hal_lcd_printf(1, digits_entered, "*");
				digits_entered++;
				if (digits_entered==4) {
					digits_entered=0;
					if (code_actual==code_stored) {
						safe_state=OPEN;
						timer_safe=TIMER_SEC(3);
					}
					else {
						safe_state=WRONG_CODE;
						timer_safe=TIMER_SEC(2);
					}
					code_actual=0;
				}
			}
			break;
		case WRONG_CODE:
			hal_lcd_printf(0,0,"WRONG ");
			hal_lcd_printf(1,0,"CODE");
			if (key || timer_safe==0) {
				safe_state=CLOSED;
				hal_lcd_clear();
			}
			break;
		case OPEN:
			hal_lcd_printf(0,0,"OPEN");
			hal_lcd_printf(1,0,"		");
			if (key) {
				safe_state=NEW_CODE;
				digits_entered=1;
				code_actual=key;
			}
			else if (timer_safe==0) {
				safe_state=CLOSED;
			}
			break;
		case NEW_CODE:
			hal_lcd_printf(0,0,"NEW CODE");
			hal_lcd_printf(1,0,"%d", code_actual);
			if (key) {
				code_actual=code_actual*10+key;
				digits_entered++;
				if (digits_entered==4) {
					hal_lcd_printf(1,0,"%d", code_actual);
					digits_entered=0;
					code_stored=code_actual;
					code_actual=0;
					safe_state=SHOW_NEW_CODE;
					timer_safe=TIMER_SEC(2);
				}
			}
			break;
		case SHOW_NEW_CODE:
			if (key || timer_safe==0) {
				safe_state=CLOSED;
				hal_lcd_clear();
			}
			break;
	}
}
