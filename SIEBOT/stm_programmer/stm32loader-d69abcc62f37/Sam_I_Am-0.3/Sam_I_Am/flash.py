#!/usr/bin/env python
"""Support for writing and verifying FLASH"""

import math
import array
import time
import os
import sys

import samiam
import info
import flashif
import sambaif

# This module attempts to verify that the processor we are trying to FLASH is
# one of the recognized processors we know about by comparing FLASH and SRAM
# size to published values.

# Each entry of this dictionary contains the processor name, the
# number of pages in a lock region, and the page size in bytes.
Processors = {
  # Some revisions of the AT91SAM7S256 incorrectly report 256K of RAM hence
  # this first entry.
  ('256K', '256K'): ("AT91SAM7S256", 64, 256),
  ('256K', '64K'): ("AT91SAM7S256", 64, 256),

  # Similarly, some AT91SAM7S128 devices report 128K of SRAM.
  ('128K', '128K'): ("AT91SAM7S128", 64, 256),
  ('128K', '32K'): ("AT91SAM7S128", 64, 256),
  ('64K', '16K'): ("AT91SAM7S64", 32, 128),
  ('32K', '8K'): ("AT91SAM7S321/32", 32, 128) }

def makePages(datalines, page_size):
  pagebits = int(round(math.log(page_size)/math.log(2)))
  pagemask = page_size-1
   
  pages = {}
  for addr,data in datalines:
    maxaddr = addr + len(data) - 1
    pagenum1 = addr>>pagebits
    offset1 = addr & pagemask
    pagenum2 = maxaddr>>pagebits
    offset2 = maxaddr & pagemask

    # Ensure all pages in the range are in the dictionary
    for pagenum in range(pagenum1,pagenum2+1):
      if not pages.has_key(pagenum):
        pages[pagenum] = array.array('B', '\xFF'*page_size)

    dataix = 0
    pagenum = pagenum1
    offset = offset1

    while dataix < len(data):
      bytesremain = len(data)-dataix

      bytes = min(bytesremain, page_size-offset)
      pages[pagenum][offset:offset+bytes] = data[dataix:dataix+bytes]

      dataix += bytes
      offset = 0
      pagenum += 1
  
  return pages

def program(obj, datalines):
  val = info.readWord(obj, 0xFFFFF200+0x0040)  # DBGU_CIDR
  flashsize = info.nvprogsize(val>>8)  # returns, e.g., '256K'
  flashsizebytes = int(flashsize[:-1])*1024
  sramsize = info.sramsize((val>>16)&0xF)  # returns, e.g., '64K'

  try:
    procname, pages_in_region, page_size = Processors[(flashsize,sramsize)]
  except KeyError:
    raise samiam.CommandException, "Processor with %s FLASH and %s RAM is unknown" % (flashsize, sramsize)

  print "Processor is %s with %s FLASH and %s RAM" % (procname, flashsize, sramsize)
  print "Page size: %d bytes  Pages in Lock Region: %d  Lock Regions: %d" % \
      (page_size, pages_in_region, flashsizebytes/page_size/pages_in_region)

  # Make sure there are no out-of-bounds FLASH accesses
  minAddress = datalines[0][0]
  maxAddress = datalines[-1][0] + len(datalines[-1][1]) - 1
  if minAddress < 0x100000:
    raise samiam.CommandException, "There is no FLASH below address 0x100000"
  if maxAddress >= (0x100000 + flashsizebytes):
    raise samiam.CommandException, "There is no FLASH above address 0x%06X" % (0x100000+flashsizebytes-1)

  # Convert datalines into a dictionary of pages where each page entry contains a page_size-length
  # array of bytes, initialized to FF and overwritten with HEX-file data.
  pages = makePages(datalines, page_size)

  print "Number of pages to program: %d" % len(pages.keys())
  
  # Upload flashif program into RAM
  flashif.upload(obj)

  # Send Nothing command and make sure we get back OK
  if flashif.cmd_Nothing(obj) != 'OK':
    raise samiam.CommandException, "FLASH bootloader not operational"

  pagenums = pages.keys()
  pagenums.sort()

  success = False

  # Each page number is an address shifted right by log2(page_size). Thus
  # we can get the starting address of the page by multiplying by page_size.
  # The actual page number to send to SAM-BA starts at 0, thus we must
  # mask off all but the lowest 10 bits of the page number.
  #
  # An optimization here is to not write words that are 0xFFFFFFFF. I have
  # a feeling that it will take longer to perform this optimization in Python
  # code than to just blast the data down the USB port.
  pagecnt = 0
  for pagenum in pagenums:
    pagecnt += 1
    print '\rProgramming page %d/%d ...' % (pagecnt, len(pagenums)),
    sys.stdout.flush()
    reply = flashif.cmd_WriteData(obj, pagenum*page_size, pagenum & 0x3FF, pages[pagenum])
    if reply != 'OK':
      print '\n\nProgramming page #%d failed:\n  %s' % (pagenum & 0x3FF, flashif.errorstr(reply))
      break
  else:
    success = True

  print
  if flashif.cmd_Exit(obj) != 'OK':
    raise samiam.CommandException, "Unable to return control back to SAM-BA"

  # Send another character to make sure SAM-BA's ping-pong USB buffer gets resynchronized.
  # SAM-BA ignores 0xFF characters so let's send one of those.
  os.write(obj.options.dev, "\xFF")

  if not success:
    raise samiam.CommandException, "FLASH programming failed"

  success = False

  # We should now have SAM-BA back. Let's verify the FLASH programming.
  pagecnt = 0
  for pagenum in pagenums:
    pagecnt += 1
    print '\rVerifying page %d/%d ...' % (pagecnt, len(pagenums)),
    sys.stdout.flush()
    datalist = sambaif.doReceiveRaw(obj.options, pagenum*page_size, page_size)
    data = array.array('B')
    for chunk in datalist:
      data.fromstring(chunk)

    if data != pages[pagenum]:
      print '\n\nVerify error at page #%d' % (pagenum & 0x3FF)
      #print 'Wrote:'
      #print pages[pagenum]
      #print 'Read:'
      #print data
      break
  else:
    success = True

  print
  if success:
    print 'Programming FLASH was successful'
  else:
    raise samiam.CommandException, "FLASH programming failed"
