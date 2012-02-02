/******************************************************************************/
/*                                                                            */
/*                      Simple serial port I/O routines                       */
/*                                                                            */
/******************************************************************************/

// $Id: serial.h 3206 2011-10-19 13:12:40Z svn $

/* Initialize serial port */

int serial_open(char *name, unsigned int *subdevice);

/* Register serial port for standard I/O */

int serial_stdio(char *name);

/* Register a serial port device */

int serial_register(char *name);

/* Return TRUE if transmitter is ready to accept data */

int serial_txready(unsigned int port);

/* Write data to the serial port */

int serial_write(unsigned int port, char *buf, unsigned int count);

/* Return TRUE if receive data is available */

int serial_rxready(unsigned int port);

/* Read data from the serial port */

int serial_read(unsigned int port, char *buf, unsigned int count);
