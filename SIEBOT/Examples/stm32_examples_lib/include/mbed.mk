# Make definitions for mbed

# $Id: mbed.mk 3485 2011-11-30 08:46:40Z svn $

# mbed firmware directory

MBEDDIR		?= /media/MBED

.SUFFIXES: .flashmbed

# Install firmware to mbed firmware directory

.bin.flashmbed:
	test -d $(MBEDDIR) -a -w $(MBEDDIR)
	cp $< $(MBEDDIR)/firmware.bin
	sync
	@echo -e "\nPress RESET on the target board to start $<\n"
