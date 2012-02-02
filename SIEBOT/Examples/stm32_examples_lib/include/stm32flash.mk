# Make definitions for the stm32flash utility

# $Id: stm32flash.mk 3465 2011-11-29 08:30:31Z svn $

STM32FLASH	?= stm32flash
STM32FLASH_PORT	?= /dev/ttyS0

.SUFFIXES: .stm32flash

# Program flash with stm32flash and serial boot loader

.bin.stm32flash:
	$(STM32FLASH) -w $< -v -g 0x0 $(STM32FLASH_PORT)
