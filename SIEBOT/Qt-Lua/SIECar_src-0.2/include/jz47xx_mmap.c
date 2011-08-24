/*
 * JZ47xx GPIO lines
 *
 * Written 2010 by Andres Calderon andres.calderon@emqbit.com
 */

#include <stdio.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <stdlib.h>
#include <termios.h>
#include <unistd.h>

#include "jz47xx_mmap.h"


void *
jz_mmap (off_t address)
{
  int fd;

  void *pio;

  if ((fd = open ("/dev/mem", O_RDWR | O_SYNC)) == -1)
    {
      fprintf (stderr, "Cannot open /dev/mem.\n");
      return 0;
    }

  pio = (void *) mmap (0, getpagesize (), PROT_READ | PROT_WRITE, MAP_SHARED, fd, address);

  if (pio == (void *) -1)
    {
      fprintf (stderr, "Cannot mmap.\n");
      return 0;
    }

  return pio;
}

void *
jz_fpga_map (off_t address)
{
  int fd;

  void *fpga;

  if ((fd = open ("/dev/mem", O_RDWR | O_SYNC)) == -1)
    {
      fprintf (stderr, "Cannot open /dev/mem.\n");
      return 0;
    }

  fpga = (void *) mmap (0, FPGA_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, address);

  if (fpga == (void *) -1)
    {
      fprintf (stderr, "Cannot mmap.\n");
      return 0;
    }

  return fpga;
}

