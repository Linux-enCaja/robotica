#!/usr/bin/env python
"""Handle low-level device interface using USB Communications
Device Class driver. See the documentation for how to get
this driver working with SAM-BA."""

import os
import termios
import select

import samiam

def openDevice(options):
  try:
    # This O_NDELAY option is desirable but causes read errors with
    # "Resource temporarily unavailable".
    dev = os.open(options.DevicePort, os.O_RDWR | os.O_NOCTTY )#| os.O_NDELAY)
  except Exception, detail:
    raise samiam.CommandException, "Unable to open device '%s':\n  %s" % (options.DevicePort, str(detail))

  if options.Verbose:
    print 'Opened %s ...' % options.DevicePort

  try:
    exec 'baudmask = termios.B%d' % options.BaudRate
  except:
    raise samiam.CommandException, 'Unable to set baud rate to %d' % options.BaudRate

  try:
    # TCGETADDR returns a list:
    #   [iflag, oflag, cflag, lflag, ispeed, ospeed, cc]
    attr = termios.tcgetattr(dev)
    attr[0] = termios.IGNBRK # Leave termios.IGNPAR unset so framing errors translate characters to \0
    attr[1] = 0
    attr[2] = termios.CS8|termios.CREAD|termios.CLOCAL|baudmask
    attr[3] = 0
    attr[4] = baudmask
    attr[5] = baudmask

    # By setting VMIN to 0 and VTIME to non-zero, a read will return when
    # either 1 character has been received or the time has elapsed. But this
    # doesn't seem to work, so we use poll() and that seems to work fine.
    # However, it seems to work now (the above lines are a bit old). Let's
    # see what happens (gosh, this stuff is unnecessarily complicated!)
    attr[6][termios.VMIN] = 0   # minimum characters to fulfill a read request
    attr[6][termios.VTIME] = int(round(options.Timeout/100))  # deciseconds to wait for reads
    termios.tcsetattr(dev, termios.TCSAFLUSH, attr)
  except:
    raise samiam.CommandException, 'Unable to set terminal attributes on device %s' % options.DevicePort

  if options.Verbose:
    print "Set terminal attributes on %s ..." % options.DevicePort

  poll = select.poll()
  poll.register(dev, select.POLLIN|select.POLLPRI) # Select succeeds when there is regular or urgent data to be read
  options.poll = poll
  options.dev = dev

def closeDevice(options):
  options.poll = None
  if options.dev:
    os.close(options.dev)
  options.dev = None
