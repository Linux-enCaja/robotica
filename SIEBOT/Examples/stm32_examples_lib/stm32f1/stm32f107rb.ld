/* Linker script for STM32F107 Cortex-M3 ARM MCU */

/* $Id: stm32f107rb.ld 3532 2011-12-07 17:38:22Z svn $ */

MEMORY
{
  flash (rx)  : ORIGIN = 0x00000000, LENGTH = 256K
  ram (rwx) : ORIGIN = 0x20000000, LENGTH = 64K
}

__rom_start__	= ORIGIN(flash);
__rom_size__	= LENGTH(flash);
__ram_start__	= ORIGIN(ram);
__ram_size__	= LENGTH(ram);
__ram_end__	= __ram_start__ + __ram_size__;
__stack_end__	= __ram_end__;		/* Top of RAM */
__stack_size__	= 16K;
__stack_start__	= __stack_end__ - __stack_size__;
__heap_start__	= __bss_end__;		/* Between bss and stack */
__heap_end__	= __stack_start__;

SECTIONS
{
  . = 0;

  .text : {
  *(.text)				/* Program code */
  *(.rodata)				/* Read only data */
  *(.rodata*)
  *(.glue_7)
  *(.glue_7t)
  *(.eh_frame)
  } >flash

/* C++ exception unwinding stuff--needed by Code Sourcery toolchain */

  .ARM.extab : { *(.ARM.extab* .gnu.linkonce.armextab.*) } >flash

  __exidx_start = .;
  .ARM.exidx : { *(.ARM.exidx* .gnu.linkonce.armexidx.*) } >flash
  __exidx_end = .;

  . = ALIGN(4);
  __text_end__ = .;

  .data : {
  . = ALIGN(4);
  __data_beg__ = .;			/* Used in crt0.S */
  *(.data)				/* Initialized data */
  . = ALIGN(4);
  __data_end__ = .;			/* Used in crt0.S */
  } >ram AT > flash 

  .bss : {
  . = ALIGN(4);
  __bss_beg__ = .;			/* Used in crt0.S */
  *(.bss)				/* Uninitialized data */
  *(COMMON)				/* Common data */
  . = ALIGN(4);
  __bss_end__ = .;			/* Used in crt0.S */
  } >ram

  . = ALIGN(4);
  end = .;
}  


