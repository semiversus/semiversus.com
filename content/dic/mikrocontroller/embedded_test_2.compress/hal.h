#ifndef HAL_H
#define HAL_H

#include <stdint.h>

void hal_init(void);
void hal_process(void);

// LED Port
void hal_leds_set(uint8_t value);
void hal_led_set(uint8_t index, uint8_t value);

// Keys
uint8_t hal_key_get();

// Sound
void hal_sound_play(uint16_t frequency);

// Timer
typedef uint32_t timer_var_t;
typedef timer_var_t * const timer_array_t[];
extern timer_array_t hal_timers;

#define TIMER_DISABLED (timer_var_t)-1
#define TIMER_MSEC(v) ((v)*1000ul)
#define TIMER_SEC(v) ((v)*1000000ul)
#define TIMER_MINUTE(v) ((v)*60000000ul)
#define TIMERS(...) timer_array_t hal_timers={__VA_ARGS__, 0};

// LC Display
void hal_lcd_clear(void);
void hal_lcd_printf(uint8_t line, uint8_t pos, char *fmt, ...);

#endif
