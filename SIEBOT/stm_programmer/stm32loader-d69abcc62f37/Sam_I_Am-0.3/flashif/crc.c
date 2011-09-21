/* 
 * Copyright (C) 1995 Advanced RISC Machines Limited. All rights reserved.
 * 
 * This software may be freely used, copied, modified, and distributed
 * provided that the above copyright notice is preserved in all copies of the
 * software.
 */

/* -*-C-*-
 *
 * $Revision: 1.2 $
 *     $Date: 1998/01/08 11:11:45 $
 *
 *
 * crc.c - provides some "standard" CRC calculation routines.
 *
 * Modified 06/09/06: Andrew Sterian
 * Left only code for CRC16 for ARM.
 */
#include "crc.h"    /* describes this code */

/*
 * crc16                                                     16bit CRC-CCITT
 * -----                                                     ---------------
 * This function provides a table driven 16bit CRC generation for byte data.
 * This CRC is also known as the HDLC CRC.
 */
/*
 * 960201 KWelton
 *
 *TODO: Is this correct?  The compiler predefines __arm, *not* __ARM
 */

/*
 * To make the code quicker on the ARM, we double the table size and
 * use integer slots rather than short slots for the table.
 */
static const unsigned int crctableA[16] = {
                                             0x0000,
                                             0x1081,
                                             0x2102,
                                             0x3183,
                                             0x4204,
                                             0x5285,
                                             0x6306,
                                             0x7387,
                                             0x8408,
                                             0x9489,
                                             0xA50A,
                                             0xB58B,
                                             0xC60C,
                                             0xD68D,
                                             0xE70E,
                                             0xF78F
                                            };

static const unsigned int crctableB[16] = {
                                             0x0000,
                                             0x1189,
                                             0x2312,
                                             0x329B,
                                             0x4624,
                                             0x57AD,
                                             0x6536,
                                             0x74BF,
                                             0x8C48,
                                             0x9DC1,
                                             0xAF5A,
                                             0xBED3,
                                             0xCA6C,
                                             0xDBE5,
                                             0xE97E,
                                             0xF8F7
                                            };

unsigned short crc16(unsigned char *address, unsigned int size,
                     unsigned short crc)
{
  for (; (size > 0); size--)
  {
    /* byte loop */
    unsigned char data = *address++; /* fetch the next data byte */

    data ^= crc; /* EOR data with current CRC value */
    crc = ((crctableA[(data & 0xF0) >> 4] ^ crctableB[data & 0x0F]) ^
           (crc >> 8));
  }

  return(crc);
}

#ifdef TESTING_CRC
#include <stdlib.h>
#include <stdio.h>

int main(int argc, char *argv[])
{
  unsigned short crc = startCRC16;
  unsigned char buf[2];
  unsigned i;

  for (i=1; i < argc; i++) {
    unsigned char val = (unsigned char) strtoul(argv[i], 0, 16);
    crc = crc16(&val, 1, crc);
  }
#if 0
  buf[0] = (crc & 0x00FF);
  buf[1] = (crc>>8) & 0x00FF;
  crc = crc16(buf, 2, crc);
#endif
  printf("%04X\n", crc);

  return 0;
}
#endif
