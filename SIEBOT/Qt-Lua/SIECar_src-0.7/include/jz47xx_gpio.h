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

#ifndef __jz47xx_gpio_h__
#define __jz47xx_gpio_h__

#define	JZ_GPIO_PORT_A 0
#define	JZ_GPIO_PORT_B 1
#define	JZ_GPIO_PORT_C 2
#define	JZ_GPIO_PORT_D 3

typedef volatile unsigned int JZ_REG;   /* Hardware register definition */

typedef struct _JZ_PIO
{
  JZ_REG PXPIN;                 /* PIN Level Register */
  JZ_REG Reserved0;
  JZ_REG Reserved1;
  JZ_REG Reserved2;
  JZ_REG PXDAT;                 /* Port Data Register */
  JZ_REG PXDATS;                /* Port Data Set Register */
  JZ_REG PXDATC;                /* Port Data Clear Register */
  JZ_REG Reserved3;
  JZ_REG PXIM;                  /* Interrupt Mask Register */
  JZ_REG PXIMS;                 /* Interrupt Mask Set Reg */
  JZ_REG PXIMC;                 /* Interrupt Mask Clear Reg */
  JZ_REG Reserved4;
  JZ_REG PXPE;                  /* Pull Enable Register */
  JZ_REG PXPES;                 /* Pull Enable Set Reg. */
  JZ_REG PXPEC;                 /* Pull Enable Clear Reg. */
  JZ_REG Reserved5;
  JZ_REG PXFUN;                 /* Function Register */
  JZ_REG PXFUNS;                /* Function Set Register */
  JZ_REG PXFUNC;                /* Function Clear Register */
  JZ_REG Reserved6;
  JZ_REG PXSEL;                 /* Select Register */
  JZ_REG PXSELS;                /* Select Set Register */
  JZ_REG PXSELC;                /* Select Clear Register */
  JZ_REG Reserved7;
  JZ_REG PXDIR;                 /* Direction Register */
  JZ_REG PXDIRS;                /* Direction Set Register */
  JZ_REG PXDIRC;                /* Direction Clear Register */
  JZ_REG Reserved8;
  JZ_REG PXTRG;                 /* Trigger Register */
  JZ_REG PXTRGS;                /* Trigger Set Register */
  JZ_REG PXTRGC;                /* Trigger Set Register */
  JZ_REG Reserved9;
  JZ_REG PXFLG;                 /* Port Flag Register */
  JZ_REG PXFLGC;                /* Port Flag clear Register */
} JZ_PIO, *PJZ_PIO;

void jz_gpio_as_output (JZ_PIO * pio, unsigned int o);

void jz_gpio_as_input (JZ_PIO * pio, unsigned int o);

void jz_gpio_set_pin (JZ_PIO * pio, unsigned int o);

void jz_gpio_clear_pin (JZ_PIO * pio, unsigned int o);

void jz_gpio_out (JZ_PIO * pio, unsigned int o, unsigned int val);

unsigned int jz_gpio_get_pin (JZ_PIO * pio, unsigned int o);

int jz_gpio_as_func (JZ_PIO * pio, unsigned int o, int func);

JZ_PIO *jz_gpio_map (int port);

#endif
