/* Simple serial console I/O test program for the STM32F1 ARM MCU */

// $Id: test_spi.c 3339 2011-11-21 12:38:24Z svn $

static const char revision[] = "$Id: test_spi.c 3339 2011-11-21 12:38:24Z svn $";

#include <assert.h>
#include <cpu.h>
#include <errno.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define SPI_PORT 1

#ifndef SPI_PORT
#ifdef OLIMEX_STM32_P103
#define SPI_PORT	1
#endif

#ifdef OLIMEX_STM32_P107
#define SPI_PORT	3
#endif

#ifdef STM32_VALUE_LINE_DISCOVERY
#define SPI_PORT	1
#endif

#ifdef W5200E01_M3
#define SPI_PORT	2
#endif
#endif

int main(void)
{
  int status;
  char buf[256];
  uint8_t commandbyte;
  uint8_t responsebyte;

  cpu_init(DEFAULT_CPU_FREQ);

  serial_stdio(CONSOLE_PORT);

  puts("\033[H\033[2JSTM32F1 SPI Master Test (" __DATE__ " " __TIME__ ")\n");
  puts(revision);
  printf("\nCPU Freq:%ld Hz  Compiler:%s\n\n", CPUFREQ, __VERSION__);

  if ((status = spimaster_init(SPI_PORT, 0, 281250, TRUE)))
  {
    fprintf(stderr, "ERROR: spimaster_init() failed at line %d, %s\n", status, strerror(errno));
    assert(FALSE);
  }

  for (;;)
  {
    printf("Enter a value to send: ");
    fflush(stdout);
    fflush(stdin);
    gets(buf);
    commandbyte = atoi(buf);

    if ((status = spimaster_transfer(SPI_PORT, &commandbyte, 1, &responsebyte, 1)))
    {
      fprintf(stderr, "ERROR: spimaster_transfer() failed at line %d, %s\n", status, strerror(errno));
      assert(FALSE);
    }

    printf("Response was %02X\n\n", responsebyte);
  }
}
