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
 *     $Date: 1998/01/08 11:11:47 $
 *
 *
 * crc.h - describes some "standard" CRC calculation routines.
 *
 * Modified 06/09/06: Andrew Sterian
 * Left only code for CRC16 for ARM.
 */
#ifndef _crc_h
#define _crc_h

/*
 * manifests
 */

/*
 * When using "crc32" or "crc16" these initial CRC values must be given to
 * the respective function the first time it is called. The function can
 * then be called with the return value from the last call of the function
 * to generate a running CRC over multiple data blocks.
 * When the last data block has been processed using the "crc32" algorithm
 * the CRC value should be inverted to produce the final CRC value:
 * e.g. CRC = ~CRC
 */

#define startCRC16  (0x1D0F)        /* CRC initialised to all 0s */
                                    /* ADS: Modified from 0x0000 */


/**********************************************************************/

/*
 *
 *  Function: crc16
 *   Purpose: Generates a table driven 16-bit CRC-CCITT for byte data
 *
 *    Params:
 *       Input: address     pointer to the byte data
 *              size        number of bytes of data to be processed
 *              crc         initial CRC value to be used (can be the output
 *                          from a previous call to this function).
 *
 *   Returns:
 *          OK: 16-bit CRC value for the specified data
 */
extern unsigned short crc16(unsigned char *address, unsigned int size,
                            unsigned short crc);

/**********************************************************************/

#endif
