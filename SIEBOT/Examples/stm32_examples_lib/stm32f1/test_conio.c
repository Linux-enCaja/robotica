/* Simple serial console I/O test program for the STM32F1 ARM MCU */

// $Id: test_conio.c 3537 2012-01-09 14:33:04Z svn $

static const char revision[] = "$Id: test_conio.c 3537 2012-01-09 14:33:04Z svn $";

#include <assert.h>
#include <cpu.h>
#include <stdio.h>
#include <string.h>

int main(void)
{
  int i;
  char buf[256];
  int x, y;

  cpu_init(DEFAULT_CPU_FREQ);

  serial_stdio(CONSOLE_PORT);

  puts("\033[H\033[2JSTM32F1 Console I/O Test (" __DATE__ " " __TIME__ ")\n");
  puts(revision);
  printf("\nCPU Freq:%ld Hz  Compiler:%s\n\n", CPUFREQ, __VERSION__);

// Test putch()

  for (i = 'A'; i < 'Z'; i++)
    putch(i);

  putch('\n');
  putch('\n');

// Test cputs()

  for (i = 0; i < 10; i++)
  {
    sprintf(buf, "The value of the variable i is currently, now, until the next iteration, %d\n", i);
    cputs(buf);
  }

// Test keypressed() and getch()

  cputs("\nPress ^C to continue: ");

  for (;;)
  {
    cputs("|\b/\b-\b\\\b");

    if (keypressed())
    {
      if (getch() == 3)
        break;
      else
        putch('.');
    }
  }

  putch('\n');
  putch('\n');

// Test cputs() and cgets()

  for (;;)
  {
    cputs("[cgets] Enter a string: ");
    cgets(buf, sizeof(buf));
    if (strlen(buf)) if (buf[strlen(buf)-1] == '\n') buf[strlen(buf)-1] = 0;
    if (!strcasecmp(buf, "next")) break;
    printf("[cgets] You entered %zu bytes, '%s'\n\n", strlen(buf), buf);
  }

// Test putchar()

  putchar('\n');

  for (i = 'a'; i < 'z'; i++)
    putchar(i);

  putchar('\n');
  putchar('\n');

// Test printf() and fgets()

  for (;;)
  {
    printf("[fgets] Enter a string: ");
    fflush(stdout);
    fgets(buf, sizeof(buf), stdin);
    if (strlen(buf)) if (buf[strlen(buf)-1] == '\n') buf[strlen(buf)-1] = 0;
    if (!strcasecmp(buf, "next")) break;
    printf("[fgets] You entered %zu bytes, '%s'\n\n", strlen(buf), buf);
  }

  putchar('\n');

// Test scanf()

  for (;;)
  {
    printf("Enter two numbers: ");
    fflush(stdout);

    fflush(stdin);
    scanf("%d %d", &x, &y);
    printf("You entered %d and %d\n", x, y);

    if ((x == 0) && (y == 0)) break;
  }

  assert(FALSE);
}
