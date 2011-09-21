#define IOLOC volatile unsigned int *
#define PIO_BASE  0xFFFFF400U
static IOLOC const PIO_PER = (IOLOC)(PIO_BASE + 0x0000);
static IOLOC const PIO_PDR = (IOLOC)(PIO_BASE + 0x0004);
static IOLOC const PIO_OER = (IOLOC)(PIO_BASE + 0x0010);
static IOLOC const PIO_ODR = (IOLOC)(PIO_BASE + 0x0014);
static IOLOC const PIO_SODR = (IOLOC)(PIO_BASE + 0x0030);
static IOLOC const PIO_CODR = (IOLOC)(PIO_BASE + 0x0034);

static void delay(void)
{
  volatile unsigned count;

  for (count=0; count < 200000; count++) /* NULL */ ;
}

void _start(void)
{
  unsigned i;

  *PIO_PER = 1;
  *PIO_OER = 1;

  for (i=0; i < 5; i++) {
    *PIO_CODR = 1;
    delay();
    *PIO_SODR = 1;
    delay();
  }

  *PIO_ODR = 1;
}
