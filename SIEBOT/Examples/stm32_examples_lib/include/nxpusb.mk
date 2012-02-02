# Make definitions for NXP USB boot loader

# $Id: nxpusb.mk 3465 2011-11-29 08:30:31Z svn $

# NXP USB boot loader firmware directory

NXPUSBDIR	?= /media/LPC17xx

.SUFFIXES: .flashnxp

# Install firmware to NXP USB boot loader firmware directory

.bin.flashnxp:
	test -d $(NXPUSBDIR) -a -w $(NXPUSBDIR)
	cp $< $(NXPUSBDIR)/firmware.bin
	sync
	@echo -e "\nPress RESET on the target board to start $<\n"
