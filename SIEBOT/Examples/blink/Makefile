NAME   = stm_p103_blink_rom

CC      = arm-none-linux-gnueabi-gcc
LD      = arm-none-linux-gnueabi-ld -v
AR      = arm-none-linux-gnueabi-ar
AS      = arm-none-linux-gnueabi-as
CP      = arm-none-linux-gnueabi-objcopy
OD		= arm-none-linux-gnueabi-objdump
  
CFLAGS  =  -I./ -c -fno-common -O0 -g -mcpu=cortex-m3 -mthumb 
AFLAGS  = -ahls -mapcs-32 -o crt.o
LFLAGS  = -Tlinker.ld -nostartfiles
CPFLAGS = -Obinary
ODFLAGS	= -S

all: test

clean:
	-rm -rf main.list main.o main.out main.hex main.map stm32f10x_rcc.o stm32f10x_gpio.o *.o *.bin

test: main.out
	@ echo "...copying"
	$(CP) $(CPFLAGS) main.out main.bin
	$(OD) $(ODFLAGS) main.out > main.list

main.out: main.o stm32f10x_rcc.o stm32f10x_gpio.o linker.ld 
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
