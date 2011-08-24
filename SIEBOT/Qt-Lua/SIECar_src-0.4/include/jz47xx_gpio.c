/*
  JZ47xx GPIO at userspace

  Copyright (C) 2010      Andres Calderon andres.calderon@emqbit.com
                                 
This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA */

#include <stdio.h>
#include <stdlib.h>
#include "unistd.h"

#include "jz47xx_gpio.h"
#include "jz47xx_mmap.h"


#define JZ_GPIO_BASE 0x10010000

void
jz_gpio_as_output (JZ_PIO * pio, unsigned int o)
{
  pio->PXFUNC = (1 << (o));
  pio->PXSELC = (1 << (o));
  pio->PXDIRS = (1 << (o));
}

void
jz_gpio_as_input (JZ_PIO * pio, unsigned int o)
{
  pio->PXFUNC = (1 << (o));
  pio->PXSELC = (1 << (o));
  pio->PXDIRC = (1 << (o));
}

void
jz_gpio_as_irq (JZ_PIO * pio, unsigned int o)
{
  pio->PXFUNC = (1 << (o));
  pio->PXSELS = (1 << (o));
  pio->PXDIRC = (1 << (o));
}

void
jz_gpio_set_pin (JZ_PIO * pio, unsigned int o)
{
  pio->PXDATS = (1 << (o));
}

void
jz_gpio_clear_pin (JZ_PIO * pio, unsigned int o)
{
  pio->PXDATC = (1 << (o));
}

void
jz_gpio_out (JZ_PIO * pio, unsigned int o, unsigned int val)
{
  if (val == 0)
    pio->PXDATC = (1 << (o));
  else
    pio->PXDATS = (1 << (o));
}

unsigned int
jz_gpio_get_pin (JZ_PIO * pio, unsigned int o)
{
  return (pio->PXPIN & (1 << o)) ? 1 : 0;
}

int
jz_gpio_as_func (JZ_PIO * pio, unsigned int o, int func)
{
  switch (func)
    {
    case 0:
      pio->PXFUNS = (1 << o);
      pio->PXTRGC = (1 << o);
      pio->PXSELC = (1 << o);
      pio->PXPES  = (1 << o);
      return 1;

    case 1:
      pio->PXFUNS = (1 << o);
      pio->PXTRGC = (1 << o);
      pio->PXSELS = (1 << o);
      pio->PXPES  = (1 << o);
      return 1;

    case 2:
      pio->PXFUNS = (1 << o);
      pio->PXTRGS = (1 << o);
      pio->PXSELC = (1 << o);
      pio->PXPES  = (1 << o);
      return 1;
    }
  return 0;
}

JZ_PIO *
jz_gpio_map (int port)
{
  JZ_PIO *pio;

  pio = (JZ_PIO *) jz_mmap (JZ_GPIO_BASE);
  pio = (JZ_PIO *) ((unsigned int) pio + port * 0x100);

  return pio;
}
