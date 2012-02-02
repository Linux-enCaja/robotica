/* Simple floating point arithmetic test program for the STM32F1 ARM MCU */

// $Id: test_float.c 3339 2011-11-21 12:38:24Z svn $

static const char revision[] = "$Id: test_float.c 3339 2011-11-21 12:38:24Z svn $";

#undef INTEGER_STDIO

#include <cpu.h>
#include <stdio.h>
#include <string.h>

#ifndef __ARM_EABI__
#error arm-elf-gcc does not support Cortex-M3 floating point correctly! Use an EABI toolchain.
#endif

int main(void)
{
  float x, y;
  int z;

  cpu_init(DEFAULT_CPU_FREQ);

  serial_stdio(CONSOLE_PORT);

  puts("\033[H\033[2JSTM32F1 Floating Point Arithmetic Test (" __DATE__ " " __TIME__ ")\n");
  puts(revision);
  printf("\nCPU Freq:%ld Hz  Compiler:%s\n\n", CPUFREQ, __VERSION__);

  x = 1.0;
  y = 2.0;
  z = x + y;

  printf("x is %f, y is %f, x+y is %f, z is %d\n", x, y, x+y, z);
}
