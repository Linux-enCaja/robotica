/*
 * JZ47xx GPIO lines
 *
 * Written 2010 by Andres Calderon andres.calderon@emqbit.com
 */

#ifndef __jz47xx_mmap_h__
#define __jz47xx_mmap_h__

#include <sys/mman.h>

#define FPGA_SIZE  (1 << 15)

void *jz_mmap (off_t address);
void *jz_fpga_map (off_t address);

#endif
