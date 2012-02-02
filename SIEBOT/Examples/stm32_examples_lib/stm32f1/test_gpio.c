/* Simple bit twiddler test program */

// $Id: test_gpio.c 3424 2011-11-28 10:20:11Z svn $

static const char revision[] = "$Id: test_gpio.c 3424 2011-11-28 10:20:11Z svn $";

#include <cpu.h>

int main(void)
{
  unsigned long int i;

  cpu_init(DEFAULT_CPU_FREQ);

//  gpiopin_configure(GPIOPIN0, GPIOPIN_INPUT);
//  gpiopin_configure(GPIOPIN38, GPIOPIN_OUTPUT);
  gpiopin_configure(GPIOPIN50, GPIOPIN_OUTPUT);
//  gpiopin_configure(GPIOPIN45, GPIOPIN_INPUT);

  for (i = 0;; i++)
  {
    // Flash flaster if WAKE-UP button is pressed

      GPIOPIN50OUT = i >> 19;
  }
}
