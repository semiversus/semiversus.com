#include "hal.h"
#include <avr/io.h>
#include <avr/interrupt.h>
#include <stdarg.h>

#define F_CPU 12000000ul

static uint8_t timer_800us=0;
static uint8_t lcd_initialised=0;
static timer_var_t timer_lcd=0;

ISR(TIMER1_COMPA_vect) {
	PORTA^=0x10; // toggle loudspeaker pin
} 

ISR(TIMER0_COMP_vect) {
	timer_800us++;
} 

void hal_init(void) {
	// setting LED port to output and turn off LEDs
	DDRC=0xFF;
	PORTC=0x00;

	// set key port to input and activate pull ups
	DDRA=0x10;
	PORTA=0xEF;

	// initialise timer for sound
	TCCR1A=0x00; // no compare output mode, no waveform generation
	TCCR1B=0x0A; // CTC mode, prescaler 8 (start the timer) 

	TCCR0=0x0B; // CTC mode, prescaler 64 (start the timer)
	OCR0=149; // setting periode time to 800us

	TIMSK=0x02; // disable output compare A interrupt, enable timer 0 overflow interrupt

	sei();
}

void hal_leds_set(uint8_t value) {
	PORTC=value;
}

void hal_led_set(uint8_t index, uint8_t value) {
	if (value) {
		PORTC|=1<<index;
	}
	else {
		PORTC&=~(1<<index);
	}
}

uint8_t keys_pressed=0;

uint8_t hal_key_get(void) {
	uint8_t key, index=0;
	for (index=0; index<4; index++) {
		key=keys_pressed&(1<<index);
		if (key) {
			keys_pressed&=~(1<<index);
			return index+1;
		}
	}
	return 0;
}

void hal_sound_play(uint16_t frequency) {
	if (frequency) {
		OCR1A=(F_CPU/16)/frequency-1;
		TIMSK|=0x10; // activate interrupt
	}
	else {
		OCR1A=0;
		TIMSK&=~0x10; // deactive interrupt
	}
}


#define LCD_WIDTH 8
#define LCD_LINES 2

static char lcd_data[LCD_LINES][LCD_WIDTH];
static uint8_t lcd_init_cmds[14]={0x03, 0x03, 0x03, 0x02, 0x02, 0x08, 0x00, 0x0c, 0x00, 0x01, 0x00, 0x06, 0x00, 0x02};
static uint8_t lcd_changed=1;

static void lcd_init(void) {
	DDRA|=0x50;
	DDRB|=0xE4;
	timer_lcd=TIMER_MSEC(20);
	lcd_initialised=1;
	hal_lcd_clear();
}

static void lcd_process(void) {
	static uint8_t state=0;
	uint8_t data, line, pos;

	if (timer_lcd) return;

	timer_lcd=TIMER_MSEC(1); // wait at least for 1ms

	if (state<14) {
		data=lcd_init_cmds[state];
		if (state==0) timer_lcd=TIMER_MSEC(10);
		else if (state>=12) timer_lcd=TIMER_MSEC(20);
	}
	else if (state==30) {
		data=0x0C;
		timer_lcd=TIMER_MSEC(4);
	}
	else if (state==31) {
		data=0x00;
		timer_lcd=TIMER_MSEC(4);
	}
	else if (state==48) {
		if (lcd_changed) {
			state=12;
		}
		lcd_changed=0;
		timer_lcd=TIMER_MSEC(20);
		return;
	}
	else {
		line=state>31?1:0;
		pos=(state>31?state-32:state-14)/2;
		if (state%2==0) {
			data=0x10|lcd_data[line][pos]>>4;
		}
		else {
			data=0x10|(lcd_data[line][pos]&0x0F);
		}
	}
	state++;

	PORTA=(PORTA&0xAF)|0x10|((data<<2)&0x40); // set EN, set RS
	PORTB=(PORTB&0x1B)|((data<<4)&0xE0)|((data<<2)&0x04);
	PORTA&=~0x10; // reset EN
}

void hal_lcd_clear(void) {
	uint8_t i,j;
	if (!lcd_initialised) {
		lcd_init();
	}
	for (i=0; i<LCD_LINES; i++) {
		for (j=0; j<LCD_WIDTH; j++) {
			if (lcd_data[i][j]!=' ') {
				lcd_changed=1;
				lcd_data[i][j]=' ';
			}
		}
	}
}

static char* bf;
static char buf[12];
static unsigned int num;
static char uc;
static char zs;

static void out(char c) {
		*bf++ = c;
		}

static void outDgt(char dgt) {
	out(dgt+(dgt<10 ? '0' : (uc ? 'A' : 'a')-10));
	zs=1;
		}
	
static void divOut(unsigned int div) {
		unsigned char dgt=0;
	num &= 0xffff; // just for testing the code with 32 bit ints
	while (num>=div) {
		num -= div;
		dgt++;
		}
	if (zs || dgt>0) 
		outDgt(dgt);
		}	

void hal_lcd_printf(uint8_t line, uint8_t pos, char *fmt, ...) {
	va_list va;
	char ch;
	char* p;
	
	va_start(va,fmt);
	
	if ( (line>=LCD_LINES) || (pos>=LCD_WIDTH) ) {
		return;
	}

	if (!lcd_initialised) {
		lcd_init();
	}

	while ((ch=*(fmt++))) {
		if (ch!='%') {
			if (pos<LCD_WIDTH) {
				if (lcd_data[line][pos]!=ch) lcd_changed=1;
				lcd_data[line][pos++]=ch;
			}
		}
		else {
			char lz=0;
			char w=0;
			ch=*(fmt++);
			if (ch=='0') {
				ch=*(fmt++);
				lz=1;
			}
			if (ch>='0' && ch<='9') {
				w=0;
				while (ch>='0' && ch<='9') {
					w=(((w<<2)+w)<<1)+ch-'0';
					ch=*fmt++;
				}
			}
			bf=buf;
			p=bf;
			zs=0;
			switch (ch) {
				case 0: 
					goto abort;
				case 'u':
				case 'd' : 
					num=va_arg(va, unsigned int);
					if (ch=='d' && (int)num<0) {
						num = -(int)num;
						out('-');
					}
					divOut(10000);
					divOut(1000);
					divOut(100);
					divOut(10);
					outDgt(num);
					break;
				case 'x': 
				case 'X' : 
					uc=(ch=='X');
					num=va_arg(va, unsigned int);
					divOut(0x1000);
					divOut(0x100);
					divOut(0x10);
					outDgt(num);
					break;
				case 'c' : 
					out((char)(va_arg(va, int)));
					break;
				case 's' : 
					p=va_arg(va, char*);
					break;
				case '%' :
					out('%');
				default:
					break;
			}
			*bf=0;
			bf=p;
			while (*bf++ && w > 0)
				w--;
			while (w-- > 0 && pos<LCD_WIDTH) {
				ch=lz?'0':' ';
				if (lcd_data[line][pos]!=ch) lcd_changed=1;
				lcd_data[line][pos++]=ch;
			}
			while ((ch= *p++) && pos<LCD_WIDTH) {
				if (lcd_data[line][pos]!=ch) lcd_changed=1;
				lcd_data[line][pos++]=ch;
			}
		}
	}
	abort:;
	va_end(va);
}

void hal_process(void) {
	uint8_t index = 0;
	uint8_t keys;
	static uint8_t keys_old=0;
	int32_t timer_interval;

	TIMSK&=~0x02; // disable 800us timer
	if (timer_800us) {
		timer_interval=timer_800us*800;
		while (hal_timers[index] != 0) {
			if ((*(timer_var_t*)hal_timers[index] != 0) && (*(timer_var_t*)hal_timers[index] != TIMER_DISABLED)) {
				if (*(timer_var_t*)(hal_timers[index]) <= timer_interval) {
					*(timer_var_t*)hal_timers[index] = 0;
				}
				else {
					*(timer_var_t*)hal_timers[index] -= timer_interval;
				}
			}
			index++;
		}
		if (timer_lcd <= timer_interval) {
			timer_lcd = 0;
		}
		else {
			timer_lcd -= timer_interval;
		}
		timer_800us=0;
		keys=PINA&0x0F;
		keys_pressed|=(keys_old^keys)&keys_old;
		keys_old=keys;
	}
	TIMSK|=0x02; // enable 800us timer

	if (lcd_initialised) {
		lcd_process();
	}
}
