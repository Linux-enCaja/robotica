flashif.hex: flashif.elf
	arm-elf-objcopy -O ihex flashif.elf flashif.hex

# Add THUMB_FLAGS to compilation command below for slightly
# smaller code. NOTE: This hasn't been tested.
THUMB_FLAGS=-mthumb -mthumb-interwork
flashif.elf: flashif.c crc.c
	arm-elf-gcc -O3 -Wall -nostdlib -march=armv4t -mcpu=arm7tdmi -T linkscript.x -o flashif.elf flashif.c crc.c -Wl,-Map,flashif.map

# This program can't be run directly, but sometimes it's useful
# to make debugging versions and run them in this fashion.
.PHONY: run
run: flashif.hex
	Sam_I_Am open , send flashif.hex , go

.PHONY: clean
clean:
	-rm -f *.hex *.elf *.o *.map flashif

# Native host test code (easier to debug :-)
flashif: flashif.c crc.c
	gcc -g -o flashif -O3 -Wall -DTESTING flashif.c crc.c

# vim: noexpandtab
