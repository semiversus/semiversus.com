SRC=main.c hal.c game.c
BIN=game

$(BIN).hex: $(BIN).elf
	avr-objcopy -j .data -j .text -O ihex $(BIN).elf $(BIN).hex

$(BIN).elf: $(SRC)
	avr-gcc -mmcu=atmega16 $(SRC) -o $(BIN).elf -Os

load: $(BIN).hex
	bootloadHID -r $<

clean:
	rm -rf $(BIN).hex $(BIN).elf
