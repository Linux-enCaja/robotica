#!/usr/bin/env python
"""This program communicates with the SAM-BA program on an Atmel AT91SAM7S
microcontroller. The AT91SAM7S processor must have SAM-BA enabled to run.  This
can be done by connecting the TST pin to VDDIO (JP5 on the AT91SAM764-EK
board), applying power (with PA0,PA1,PA2 high, which they will be if they're
allowed to float due to internal pullups), waiting 10 seconds, then removing
power and removing the jumper. SAM-BA will then install itself in FLASH and run
upon boot.

This program is licensed under the GNU General Public License (GPL) version 2
(June 1991) or later, available at <http://www.gnu.org/licenses/gpl.html>.

Andrew Sterian
Padnos College of Engineering & Computing
Grand Valley State University
<steriana@claymore.engineer.gvsu.edu>
http://claymore.engineer.gvsu.edu/~steriana

------------------------------------------------------------------------------

The SAM-BA communication protocol is described in the AT91SAM7S datasheet
from Atmel.
"""  

VERSION_MAJOR=0
VERSION_MINOR=3

ALLOW_DEBUG = False

class CommandException(Exception):
  pass

import sys
import os
from optparse import OptionParser

import shell
import device

_usage="""\
%prog [Options] [Command [, Command] ... ]

This program provides an interface to an Atmel AT91SAM7S microcontroller
running the SAM-BA program. For the latest version and on-line documentation,
see <http://claymore.engineer.gvsu.edu/~steriana/Software>.

Sam_I_Am is free software licensed under the GNU General Public License
(GPL). See http://www.fsf.org for details of this license.

Andrew Sterian <http://claymore.engineer.gvsu.edu/~steriana>
Padnos College of Engineering and Computing
Grand Valley State University"""

Default_DevicePort = "/dev/ttyUSB0"
Default_BaudRate   = 115200
Default_Timeout    = 500    # milliseconds

##############################################################################

if __name__ == "__main__":
  import warnings
  warnings.filterwarnings("ignore", ".*", FutureWarning, ".*", 0)

  parser = OptionParser(usage=_usage)

  # These options are not necessary since "open" allows specifying port, baud rate, and timeout
  #parser.add_option("-p", "--port", dest="DevicePort", \
  #                  help="Device port for communication (default: %s)" % Default_DevicePort, \
  #                  metavar="DEV", default=Default_DevicePort)
  #parser.add_option("-b", "--baud-rate", type="int", dest="BaudRate", help="Baud rate (default: %d)" % Default_BaudRate, \
  #                  metavar="BAUD", default=Default_BaudRate)
  #parser.add_option("-t", "--timeout", dest="Timeout", type="float", default=Default_Timeout, \
  #                  help="How long to wait for bootloader response (default: %g ms)" % Default_Timeout, metavar="MS")
  parser.add_option("-i", "--interactive", dest="Interactive", default=False, action="store_true", \
      help="Remain in interactive mode after command-line commands execute")
  parser.add_option("-x", "--rc-file", dest="RCFilename", default=None, help="Source commands in this file instead of .samiamrc", \
                    metavar="FILE")
  parser.add_option("-X", "--norc-file", dest="NoRCFile", default=False, action="store_true", help="Do not run any .samiamrc file")
  parser.add_option("-V", "--verbose", dest="Verbose", action="store_true", default=False, help="Print verbose progress reports")
  parser.add_option("--version", dest="Version", action="store_true", default=False, help="Display program version")
  if ALLOW_DEBUG:
    parser.add_option("-D", "--debug", dest="Debug", action="store_true", default=False, help="Debugging mode")
      
  (options, args) = parser.parse_args()

  options.DevicePort = Default_DevicePort
  options.BaudRate = Default_BaudRate
  options.Timeout = Default_Timeout

  if options.Version:
    print \
"""Sam_I_Am Version %d.%d
""" % (VERSION_MAJOR, VERSION_MINOR)
    sys.exit(0)

  if not ALLOW_DEBUG:
    options.Debug = False

  options.dev = None
  options.poll = None
  options.nointeractive = False
  options.ReturnCode = 0      # Assume success

  rcfid = None
  if not options.NoRCFile:
    if options.RCFilename is not None:
      try:
        rcfid = file(options.RCFilename, 'rt')
      except Exception, detail:
        print "Unable to open file '%s':\n  %s" % str(detail)
        sys.exit(1)
    else:
      try:
        rcfid = file('.samiamrc', 'rt')
      except Exception:
        try:
          rcfid = file(os.path.join(os.environ['HOME'], '.samiamrc'), 'rt')
        except Exception:
          pass

  try:
    if len(args) > 0:
       # Set the nointeractive flag unless user specifically requested -i
       options.nointeractive = not options.Interactive

    retval = shell.run(options, args, rcfid)
  finally:
    device.closeDevice(options)

  sys.exit(options.ReturnCode)
