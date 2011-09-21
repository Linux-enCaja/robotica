/*
 * Support program for programming FLASH using Sam_I_Am. This program is loaded into
 * the microcontroller's RAM and communicates with Sam_I_Am using the USB peripheral
 * in order to write to FLASH.
 *
 * The communication protocol with Sam_I_Am is as follows:
 *
 * 1. Sam_I_Am sends commands over the USB port. Commands are described below.
 *
 * 2. Every command elicits a 2-byte response from this program. The defined
 *    responses are always ASCII characters and are described below. The first
 *    character in the 2-byte sequence is sent first.
 *
 *        OK - command completed successfully
 *        AB - this program has aborted completely since a SETUP transaction
 *             (or other event) occurred on endpoint 0 (the USB control
 *             endpoint). The current command, if any, cannot be assumed to have
 *             completed successfully and no further communication with this
 *             program should be attempted since it has terminated and returned
 *             control back to SAM-BA.
 *        BC - bad command: byte 0 of the command was unrecognized
 *        BF - bad command format: payload byte count is inappropriate for this command,
 *             address is invalid, etc.
 *        CE - CRC error: command unsuccessful since command CRC does not match.
 *        EX - too much data sent (i.e., data arrived beyond the end of the expected
 *             command length, which can happen if a command packet is sent without
 *             first waiting for an acknowledgment).
 *        LE - locking error violation when attempting to program FLASH
 *        PE - programming error when attempting to program FLASH
 *
 * 3. Commands are sent in packets. Each command packet comprises N payload bytes
 *    and 5 overhead bytes. The command packet has the following structure:
 *          Byte 0: command byte
 *          Byte 1: payload byte count LSB (N, the number of bytes that follow, not including CRC)
 *          Byte 2: payload byte count MSB
 *          Bytes 3 - N+2: payload bytes 
 *          Byte N+3: CRC LSB
 *          Byte N+4: CRC MSB
 *
 *    Each command packet ends with a 16-bit CRC computed over all command
 *    bytes (bytes 0 through N+2) and an initial CRC value of 0x1D0F. The
 *    computed CRC is always stored in the final 2 bytes of the command. This
 *    program computes a CRC over ALL bytes, including the CRC, and expects
 *    the result to be 0, which will be true if the above description of the
 *    CRC handling is followed.
 *
 *    Every command packet must be followed by an acknowledgment from this program.
 *    Command packets cannot be sent consecutively without waiting for 
 *    acknowledgment else an EX return code may be generated (Extra Data error).
 *
 * 4. Recognized commands
 *
 *    Write Data:
 *        This command stores the given data at the starting address and then
 *        executes a Write Page or Write Page And Lock command.
 *
 *        Byte 0:     0x01
 *        Byte 1:     payload bytes LSB
 *        Byte 2:     payload bytes MSB
 *        Byte 3:     write address LSB
 *        Byte 4:     write address next LSB
 *        Byte 5:     write address next LSB
 *        Byte 6:     write address MSB
 *        Byte 7:     page number LSB
 *        Byte 8:     page number MSB (2 bits only)
 *        Byte 9:     lock flag (1 if region should be locked after this page write)
 *        Bytes 10 - N*4+9: words to write, stored LSB-first (N is the number of WORDS)
 *        Byte N*4+10:     command CRC LSB
 *        Byte N*4+11:     command CRC MSB
 *
 *    Exit:
 *      This command returns control back to SAM-BA.
 *
 *        Byte 0:     0x02
 *        Byte 1:     payload bytes LSB
 *        Byte 2:     payload bytes MSB
 *        Byte 3:     CRC LSB
 *        Byte 4:     CRC MSB
 *
 *    None:
 *      This command does nothing. It is used to verify that this
 *      program is operational. The only effect is to generate an
 *      OK response.
 *        Byte 0:     0x03
 *        Byte 1:     payload bytes LSB
 *        Byte 2:     payload bytes MSB
 *        Byte 3:     CRC LSB
 *        Byte 4:     CRC MSB
 *
 *
 */

#include "crc.h"

#define USB_BASE 0xFFFB0000U
#define USB_LOC(x) ((volatile unsigned *)(USB_BASE|x))
#define UDP_ISR USB_LOC(0x1C)
#define UDP_ICR USB_LOC(0x20)
#define UDP_CSR_CTRL USB_LOC(0x30)
#define UDP_CSR_RX USB_LOC(0x34)
#define UDP_CSR_TX USB_LOC(0x38)
#define UDP_FDR_RX USB_LOC(0x54)
#define UDP_FDR_TX USB_LOC(0x58)

#define PIO_BASE  0xFFFFF400U
#define PIO_LOC(x) ((volatile unsigned *)(PIO_BASE|x))
#define PIO_PER PIO_LOC(0x0000)
#define PIO_PDR PIO_LOC(0x0004)
#define PIO_OER PIO_LOC(0x0010)
#define PIO_ODR PIO_LOC(0x0014)
#define PIO_SODR PIO_LOC(0x0030)
#define PIO_CODR PIO_LOC(0x0034)

#define MC_BASE  0xFFFFFF00U
#define MC_LOC(x) ((volatile unsigned *)(MC_BASE|x))
#define MC_FMR MC_LOC(0x60)
#define MC_FCR MC_LOC(0x64)
#define MC_FSR MC_LOC(0x68)

/* Bits in MC_FSR register */
#define FRDY (0x01)
#define LOCKE (0x04)
#define PROGE (0x08)

/* Bits in UDP_CSR register */
#define TXCOMP (0x01)
#define BANK0 (0x02)
#define RXSETUP (0x04)
#define TXPKTRDY (0x10)
#define BANK1 (0x40)

#ifdef TESTING
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

unsigned char simbuf[1024];
unsigned simbufix;
unsigned simbuflen;

#define min(x,y) ((x) < (y) ? (x) : (y))
#define max(x,y) ((x) > (y) ? (x) : (y))
#endif // TESTING

// Data from the Sam_I_Am host is stored in this buffer
unsigned char usbbuf[64];

union {                       // stores parameters as they come in
  unsigned char buf[4];
  unsigned short halfword[2];
  unsigned word;
} gParameter;
unsigned char gParamIx;         // Location of next address to write to in buf field of gParameter

unsigned char gCommand;         // Command to execute
unsigned gPayloadBytesRemain;   // Number of remaining payload bytes expected
unsigned gCRC;                  // Running CRC
unsigned gNextAddress;          // Next address to write to for Write Data
unsigned gPageNumber;           // Page number to write for Write Data
unsigned gDoPageLock;           // Non-zero to lock region after write

typedef enum {
  e_OK, e_AB, e_BC, e_BF, e_CE, e_EX, e_LE, e_PE
} responseCode_t;

typedef enum {
  s_Start, s_GetPayloadBytes, s_IgnorePayload, s_GetCRC, s_GetAddress,
  s_GetPageNumber, s_GetLockFlag, s_GetDataWord
} state_t;

static unsigned gDone;        // Set to 1 when we should return to SAM-BA
static state_t gState;        // Used in handleData() to decide what to do next
static responseCode_t gResponseCode;  // The code to send back to Sam_I_Am

#ifndef TESTING
static unsigned waitForFRDY(void)
{
  unsigned val;
  do {
    val = *MC_FSR;
  } while (! (val & FRDY));

  return val;
}
#endif

static void doPageWrite(void)
{
  unsigned fsr;
  unsigned command;

  command = (gDoPageLock ? 0x3 : 0x1) | ((gPageNumber&0x3FF) << 8) | 0x5A000000U;

#ifndef TESTING
  (void) waitForFRDY();
  *MC_FCR = command;

  /* I don't know whether LOCKE and PROGE are set at the same time as FRDY or after
   * FRDY is set, so to be safe, we take both values and OR them together. */
  fsr = waitForFRDY();
  fsr |= *MC_FSR;

  if (fsr & LOCKE) {
    gResponseCode = e_LE;
  } else if (fsr & PROGE) {
    gResponseCode = e_PE;
  }
#else
  printf("Writing %08X to MC_FCR\n", command);
#endif
}

static void writeusb(const unsigned char *buf, unsigned chars)
{
#ifndef TESTING
  unsigned i;

  while (*UDP_CSR_TX & TXPKTRDY) /* NULL */ ;

  for (i=0; i < chars; i++) {
    *UDP_FDR_TX = buf[i];
  }
  *UDP_CSR_TX |= TXPKTRDY;

  while (! (*UDP_CSR_TX & TXCOMP)) /* NULL */ ;
  *UDP_CSR_TX &= ~TXCOMP;
  while (*UDP_CSR_TX & TXCOMP) /* NULL */ ;
#else
  while (chars--) putchar(*buf++);
  putchar('\n');
#endif
}

static void replyUSB(responseCode_t response)
{
  const char *p = "OKABBCBFCEEXLEPE";
  writeusb(p + (int)response*2, 2);
}

static unsigned readusb(unsigned bank) 
{
#ifndef TESTING
  unsigned chars, i;

  while (! (*UDP_CSR_RX & bank)) {
    // If stuff happened on endpoint 0 (control endpoint), abort FLASH
    // programming and let SAM-BA handle the endpoint 0 event.
    if (*UDP_ISR & 1) {
      replyUSB(e_AB);
      gDone = 1;
      return 0;
    }
  }

  chars = ((*UDP_CSR_RX) >> 16) & 0x7FF;
  if (chars > sizeof(usbbuf)) chars=sizeof(usbbuf);
  for (i=0; i < chars; i++) {
    usbbuf[i] = *UDP_FDR_RX;
  }

  *UDP_CSR_RX &= ~bank;
#else
  unsigned chars;

  if (simbuflen == 0) {
    printf("Out of data\n");
    exit(0);
  }
  chars = max(random() & 63, 1);
  chars = min(chars, simbuflen);
  memcpy(usbbuf, simbuf+simbufix, chars);
  simbuflen -= chars;
  simbufix += chars;
#endif

  return chars;
}

static void handleData(unsigned chars)
{
  unsigned bufix;

  for (bufix=0; bufix < chars; ) {
    unsigned char c;

    c = usbbuf[bufix++];
    gCRC = crc16(&c, 1, gCRC);

    switch (gState) {
      case s_Start:     // Waiting for command
        gCommand = c;
        gState = s_GetPayloadBytes;
        gParamIx = 0;
        gResponseCode = e_OK;
        break;

      case s_GetPayloadBytes:     // Get payload byte count
        gParameter.buf[gParamIx++] = c;
        if (gParamIx == 2) {
          gPayloadBytesRemain = gParameter.halfword[0];

          // Validate parameters
          switch (gCommand) {
            case 1:   // Write data
              // Payload bytes must be of the form 4N+3 for N>=2
              if ((gPayloadBytesRemain < 11) || ((gPayloadBytesRemain-3) & 0x3)) {
                gResponseCode = e_BF;
                gState = s_IgnorePayload;
              } else {
                gState = s_GetAddress;
                gParamIx = 0;
              }
              break;

            case 2:   // Exit program
            case 3:   // No-op command
              if (gPayloadBytesRemain != 0) {
                gResponseCode = e_BF;
                gState = s_IgnorePayload;
              } else {
                gState = s_GetCRC;
                gParamIx = 0;
              }
              break;

            default:
              gResponseCode = e_BC;
              gState = s_IgnorePayload;
              break;
          }
        }
        break;

      case s_IgnorePayload:   // Ignore payload data
        if (--gPayloadBytesRemain == 0) {
          gState = s_GetCRC;     // Expect CRC
          gParamIx = 0;
        }
        break;

      case s_GetCRC:   // Expect CRC
        if (++gParamIx == 2) {
          if (gResponseCode == e_OK) {
            if (gCRC != 0) {
              gResponseCode = e_CE;
            } else if (bufix != chars) {
              gResponseCode = e_EX;
              bufix = chars;    // Ignore remaining buffer characters
            } else {
              switch (gCommand) {
                case 1:   // Write Data
                  doPageWrite();
                  break;
                case 2:   // Exit to SAM-BA
                  gDone = 1;
#ifdef TESTING
                  printf("Exit command\n");
#endif
                  break;
                case 3:   // Nothing
                  break;
              }
            }
          }
          replyUSB(gResponseCode);
          gState = s_Start;
          gCRC = startCRC16;
        }
        break;

      case s_GetAddress:      // Get 4-byte address field for Write Data
        gParameter.buf[gParamIx++] = c;
        if (gParamIx == 4) {
          gPayloadBytesRemain -= 4;
          gNextAddress = gParameter.word;
          gParamIx = 0;
          
          // Ensure address is word-aligned and within allowable FLASH range.
          // Also ensure that the amount of expected data does not cross a page
          // boundary. The number of remaining bytes is gPayloadBytesRemain
          // minus 3 since we still expect page number and lock flag. We don't
          // exactly know the page size so we assume it is the worst-case value
          // of 256.
          if ( ((gNextAddress & 0x03)==0) && (gNextAddress >= 0x100000) && (gNextAddress < 0x200000)
               && !((gNextAddress ^ (gNextAddress+(gPayloadBytesRemain-3)-1)) & 0xFFFFFF00U)) {
            gState = s_GetPageNumber;
          } else {
            gResponseCode = e_BF;
            gState = s_IgnorePayload;
          }
        }
        break;

      case s_GetPageNumber:   // Get 2-byte page number
        gParameter.buf[gParamIx++] = c;
        if (gParamIx == 2) {
          gPayloadBytesRemain -= 2;
          gPageNumber = gParameter.halfword[0];
          
          // Ensure page number fits in 10 bits
          if ( (gPageNumber <= 0x03FF) ) {
            gState = s_GetLockFlag;
          } else {
            gResponseCode = e_BF;
            gState = s_IgnorePayload;
          }
        }
        break;
        
      case s_GetLockFlag:
        gDoPageLock = c;
        gState = s_GetDataWord;
        gPayloadBytesRemain--;
        gParamIx = 0;
        break;

      case s_GetDataWord:
        gParameter.buf[gParamIx++] = c;
        if (gParamIx == 4) {
          gPayloadBytesRemain -= 4;
#ifndef TESTING
          *(volatile unsigned *)gNextAddress = gParameter.word;
#else
          printf("Writing data %08X to address %08X\n", gParameter.word, gNextAddress);
#endif
          gNextAddress += 4;
          gParamIx = 0;

          if (gPayloadBytesRemain == 0) {
            gState = s_GetCRC;
          }
        }
        break;
    }
  }
}

#ifndef TESTING
void _start(void)
#else
void start(void)
#endif
{
  unsigned bank=0, firstbank;
  unsigned chars;
  
#ifndef TESTING
  //*PIO_PER = 1;
  //*PIO_OER = 1;
  //*PIO_CODR = 1;

  // Wait for *any* data
  do {
    bank = (*UDP_CSR_RX) & (BANK0|BANK1);

    // If stuff happened on endpoint 0 (control endpoint), give up
    if (*UDP_ISR & 1) {
      replyUSB(e_AB);
      return;
    }
  } while (bank==0);
#endif

  // This is the bank that SAM-BA expects to return to
  firstbank = bank;

  gDone = 0;
  gState = 0;  // Awaiting command byte
  gCRC = startCRC16;

  while (! gDone) {
    chars = readusb(bank);

    if (bank & BANK0) {
      bank = BANK1;
      //*PIO_SODR = 1;
    } else {
      bank = BANK0;
      //*PIO_CODR = 1;
    }

    handleData(chars);
  }

  //*PIO_SODR = 1;

#ifndef TESTING
  if (bank != firstbank) {
    (void) readusb(bank);
  }
#endif
}

#ifdef TESTING
int main(void)
{
  const char data[] = { 0x01, 15, 0, 0xF8, 0x56, 0x14, 0x00, 0x34, 0x02, 1, 0x55, 0xAA, 0xFF, 0xEE, 0xAB, 0xCD, 0xEF, 0x00 } ;
  unsigned short crc;

  srandom(time(0));

  simbufix = 0;
  simbuflen = sizeof(data)+2;
  crc = crc16(data, sizeof(data), startCRC16);
  memcpy(simbuf, data, sizeof(data));
  memcpy(simbuf+sizeof(data), &crc, 2);

  start();

  return 0;
}
#endif
