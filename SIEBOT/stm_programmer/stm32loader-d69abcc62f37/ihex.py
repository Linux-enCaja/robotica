#!/usr/bin/env python
"""Support for reading and writing Intel HEX files"""

import array
import StringIO

# I don't want to see the warning that says that in Python 2.4, hex/oct
# constants greater than sys.maxint will be positive values. I'm only using
# these constants as bit masks.
import warnings
warnings.filterwarnings("ignore", "hex/oct constants", FutureWarning, ".*", 0)

#import samiam

def mergeData(datalines):  
  """Combine a list of array.array objects into larger arrays if they have
  contiguous addresses"""
  datalines.sort()  # by starting address
  
  currdata = array.array('B')  # zero-length
  startaddr = -1
  curraddr  = -1
  newlines = []

  for addr,data in datalines:
    if addr != curraddr:
      if len(currdata):
        newlines.append((startaddr,currdata))
      startaddr, currdata = addr, data
      curraddr = startaddr
    else:
      currdata.extend(data)

    curraddr += len(data)

  if len(currdata):
    newlines.append((startaddr,currdata))

  return newlines

####################### Read Intel HEX Files
HEXLAT = {}
for val in range(256):
  HEXLAT['%02X' % val] = val

def parse8(line, offset, HEXLAT=HEXLAT):
  return HEXLAT[line[offset:offset+2]]

def parse16(line, offset):
  return parse8(line, offset)*256 + parse8(line,offset+2)

def data2wordMSB(data):
  "Reconstruct a sequence of bytes into a single word, MSB first"
  result = 0
  for val in data:
    result <<= 8
    result += val

  return result

def readHEX(filename):
  """Read a HEX file, or interpret the StringIO object passed in if filename is not a string"""
  if isinstance(filename, StringIO.StringIO):
    fid = filename
  else:
    try:
      fid = file(filename, 'rt')
    except Exception, detail:
      raise samiam.CommandException, 'Unable to open HEX file:\n  %s' % str(detail)

  datalines = []
  linenum = 0
  addrprefix = 0
  startaddr = 0

  for line in fid:
    linenum += 1

    line = line.strip()
    if line[0] != ':':
      raise samiam.CommandException, "Line does not begin with ':' at file %s line #%d" % (filename, linenum)

    if len(line) < 11:
      raise samiam.CommandException, "Line too short at file %s line #%d" % (filename, linenum)

    numBytes = parse8(line, 1)
    if len(line) != numBytes*2 + 11:
      raise samiam.CommandException, "Line length does not match byte count at file %s line #%d" % (filename, linenum)

    addr = parse16(line, 3)
    rectype = parse8(line, 7)

    if rectype not in [0,1,3,4,5]:
      raise samiam.CommandException, "Unexpected record type %d at file %s line #%d" % (rectype, filename, linenum)

    checksum = rectype + numBytes + addr + (addr >> 8)
    if numBytes > 0:
      data = array.array('B', '\xFF'*numBytes) # Type 'B' is unsigned char stored as Python int's

      for i in range(numBytes):
        data[i] = parse8(line, 2*i+9)
        checksum += data[i]

    checksum += parse8(line, 2*numBytes+9)
    if (checksum & 0xFF) != 0:
      raise samiam.CommandException, "Record checksum error at file %s line #%d" % (filename, linenum)

    if rectype == 0:  # Data record
      datalines.append( (addrprefix+addr, data) )
    elif rectype == 1:  # End of file
      break
    elif rectype == 3:  # Start address -- 16-bit format
      startaddr = data2wordMSB(data)
    elif rectype == 4:  # Extended linear address record...data field sets upper 16 bits of address
      addrprefix = data2wordMSB(data)
      addrprefix <<= 16
    elif rectype == 5:  # Start address -- 32-bit format
      startaddr = data2wordMSB(data)

  fid.close()

  # Combine contiguous addresses
  datalines = mergeData(datalines)
  return datalines, startaddr

####################### Write Intel HEX Files
def writeHex_raw(fid, addr, rectype, data):
  fid.write(":%02X%04X%02X" % (len(data), addr, rectype))
  cs = len(data) + (addr & 0xFF) + ((addr >> 8) & 0xFF) + rectype
  for val in [ord(V) for V in data]:
    fid.write("%02X" % val)
    cs += val

  fid.write("%02X\n" % ((~cs + 1) & 0xFF))

def writeHex_addressprefix(fid, prefix):
  writeHex_raw(fid, 0, 4, (chr((prefix >> 24) & 0xFF), chr((prefix >> 16) & 0xFF)))

def writeHex_end(fid):
  writeHex_raw(fid, 0, 1, ())

def writeHex_data(fid, address, data):
  writeHex_raw(fid, address & 0x0000FFFF, 0, data)

def newAddressPrefix(fid, addrprefix, address, force=0):
  warnings.filterwarnings("ignore", "hex/oct constants", FutureWarning, ".*", 0)
  if force or ((address & 0xFFFF0000) != addrprefix):
    addrprefix = (address & 0xFFFF0000)
    writeHex_addressprefix(fid, addrprefix)

  return addrprefix

def writeHexFile(fname, address, Data):
  try:
    fid = file(fname, 'wt')
  except Exception, detail:
    raise samiam.CommandException, 'Unable to open output file "%s":\n  %s' % str(detail)

  addrprefix = newAddressPrefix(fid, 0, address, force=1)
  DataIx = 0
  Buf = ""
  while DataIx < len(Data):
    c = Data[DataIx]
    while len(c):
      extra = len(Buf) + len(c) - 16

      if extra==0:
        Buf += c
        c = ""
        addrprefix = newAddressPrefix(fid, addrprefix, address)
        writeHex_data(fid, address, Buf)
        Buf = ""
        address += 16
      elif extra > 0:
        Buf += c[:-extra]
        c = c[-extra:]
        addrprefix = newAddressPrefix(fid, addrprefix, address)
        writeHex_data(fid, address, Buf)
        Buf = ""
        address += 16
      else:
        Buf += c
        c = ""
    # end while len(c)
    DataIx += 1
  # end while DataIx < len(Data)

  if len(Buf):
    addrprefix = newAddressPrefix(fid, addrprefix, address)
    writeHex_data(fid, address, Buf)

  writeHex_end(fid)

if __name__=="__main__":
  import sys
  warnings.filterwarnings("ignore", "hex/oct constants", FutureWarning, ".*", 0)

  data, startaddr = readHEX(sys.argv[1])
  print "Start address is", hex(startaddr)
  for addr,bytes in data:
    print "%s-%s: %d bytes" % (hex(addr),hex(addr+len(bytes)),len(bytes))
