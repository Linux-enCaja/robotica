NAME   = stm_p103_blink_rom

PREF=arm-none-eabi-

RM=rm -f

CC      = $(PREF)gcc
LD      = $(PREF)ld -v
AR      = $(PREF)ar
AS      = $(PREF)as
CP      = $(PREF)objcopy
OD		= $(PREF)objdump
  
LDCMD	= stm_p103_blink_rom.cmd
#LDCMD	= stm32_ram.cmd
OPTIMIZE=-O0

CFLAGS  =   -I./ -c -fno-common $(OPTIMIZE) -g -mcpu=cortex-m3 -mthumb \
			-Wa,-adhlns=$(<:.c=.lst)
AFLAGS  = -ahls -mapcs-32 -o crt.o
LFLAGS  = -T$(LDCMD) -nostartfiles
CPFLAGS = -Obinary
ODFLAGS	= -S

all: test

clean:
	-rm -f main.list main.o main.out main.bin main.hex main.map stm32f10x_rcc.o stm32f10x_gpio.o
	$(RM) *.lst

test: main.out
	@ echo "...copying"
	$(CP) $(CPFLAGS) main.out main.bin
	$(CP) -Oihex main.out main.hex
	$(OD) $(ODFLAGS) main.out > main.list

main.out: main.o stm32f10x_rcc.o stm32f10x_gpio.o stm_p103_blink_rom.cmd 
	@ echo "..linking"
	$(LD) $(LFLAGS) -o main.out  main.o stm32f10x_rcc.o stm32f10x_gpio.o 

stm32f10x_rcc.o: stm32f10x_rcc.c 
	@ echo ".compiling"
	 $(CC) $(CFLAGS) stm32f10x_rcc.c 
	 
stm32f10x_gpio.o: stm32f10x_gpio.c
	@ echo ".compiling"
	 $(CC) $(CFLAGS) stm32f10x_gpio.c 

main.o: main.c
	@ echo ".compiling"
	 $(CC) $(CFLAGS) main.c
