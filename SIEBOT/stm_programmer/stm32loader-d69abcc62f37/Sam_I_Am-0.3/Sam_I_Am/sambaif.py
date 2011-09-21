#!/usr/bin/env python
"""Low-level driver interface"""

import os
import termios

import samiam
import ihex

def readResult(options, stopat='>', expectstopat=True):
  """Collect all data sent by SAM-BA until a '>' character is encountered."""
  s = ""
  while 1:
    L = options.poll.poll(options.Timeout)
    if L:
      while 1:
        c = os.read(options.dev, 1)
        if len(c)==0:
          break
        if (stopat is not None) and (c==stopat):
          return s
        s += c
    else:
      if expectstopat:
        raise samiam.CommandException, "SAM-BA not responding"
      else:
        return s

def checkDevOpen(options):
  if not options.dev:
    raise samiam.CommandException, "No device open. Use the 'open' command to connect to a device."

def doVersion(options):
  checkDevOpen(options)
  os.write(options.dev, "V#")
  return readResult(options)
    
def doReadByte(options, param):
  checkDevOpen(options)
  os.write(options.dev, "o%x,#" % param[0])
  return readResult(options)

def doReadHalfword(options, param):
  checkDevOpen(options)
  os.write(options.dev, "h%x,#" % param[0])
  return readResult(options)

def doReadWord(options, param):
  checkDevOpen(options)
  os.write(options.dev, "w%x,#" % param[0])
  return readResult(options)

def doWriteByte(options, param):
  checkDevOpen(options)
  os.write(options.dev, "O%x,%x#" % tuple(param))
  return readResult(options)

def doWriteHalfword(options, param):
  checkDevOpen(options)
  os.write(options.dev, "H%x,%x#" % tuple(param))
  return readResult(options)

def doWriteWord(options, param):
  checkDevOpen(options)
  os.write(options.dev, "W%x,%x#" % tuple(param))
  return readResult(options)

def doGo(options, param):
  checkDevOpen(options)
  os.write(options.dev, "G%x#" % tuple(param))

  # This tcdrain() seems to be necessary on some machines when the 'go'
  # command is the last one on the command line. It seems that the command
  # isn't fully sent by the time the program exits.
  termios.tcdrain(options.dev)

  return

def doSend(options, datalines):
  checkDevOpen(options)
  for addr,bytes in datalines:
    # The Sx,x# format is not documented properly in the Atmel datasheet
    # revision E (04-Apr-06). The number of bytes (after the comma) is
    # not a part of the command, according to the datasheet.
    os.write(options.dev, "S%x,%x#" % (addr,len(bytes)))
    os.write(options.dev, bytes)
    readResult(options)

def doReceiveRaw(options, addr, bytes):
  checkDevOpen(options)
  os.write(options.dev, "R%x,%x#" % (addr,bytes))
  bytesRemain = bytes+2   # SAM-BA begins by sending \n\r...we discard these later
  Data = []
  while bytesRemain:
    toread = min(bytesRemain, 128)

    devs = options.poll.poll(options.Timeout)
    if devs:
      c = os.read(options.dev, toread)
      Data.append(c)
      bytesRemain -= len(c)
    else:
      raise samiam.CommandException, "SAM-BA failed to send the last %d bytes" % bytesRemain

  s = readResult(options)
  if len(s):
    print '%d extra characters received (not saved)' % len(s)

  # Eliminate the \n\r at the beginning
  eliminate = 2
  while eliminate > 0:
    if len(Data[0]) < eliminate:
      eliminate -= len(Data[0])
      del Data[0]
    else:
      Data[0] = Data[0][eliminate:]
      eliminate = 0

  return Data

def doReceive(options, param):
  """param is a 3-tuple: (filename, address, bytes)"""
  Data = doReceiveRaw(options, param[1], param[2])
  ihex.writeHexFile(param[0], param[1], Data)

