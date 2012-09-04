target remote localhost:2331
monitor speed 2000
monitor flash device = STM32F407VG
monitor endian little
monitor flash breakpoints = 1
monitor flash download = 1

monitor reset

## programming:
load build/STM32V1F4.elf

## debug programming:
#load build/STM32V1F4.elf

## load symbol tables (debugging):
#file FLASH_RUN/mp32f4.elf

# not really required
#monitor reg r13 = (0x00000000)
#monitor reg pc = (0x00000004)


