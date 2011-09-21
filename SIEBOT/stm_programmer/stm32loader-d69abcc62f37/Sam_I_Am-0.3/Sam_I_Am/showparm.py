#!/usr/bin/env python
"""Show user-settable parameters"""

import samiam

def showall(obj):
  show_readallow(obj)
  show_execallow(obj)
  show_ramwriteallow(obj)
  show_flashwriteallow(obj)
  show_status(obj)

def show(obj, parm):
  if parm is None:
    showall(obj)
    return

  parm = parm.lower()
  if parm=='readallow':
    show_readallow(obj)
  elif parm=='execallow':
    show_execallow(obj)
  elif parm=='ramwriteallow':
    show_ramwriteallow(obj)
  elif parm=='flashwriteallow':
    show_flashwriteallow(obj)
  elif parm=='status':
    show_status(obj)
  else:
    raise samiam.CommandException, "Unknown 'show' parameter"

def show_readallow(obj):
  if obj.read_allowed_list:
    print "readallow: memory read accesses are allowed at:"
    for laddr,uaddr in obj.read_allowed_list:
      print "    0x%08X-0x%08X: %d bytes" % (laddr,uaddr,uaddr-laddr+1)
  else:
    print "readallow: memory read accesses are allowed everywhere."
    
def show_execallow(obj):
  if obj.exec_allowed_list:
    print "execallow: program execution is allowed at:"
    for laddr,uaddr in obj.exec_allowed_list:
      print "    0x%08X-0x%08X: %d bytes" % (laddr,uaddr,uaddr-laddr+1)
  else:
    print "execallow: program execution is allowed everywhere."
    
def show_ramwriteallow(obj):
  if obj.ramwrite_allowed_list:
    print "ramwriteallow: writing to RAM is allowed at:"
    for laddr,uaddr in obj.ramwrite_allowed_list:
      print "    0x%08X-0x%08X: %d bytes" % (laddr,uaddr,uaddr-laddr+1)
  else:
    print "ramwriteallow: writing to RAM is allowed everywhere."
    
def show_flashwriteallow(obj):
  if obj.flashwrite_allowed_list:
    print "flashwriteallow: writing to FLASH is allowed at:"
    for laddr,uaddr in obj.flashwrite_allowed_list:
      print "    0x%08X-0x%08X: %d bytes" % (laddr,uaddr,uaddr-laddr+1)
  else:
    print "flashwriteallow: writing to FLASH is allowed everywhere."

def show_status(obj):
  if obj.options.dev:
    print "status: connected to %s - %d baud - %d ms timeout" \
          % (obj.options.DevicePort, obj.options.BaudRate, obj.options.Timeout)
  else:
    print "status: not connected."
