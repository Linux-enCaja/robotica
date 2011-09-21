#!/usr/bin/env python
"""Set user-settable parameters"""

import samiam
import showparm
from parse import *

def set(obj, fields):  
  if len(fields)==0 or (fields[0] is None):
    showparm.showall(obj)
    return

  parm = fields[0].lower()
  if parm=='readallow':
    set_readallow(obj, fields)
  elif parm=='execallow':
    set_execallow(obj, fields)
  elif parm=='ramwriteallow':
    set_ramwriteallow(obj, fields)
  elif parm=='flashwriteallow':
    set_flashwriteallow(obj, fields)
  elif parm=='status':
    raise samiam.CommandException, "Status can only be shown (type 'show status') and not set"
  else:
    raise samiam.CommandException, "Unknown 'set' parameter"

def set_readallow(obj, fields):
  if len(fields) > 1 and fields[1].lower()=='all':
    obj.read_allowed_list = []
    return

  fields = parseFields(fields[1:], (
        ( (pIntDefaultHex,), 'address', 'Starting address of read area' ),
        ( (pIntDefaultHex,), 'bytes', 'Size of read area in bytes'),
                              ), 0)
  if fields[0] is None:
    print \
"""set readallow 'all' | StartAddress NumBytes

Allows memory reads in the area described by the starting address and
continuing for the specified number of bytes. If 'Address' is specified as
'all' then the list of allowable read areas is cleared so that ALL memory areas
become readable. Adding a specific memory area restricts read accesses to only
that area. Adding additional memory areas functions as an OR operation (i.e.,
either read area is allowed).

Memory reads are performed with the commands READB/READH/READW/RECV.

Examples:
  set readallow all          # Allow read access anywhere
  set readallow 0x2000 0x100 # Allow read access only from 0x2000-0x20FF
  set readallow 0x4000 0x100 # Allow read access to 0x2000-0x20FF and
                             # 0x4000-0x40FF.
  set readallow all          # Allow read access anywhere
  show readallow             # Display allowable read areas
"""
    return

  if fields[1] is None:
    raise samiam.CommandException, "You must specify both an address and the number of bytes"

  obj.read_allowed_list.append((fields[0], fields[0]+fields[1]-1))

def set_execallow(obj, fields):
  if len(fields) > 1 and fields[1].lower()=='all':
    obj.exec_allowed_list = []
    return

  fields = parseFields(fields[1:], (
        ( (pIntDefaultHex,), 'address', 'Starting address of executable area' ),
        ( (pIntDefaultHex,), 'bytes', 'Size of read area in bytes'),
                              ), 0)
  if fields[0] is None:
    print \
"""set execallow 'all' | StartAddress NumBytes

Allows program execution in the area described by the starting address and
continuing for the specified number of bytes. If 'Address' is specified as
'all' then the list of allowable areas is cleared so that ALL memory areas
become executable. Adding a specific memory area restricts execution to only
that area. Adding additional memory areas functions as an OR operation (i.e.,
either area is allowed).

Program execution is invoked with the GO command.

Examples:
  set execallow all          # Allow execution anywhere
  set execallow 0x2000 0x100 # Allow execution only from 0x2000-0x20FF
  set execallow 0x4000 0x100 # Allow execution in 0x2000-0x20FF and
                             # 0x4000-0x40FF.
  set execallow all          # Allow execution anywhere
  show execallow             # Display allowable execution areas
"""
    return

  if fields[1] is None:
    raise samiam.CommandException, "You must specify both an address and the number of bytes"

  obj.exec_allowed_list.append((fields[0], fields[0]+fields[1]-1))

def set_ramwriteallow(obj, fields):
  if len(fields) > 1 and fields[1].lower()=='all':
    obj.ramwrite_allowed_list = []
    return

  fields = parseFields(fields[1:], (
        ( (pIntDefaultHex,), 'address', 'Starting address of RAM writable area' ),
        ( (pIntDefaultHex,), 'bytes', 'Size of RAM writable area in bytes'),
                              ), 0)
  if fields[0] is None:
    print \
"""set ramwriteallow 'all' | StartAddress NumBytes

Allows data to be written to RAM in the area described by the starting address
and continuing for the specified number of bytes. If 'Address' is specified as
'all' then the list of allowable areas is cleared so that ALL memory areas
become writable. Adding a specific memory area restricts writing to only that
area. Adding additional memory areas functions as an OR operation (i.e., either
area is allowed).

RAM is written to using the commands WRITEB/WRITEH/WRITEW/SEND.

Examples:
  set ramwriteallow all          # Allow RAM writes anywhere
  set ramwriteallow 0x2000 0x100 # Allow RAM writes only from 0x2000-0x20FF
  set ramwriteallow 0x4000 0x100 # Allow RAM writes in 0x2000-0x20FF and
                                 # 0x4000-0x40FF.
  set ramwriteallow all          # Allow RAM writes anywhere
  show ramwriteallow             # Display allowable RAM write areas
"""
    return

  if fields[1] is None:
    raise samiam.CommandException, "You must specify both an address and the number of bytes"

  obj.ramwrite_allowed_list.append((fields[0], fields[0]+fields[1]-1))

def set_flashwriteallow(obj, fields):
  if len(fields) > 1 and fields[1].lower()=='all':
    obj.flashwrite_allowed_list = []
    return

  fields = parseFields(fields[1:], (
        ( (pIntDefaultHex,), 'address', 'Starting address of FLASH writable area' ),
        ( (pIntDefaultHex,), 'bytes', 'Size of FLASH writable area in bytes'),
                              ), 0)
  if fields[0] is None:
    print \
"""set flashwriteallow 'all' | StartAddress NumBytes

Allows data to be written to FLASH in the area described by the starting address
and continuing for the specified number of bytes. If 'Address' is specified as
'all' then the list of allowable areas is cleared so that ALL memory areas
become writable. Adding a specific memory area restricts writing to only that
area. Adding additional memory areas functions as an OR operation (i.e., either
area is allowed).

FLASH is written to using the FLASH command.

Examples:
 set flashwriteallow all          # Allow FLASH writes anywhere
 set flashwriteallow 0x2000 0x100 # Allow FLASH writes only from 0x2000-0x20FF
 set flashwriteallow 0x4000 0x100 # Allow FLASH writes in 0x2000-0x20FF and
                                  # 0x4000-0x40FF.
 set flashwriteallow all          # Allow FLASH writes anywhere
 show flashwriteallow             # Display allowable FLASH write areas
"""
    return

  if fields[1] is None:
    raise samiam.CommandException, "You must specify both an address and the number of bytes"

  obj.flashwrite_allowed_list.append((fields[0], fields[0]+fields[1]-1))
