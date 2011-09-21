#!/usr/bin/env python
"Command-line interpreter"

import sys
import os
import shlex
import readline
import string
import select

import samiam
from cmd import Cmd
from parse import *
import sambaif
import device
import ihex
import geah
import showparm
import setparm
import info
import flash

def enquote(args):
  """Take a list of strings and use \-escapes to protect quotes, spaces, and \ characters"""
  for ix in range(len(args)):
    arg = string.replace(args[ix], '\\', r'\\') # Replace \ characters
    arg = string.replace(arg, "'", r"\'")       # Replace ' characters
    arg = string.replace(arg, '"', r'\"')       # Replace " characters
    arg = string.replace(arg, ' ', r'\ ')       # Replace blank characters
    args[ix] = arg

class SamCmd(Cmd):
  def __init__(self, options, args=None, rcfid=None):
    Cmd.__init__(self)
    self.options = options
    self.read_allowed_list  = []
    self.ramwrite_allowed_list = []
    self.flashwrite_allowed_list = []
    self.exec_allowed_list  = []
    self.nointeractive = options.nointeractive
    self.startaddress = -1
    
    if rcfid is not None:
      self.source(rcfid)

    if args is not None:
      enquote(args)

      # Multiple commands can be split using commas
      while 1:
        try:
          ix = args.index(',')
        except ValueError:
          break
        self.cmdqueue.append(string.join(args[:ix], ' '))
        args = args[ix+1:]
      if len(args):            
        self.cmdqueue.append(string.join(args, ' '))

  ########### Memory access validators
  def validateRead(self, address, bytes):
    uaddress = address+bytes-1

    # No read-allowed-list means we allow all reads
    if self.read_allowed_list:
      for lower,upper in self.read_allowed_list:
        if (address >= lower) and (uaddress <= upper):
          break
      else:
        raise samiam.CommandException, \
"""Memory read is not allowed in this address range. Use 'set readallow'
to set allowable memory ranges for reading data."""

  def validateRAMWrite(self, address, bytes):
    uaddress = address+bytes-1

    # No write-allowed-list means we allow all writes
    if self.ramwrite_allowed_list:
      for lower,upper in self.ramwrite_allowed_list:
        if (address >= lower) and (uaddress <= upper):
          break
      else:
        raise samiam.CommandException, \
"""RAM memory write is not allowed in this address range. Use 'set ramwriteallow'
to set allowable memory ranges for writing data to RAM."""

  def validateFLASHWrite(self, address, bytes):
    uaddress = address+bytes-1

    # No write-allowed-list means we allow all writes
    if self.flashwrite_allowed_list:
      for lower,upper in self.flashwrite_allowed_list:
        if (address >= lower) and (uaddress <= upper):
          break
      else:
        raise samiam.CommandException, \
"""FLASH memory write is not allowed in this address range. Use 'set flashwriteallow'
to set allowable memory ranges for writing data to FLASH."""

  def validateExec(self, address):
    # No exec-allowed-list means we allow execution at all addresses
    if self.exec_allowed_list:
      for lower,upper in self.exec_allowed_list:
        if (address >= lower) and (address <= upper):
          break
      else:
        raise samiam.CommandException, \
"""Executing code is not allowed in this address range. Use 'set execallow'
to set allowable memory ranges for executing code."""

  ########### Override built-in Cmd methods

  # If this method doesn't exist, default behavior is to re-execute previous line.
  def emptyline(self):
    geah.nextLine()

  def precmd(self, args):
    """Populate self.fields with tokenized input"""
    lex = shlex.shlex(args, infile=None, posix=True)
    lex.whitespace_split = True
    self.fields = []
    while 1:
      token = lex.get_token()
      if token is None:
        break
      self.fields.append(token)
    #self.fields = shlex.split(args, comments=True)
    #print self.fields
    return args

  def postcmd(self, stop, args):
    if self.nointeractive:
      if not self.success:
        self.options.ReturnCode |= 1

    return stop

  ########### New built-in methods
  def source(self, fid):
    self.filestack.append(self.currfid)
    self.currfid = fid

  ########### SHELL
  def do_shell(self, args):
    args = args.strip()
    if not args:
      try:
        args = os.environ['SHELL']
      except:
        args = '/bin/bash'
    os.system(args)
    return False

  def help_shell(self):
    print \
"""shell command [arg [arg ...]]]
! command [arg [arg ...]]
shell
!

Execute commands in an operating system shell. You can provide a command and
parameters or just type 'shell' or '!' to start an interactive shell.  The
SHELL environment variable is used to determine which shell to run. If this
variable doesn't exist, /bin/bash is invoked.
"""

  ########### QUIT/EXIT
  def do_quit(self, args):
    return True

  def help_quit(self):
    print "Type 'quit', 'exit', or press Ctrl-D to exit the program"

  def do_exit(self, args):
    return True

  def help_exit(self):
    print "Type 'quit', 'exit', or press Ctrl-D to exit the program"

  ########### version
  def do_version(self, args):
    parseFields(self.fields[1:], (), 0)
    print sambaif.doVersion(self.options)
    return False

  def help_version(self):
    print \
"""version

Display the SAM-BA version. Use 'Version' to print the Sam_I_Am program version.
"""

  ########### Version
  def do_Version(self, args):
    parseFields(self.fields[1:], (), 0)
    print 'Sam_I_Am Version %d.%d' % (samiam.VERSION_MAJOR, samiam.VERSION_MINOR)
    return False

  def help_Version(self):
    print \
"""Version

Print the Sam_I_Am program version. Use 'version' to print the SAM-BA version.
"""

  ########### OPEN
  def do_open(self, args):
    fields = parseFields(self.fields[1:], (
          ( (pFileExists,), 'devname', 'Device filename to connect to' ),
          ( (pIntDefaultDec,), 'baudrate', 'Baud rate for communication' ),
          ( (pIntDefaultDec,), 'timeout', 'SAM-BA response timeout (milliseconds)' ),
                                ), 0)
    if fields[0]:
      self.options.DevicePort = fields[0]
    if fields[1]:
      self.options.BaudRate = fields[1]
    if fields[2]:
      self.options.Timeout = fields[2]

    device.closeDevice(self.options)
    device.openDevice(self.options)
    return False

  def help_open(self):
    import termios
    print \
"""open [/dev/device/to/open [BaudRate [Timeout]]]

Connect to a microcontroller running SAM-BA over USB. The device name, baud
rate, and communication timeout (in milliseconds) are optional parameters.
Without any parameters, the command is equivalent to:

    open %s %d %d
""" % (self.options.DevicePort, self.options.BaudRate, self.options.Timeout)
    rates = [rate for rate in dir(termios) if rate[0]=='B']
    validrates = []
    for rate in rates:
      try:
        val = int(rate[1:])
      except:
        val = 0

      if val:
        validrates.append(val)
    validrates.sort()

    print "Valid baud rates are:"
    count = 0
    for rate in validrates:
      print "%8d" % rate,
      count += 1
      if count==5:
        print
        count=0
    print

  ########### CLOSE
  def do_close(self, args):
    parseFields(self.fields[1:], (), 0)
    if self.options.dev:
      device.closeDevice(self.options)
    else:
      raise samiam.CommandException, "No device is currently open."

    return False

  def help_close(self):
    print \
"""close

Close the currently active connection to a device port.
"""

  ########### READB
  def do_readb(self, args):
    fields = parseFields(self.fields[1:], (
          ( (pIntDefaultHex,), 'address', 'Address to read' ),
                                ), 1)
    self.validateRead(fields[0], 1)
    print sambaif.doReadByte(self.options, fields)
    return False

  def help_readb(self):
    print \
"""readb address

Read a single byte from the given address.
"""

  ########### READH
  def do_readh(self, args):
    fields = parseFields(self.fields[1:], (
          ( (pIntDefaultHex,(pAligned,2)), 'address', 'Address to read (halfword-aligned)' ),
                                ), 1)
    self.validateRead(fields[0], 2)
    print sambaif.doReadHalfword(self.options, fields)
    return False

  def help_readh(self):
    print \
"""readh address

Read a word from the given address. The address must be halfword-aligned.
"""

  ########### READW
  def do_readw(self, args):
    fields = parseFields(self.fields[1:], (
          ( (pIntDefaultHex,(pAligned,4)), 'address', 'Address to read (word-aligned)' ),
                                ), 1)
    self.validateRead(fields[0], 4)
    print sambaif.doReadWord(self.options, fields)
    return False

  def help_readw(self):
    print \
"""readw address

Read a word from the given address. The address must be word-aligned.
"""

  ########### WRITEB
  def do_writeb(self, args):
    fields = parseFields(self.fields[1:], (
          ( (pIntDefaultHex,), 'address', 'Address to write' ),
          ( (pIntDefaultHex,(pIntMaxBits,8)), 'byte', 'Byte to write'),
                                ), 2)
    self.validateRAMWrite(fields[0], 1)
    print sambaif.doWriteByte(self.options, fields)
    return False

  def help_writeb(self):
    print \
"""writeb address data

Write a single byte to the given address in RAM.
"""

  ########### WRITEH
  def do_writeh(self, args):
    fields = parseFields(self.fields[1:], (
          ( (pIntDefaultHex,), 'address', 'Address to write' ),
          ( (pIntDefaultHex,(pIntMaxBits,16)), 'halfword', 'Halfword to write'),
                                ), 2)
    self.validateRAMWrite(fields[0], 2)
    print sambaif.doWriteHalfword(self.options, fields)
    return False

  def help_writeh(self):
    print \
"""writeh address data

Write a halfword to the given address in RAM. The address must be
halfword-aligned.
"""

  ########### WRITEW
  def do_writew(self, args):
    fields = parseFields(self.fields[1:], (
          ( (pIntDefaultHex,), 'address', 'Address to write' ),
          ( (pIntDefaultHex,(pIntMaxBits,32)), 'word', 'Word to write'),
                                ), 2)
    self.validateRAMWrite(fields[0], 4)
    print sambaif.doWriteWord(self.options, fields)
    return False

  def help_writew(self):
    print \
"""writew address data

Write a word to the given address in RAM. The address must be word-aligned.
"""

  ########### GO
  def do_go(self, args):
    fields = parseFields(self.fields[1:], (
          ( (pIntDefaultHex,(pAligned,4)), 'address', 'Address to jump to (word-aligned)' ),
                                ), 0)
    addr = fields[0]
    if addr is None:
      if self.startaddress >= 0:
        addr = self.startaddress
      else:
        raise samiam.CommandException, \
"""No known start address. Specify an address in this command or SEND/FLASH a
hex file which specifies a start address."""
        
    self.validateExec(addr) 
    sambaif.doGo(self.options, [addr])

    # The GO command in SAM-BA causes SAM-BA to start over at main() once the
    # user's function returns. Thus there will be no '>' displayed. It also
    # outputs '\n\r' prior to executing the GO.
    return False

  def help_go(self):
    print \
"""go [address]

Begin execution at the given address. The address must be word-aligned. If no
address is specified, the last starting address specified in a HEX file
(using FLASH or SEND) is used.
"""

  ########### TGO
  def do_tgo(self, args):
    fields = parseFields(self.fields[1:], (
          ( (pIntDefaultHex,(pAligned,2)), 'address', 'Address to jump to (halfword-aligned)' ),
                                ), 0)
    addr = fields[0]
    if addr is None:
      if self.startaddress >= 0:
        addr = self.startaddress
      else:
        raise samiam.CommandException, \
"""No known start address. Specify an address in this command or SEND/FLASH a
hex file which specifies a start address."""
        
    self.validateExec(addr) 
    sambaif.doGo(self.options, [addr|1])

    # The GO command in SAM-BA causes SAM-BA to start over at main() once the
    # user's function returns. Thus there will be no '>' displayed. It also
    # outputs '\n\r' prior to executing the GO.
    return False

  def help_tgo(self):
    print \
"""tgo [address]

Begin Thumb-mode execution at the given address. The address must be
halfword-aligned. If no address is specified, the last starting address
specified in a HEX file (using FLASH or SEND) is used.
"""

  ########### RECV
  def do_recv(self, args):
    fields = parseFields(self.fields[1:], (
          ( (), 'filename', 'Filename to receive downloaded data' ),
          ( (pIntDefaultHex,), 'address', 'Address to read from' ),
          ( (pIntDefaultHex,), 'bytes', 'Number of bytes to read' ),
                                ), 3)
    self.validateRead(fields[1], fields[2])
    sambaif.doReceive(self.options, fields)                                
    return False

  def help_recv(self):
    print \
"""recv file.hex StartAddr NumBytes

Download NumBytes bytes starting at address StartAddr into the given
file. The file will be in Intel HEX format.
"""

  ########### SEND
  def do_send(self,args):
    fields = parseFields(self.fields[1:], (
          ( (pFileExists,), 'filename', 'Intel HEX file to upload' ),
                                ), 1)
    datalines, startaddr = ihex.readHEX(fields[0])
    for addr,bytes in datalines:
      print "0x%08X-0x%08X: %d bytes" % (addr, addr+len(bytes)-1, len(bytes))
      self.validateRAMWrite(addr, len(bytes))
    print "Start Address: %s" % hex(startaddr)
    self.startaddress = startaddr

    sambaif.doSend(self.options, datalines)

    return False

  def help_send(self):
    print \
"""send file.hex

Upload the given file (Intel HEX format) to RAM. This command cannot be used
to program FLASH (use the 'flash' command to do so).

The start address indicated in the HEX file is saved. If a subsequent GO
command is issued without an explicit target address, the saved start
address from the last SEND or FLASH command is used.
"""

  ########### FLASH
  def do_flash(self,args):
    fields = parseFields(self.fields[1:], (
          ( (pFileExists,), 'filename', 'Intel HEX file to upload' ),
                                ), 1)
    datalines, startaddr = ihex.readHEX(fields[0])
    for addr,bytes in datalines:
      print "0x%08X-0x%08X: %d bytes" % (addr, addr+len(bytes)-1, len(bytes))
      self.validateFLASHWrite(addr, len(bytes))
    print "Start Address: %s" % hex(startaddr)
    self.startaddress = startaddr

    flash.program(self, datalines)

    return False

  def help_flash(self):
    print \
"""flash file.hex

Program FLASH with the given file (Intel HEX format). This command cannot be
used to write to RAM (use the 'send' command to do so).

The start address indicated in the HEX file is saved. If a subsequent GO
command is issued without an explicit target address, the saved start address
from the last SEND or FLASH command is used.

This command uploads a small program into RAM at address 0x202000 so whatever
is already there will be overwritten.
"""

  ########### SHOW
  def do_show(self, args):
    fields = parseFields(self.fields[1:], (
          ( (), 'parameter', 'Parameter to display' ),
                                ), 0)
    showparm.show(self, fields[0])                                
    return False

  def help_show(self):
    print \
"""show [parameter]

Display the value of a program parameter. With no argument, all parameters are
shown.
"""

  ########### SET
  def do_set(self, args):
    setparm.set(self, self.fields[1:])
    return False

  def help_set(self):
    print \
"""set parameter args

Set the value of a program parameter. Type 'show' to display a list of
all program parameters and their values.
"""

  ########### INFO
  def do_info(self, args):
    fields = parseFields(self.fields[1:], (
          ( (), 'parameter', 'Parameter to display' ),
                                ), 0)
    info.info(self, fields[0])
    return False

  def help_info(self):
    print \
"""info parm

Display information about the microcontroller device. Type 'info' to
display a list of all available parameters.
"""

  ########### DUMP
  def do_dump(self, args):
    fields = parseFields(self.fields[1:], (
          ( (pIntDefaultHex,), 'address', 'Address to read' ),
          ( (pIntDefaultHex,), 'bytes', 'Number of bytes to display'),
                                ), 1)
    bytes = fields[1]
    if bytes is None or bytes == 0:
      bytes = 128
    bytes = (bytes + 3) & ~3  # Round up to 4-byte boundary
    self.validateRead(fields[0], bytes)
    
    data = sambaif.doReceiveRaw(self.options, fields[0], bytes)
    data = string.join(data,'')

    ix = 0
    addr = fields[0]
    printables = string.digits+string.letters+string.punctuation+' '
    while ix < len(data):
      if (ix & 0xF) == 0:
        print '%08X:' % addr,
        needcrlf = True
      val = ord(data[ix]) | ord(data[ix+1])<<8 | ord(data[ix+2])<<16 | ord(data[ix+3])<<24
      print '%08X' % val,
      ix += 4
      addr += 4
      if ((ix & 0xF) == 0):
        print '| ',
        for cix in range(ix-16,ix):
          if data[cix] in printables:
            sys.stdout.write(data[cix])
          else:
            sys.stdout.write('.')
        print
        needcrlf = False

    if needcrlf:
      print
    return False

  def help_dump(self):
    print \
"""dump Address [Bytes]

Perform a memory dump starting at the given address for some number of bytes.
If not specified, 128 bytes are displayed.
"""

  ########### SOURCE
  def do_source(self,args):
    fields = parseFields(self.fields[1:], (
          ( (pFileExists,), 'filename', 'Script file to execute' ),
                                ), 1)
    try:                                
      fid = file(fields[0], 'rt')
    except Exception, detail:
      raise samiam.CommandException, 'Unable to open script file:\n  %s' % str(detail)

    self.source(fid)

    #print "Sourced", fields[0]
    #print self.filestack
    #print self.currfid
    return False

  def help_source(self):
    print \
"""source filename

Execute the commands in the given file as if they had been typed
at the command line.
"""

  def do_echo(self, args):
    print args
    return False

  def help_echo(self):
    print \
"""echo [args ...]

Display any arguments back to the user. This command does nothing
useful but can be used for debugging purposes.
"""

  def do_disp(self, args):
    parseFields(self.fields[1:], (), 0)

    print sambaif.readResult(self.options, stopat=None, expectstopat=False)
    return False

  def help_disp(self):
    print \
"""disp

Display any characters previously sent by SAM-BA (or any other running program)
to the screen. This command is most useful for occasionally displaying the
output of user-written programs as SAM-BA does not send any characters except
in response to commands.

The Timeout interval specified in the last 'open' command is used to tell
Sam_I_Am how long to wait for characters. Once this amount of time (specified
in milliseconds) has gone by after the last character is received, Sam_I_Am
displays all characters read so far and the 'disp' command is complete.
"""

def run(options, args, rcfid=None):
  c = SamCmd(options, args, rcfid)
  c.prompt = '>'
  c.use_rawinput = True
  c.cmdloop()

if __name__=="__main__":
  class O:
    def __init__(self):
      self.ReturnCode=0
  options = O()
  run(options, sys.argv[1:])
  sys.exit(options.ReturnCode)
