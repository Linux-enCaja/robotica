/*
 * aeroquad32 (STM32F103VET6, high density) linker script for
 * JTAG (bare metal, no bootloader) builds.
 */

MEMORY
{
  rom (rx)  		: ORIGIN = 0x08000000, LENGTH = 1024K
  ram (rwx) 		: ORIGIN = 0x20000000, LENGTH = 128K
}
  
GROUP(libcs4_stm32_high_density.a)

REGION_ALIAS("REGION_TEXT", rom);
REGION_ALIAS("REGION_DATA", ram);
REGION_ALIAS("REGION_BSS", ram);
REGION_ALIAS("REGION_RODATA", rom);

_FLASH_BUILD = 1;
INCLUDE common.inc
