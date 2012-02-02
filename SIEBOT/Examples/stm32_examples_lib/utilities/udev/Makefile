# Makefile for installing udev rules for ARM microcontroller programmers

# $Id: Makefile 3251 2011-11-04 10:57:10Z svn $

UDEVRULESDIR	= /etc/udev/rules.d
LIBEXECDIR	= /usr/local/libexec

install:
	for F in *.rules ; do install -cm 0444 $$F $(UDEVRULESDIR) ; done
	for F in *.helper ; do install -cm 0444 $$F $(LIBEXECDIR) ; done

uninstall:
	for F in *.rules ; do rm $(UDEVRULESDIR)/$$F ; done
	for F in *.helper ; do rm $(LIBEXECDIR)/$$F ; done
