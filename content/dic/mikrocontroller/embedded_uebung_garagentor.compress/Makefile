SRC=main.c hal.c door.c

app.hex: app.elf
	avr-objcopy -j .data -j .text -O ihex app.elf app.hex

app.elf: $(SRC)
	avr-gcc -mmcu=atmega16 $(SRC) -o app.elf

load: app.hex
	bootloadHID -r $<

clean:
	rm -rf app.hex app.elf
