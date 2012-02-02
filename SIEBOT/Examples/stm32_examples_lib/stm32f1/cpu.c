/* Initialize CPU core */

// $Id: cpu.c 3315 2011-11-16 15:08:01Z svn $

static const char revision[] = "$Id: cpu.c 3315 2011-11-16 15:08:01Z svn $";

#include <cpu.h>

void cpu_init(unsigned long int frequency)
{
  __use_custom_syscalls();

  SystemInit();
  SystemCoreClockUpdate();
}
