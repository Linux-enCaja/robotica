# Make definitions for lpc21isp

# $Id: lpc21isp.mk 3480 2011-11-29 19:40:52Z svn $

LPC21ISP	?= lpc21isp
LPC21ISPDEV	?= /dev/ttyS0
LPC21ISPBAUD	?= 115200
LPC21ISPCLOCK	?= 12000
LPC21ISPFLAGS	?= -control

.SUFFIXES: .flashisp

# Program flash with lpc21isp

.hex.flashisp:
	$(LPC21ISP) $(LPC21ISPFLAGS) $< $(LPC21ISPDEV) $(LPC21ISPBAUD) $(LPC21ISPCLOCK)
