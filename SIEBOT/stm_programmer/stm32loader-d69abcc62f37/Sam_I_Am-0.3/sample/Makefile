# Two programs are created, blinky.elf and blinkyf.elf. The first is intended
# to run entirely in RAM, while the second is to be programmed into FLASH.
# These programs will blink the LED 5 times on an Atmel AT91SAM7S64-EK
# development board (this is PIO port PA0).
#
# To compile both programs, type 'make'.
# To run the RAM-based program, type 'make run'.
# To write FLASH with the FLASH-based program, type 'make flash'.
# To run the FLASH-based program, type 'make runflash'.

PROGNAME=blinky

CC=arm-elf-gcc
NM=arm-elf-nm
CFLAGS=-Wall -O3 -march=armv4t -mcpu=arm7tdmi
LFLAGS=-nostdlib -T linkscript.x -Wl,-Map,${PROGNAME}.map
LFLAGSFLASH=-nostdlib -T linkscriptf.x -Wl,-Map,${PROGNAME}f.map

all: ${PROGNAME}.elf ${PROGNAME}f.elf

${PROGNAME}.elf: ${PROGNAME}.c
	    ${CC} ${CFLAGS} ${LFLAGS} -o $@ $<
	    arm-elf-objcopy -O ihex $@ ${PROGNAME}.hex

${PROGNAME}f.elf: ${PROGNAME}.c
	    ${CC} ${CFLAGS} ${LFLAGSFLASH} -o $@ $<
	    arm-elf-objcopy -O ihex $@ ${PROGNAME}f.hex

.PHONY: run
run: ${PROGNAME}.elf
			Sam_I_Am send ${PROGNAME}.hex , go

.PHONY: flash
flash: ${PROGNAME}f.elf
			Sam_I_Am flash ${PROGNAME}f.hex

.PHONY: runflash
runflash: ${PROGNAME}f.elf
			#Sam_I_Am go `${NM} ${PROGNAME}f.elf | fgrep -w _start | cut -d" " -f 1`
			Sam_I_Am go 108000

.PHONY: clean
clean:
	    rm -f *.hex *.elf *.map *.o

# vim: noexpandtab
