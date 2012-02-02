# Make definitions for OpenOCD

# $Id: openocd.mk 3484 2011-11-30 07:56:40Z svn $

OPENOCD		?= openocd
OPENOCDCFG	?= $(MCUDIR)/$(MCU).openocd
OPENOCDDEBUG	?= $(ARMSRC)/common/main.gdb
OPENOCDFLASH	?= $(MCUDIR)/$(MCU).flashocd
OPENOCDIF	?= olimex-jtag-tiny

.PHONY: startocd stopocd
.SUFFIXES: .debugocd .flashocd

# Debug with OpenOCD

.elf.debugocd:
	$(GDBGUI) $(GDB) $(GDBFLAGS) -x $(OPENOCDDEBUG) $<

# Program flash with OpenOCD

.bin.flashocd:
	$(MAKE) startocd
	$(OPENOCDFLASH) $< $(FLASHWRITEADDR) $(TEXTBASE)
	$(MAKE) stopocd

# Start OpenOCD

startocd:
	$(OPENOCD) -f interface/$(OPENOCDIF).cfg -f $(OPENOCDCFG) >debug.log 2>&1 &

# Stop OpenOCD

stopocd:
	skill `basename $(OPENOCD) .exe`
