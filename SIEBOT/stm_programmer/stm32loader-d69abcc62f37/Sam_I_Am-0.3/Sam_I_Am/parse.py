#!/usr/bin/env python
"""Support for parsing and validating arguments"""

import os
import math

import samiam

def pFileExists(val, name):
  """Verify that a given file name exists"""
  if not os.path.exists(val):
    raise samiam.CommandException, "The pathname '%s' does not exist" % val
  return val

def getIntBase(val):
  """Parses a 2-character prefix in a string and returns 2, 10, or 16 if a
  prefix exist, or 0 if no prefix is given."""
  if len(val) > 2:
    if val[:2]=="0x" or val[:2]=="0X":
      return 16
    if val[:2]=="0b" or val[:2]=="0B":
      return 2
    if val[:2]=="0d" or val[:2]=="0D":
      return 10
  return 0

def pIntDefaultHex(val, name):
  """Take a string and try to parse it as an integer based on a prefix, if any,
  or as hexadecimal if no prefix given. Prefixes are:
    0x or 0X:  hexadecimal
    0b or 0B:  binary
    0d or 0D:  decimal
    no prefix: hexadecimal"""
  base = getIntBase(val)
  if base==0:
    base=16
  else:
    val = val[2:]

  try:
    val = int(val, base)
  except:
    raise samiam.CommandException, "Parameter '%s' must be a valid integer. Use 0x for hex or 0b for binary." % name

  return val

def pIntDefaultDec(val, name):
  """Take a string and try to parse it as an integer based on a prefix, if any,
  or as decimal if no prefix given. Prefixes are:
    0x or 0X:  hexadecimal
    0b or 0B:  binary
    0d or 0D:  decimal
    no prefix: decimal"""
  base = getIntBase(val)
  if base==0:
    base=10
  else:
    val = val[2:]

  try:
    val = int(val, base)
  except:
    raise samiam.CommandException, "Parameter '%s' must be a valid integer. Use 0x for hex or 0b for binary." % name

  return val

def pIntMaxBits(val, maxBits, name):
  """Take an integer and ensure it fits into a given number of bits."""
  mask = ~((1 << maxBits) - 1)
  if val & mask:
    raise samiam.CommandException, "Parameter '%s' is too large to fit into %d bits." % (name, maxBits)

  return val

def pAligned(val, byteAlign, name):
  """Ensure an integer is aligned to a given number of bytes, which must be a power of 2."""
  clearBits = int(round(math.log(byteAlign)/math.log(2)))
  mask = (1<<clearBits) - 1
  if val & mask:
    raise samiam.CommandException, "Parameter '%s' must be aligned to a %d-byte boundary." % (name, byteAlign)

  return val

def parseFields(fields, items, minItems, noMaxItems=False):
  """Given a list of arguments, map each one into a parsed, validated value
  according to the constructs in 'items'. The 'items' parameter is a list or
  tuple of 3-tuples: ( (func1,(func2,args2),func3,...), ParmName, ParmHelp )

  The ParmName item is the name of the parameter to report in error messages.
  The ParmHelp item reports the purpose of the parameter. The first item is a
  tuple of callable functions in this module which are executed as a pipeline.
  The item to be parsed is first passed to func1. This will either raise an
  exception if the parsing/validating failed or will return a value. This value
  is then passed to func2, and so on. A function may be specified as a single
  callable value, or a 2-tuple which represents a callable value followed by an
  extra parameter (which can be a tuple) to pass to the function following the
  argument. For example:

        ( (pIntDefaultHex,),                'address', 'Address to load'),
        ( (pIntDefaultHex,(pIntMaxBits,8)), 'byte',    'Byte to write')

  See the top of this module for a listing of currently supported
  parsers/validators.

  The return value of this function is a list of converted arguments that is as
  long as 'items'. The last (len(items)-minItems) entries in this list may be
  None to indicate optional parameters that were not specified. That is,
  'minItems' specifies the minimum number of fields that are expected, while
  len(items) is the maximum number of fields."""

  if (not noMaxItems) and (len(fields) > len(items)):
    raise samiam.CommandException, "Too many parameters specified (at most %d are expected)" % len(items)
  if len(fields) < minItems:
    if minItems==1:
      raise samiam.CommandException, "At least 1 parameter is required"
    else:
      raise samiam.CommandException, "At least %d parameters are required" % minItems

  RetList = [None]*len(items)
  for ix in range(min(len(items),len(fields))):
    val = fields[ix]

    for cvt in items[ix][0]:
      # cvt may be a simple function object, or a (func, argtuple) tuple
      if callable(cvt):
        val = cvt(val, items[ix][1])
      else:
        val = cvt[0](val, cvt[1], items[ix][1])

    RetList[ix] = val

  return RetList
