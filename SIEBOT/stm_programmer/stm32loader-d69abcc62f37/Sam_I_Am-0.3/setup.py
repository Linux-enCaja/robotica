#!/usr/bin/env python
import sys
import glob
import os

from distutils.core import setup, Extension
import distutils.sysconfig

from Sam_I_Am.samiam import VERSION_MAJOR, VERSION_MINOR

if sys.version_info < (2,3,0):
  print '*'*73
  print 'Sam_I_Am version %d.%d requires Python 2.3 or higher' % (VERSION_MAJOR, VERSION_MINOR)
  print '*'*73
  sys.exit(1)

if 0:
  for key,val in distutils.sysconfig.get_config_vars().items():
    print key
    print '***********************'
    print '  ', val
    print
    print

  sys.exit(0)

SampleFiles = glob.glob('sample/*')
FlashifFiles = glob.glob('flashif/*')
DocFiles = glob.glob('doc/*')
AuxFiles = ['README', 'COPYING']

DestLib = distutils.sysconfig.get_config_var('LIBDEST')
DestDir = os.path.join(DestLib, 'Sam_I_Am')
BinFiles = ['misc/Sam_I_Am']
BinDir = distutils.sysconfig.get_config_var('BINDIR')  

# Create top-level invocation program
try:
	os.mkdir('misc')
except OSError:
	pass
fid = file('misc/Sam_I_Am', 'wt')
fid.write( \
r"""#!/bin/sh
python %s/site-packages/Sam_I_Am/samiam.py $*
""" % DestLib)
fid.close()

dist=setup (name = "Sam_I_Am",
       license = "GPL",
       version = "%d.%d" % (VERSION_MAJOR, VERSION_MINOR),
      long_description=\
r"""Sam_I_Am is an interface to Atmel AT91SAM7S microcontrollers
running the built-in SAM-BA program. It allows reading and
writing memory locations, displaying peripheral status, and
writing programs to either RAM or FLASH.

To run the program, invoke the Python interpreter on the
samiam.py file. The Sam_I_Am shell script in /usr/bin or
/usr/local/bin (or similar) can be used to perform this action.

For more details on installation or running Sam_I_Am, see the
URL below.
""",
       description = "Interact with an Atmel AT91SAM7S microcontroller running SAM-BA",
       author = "Andrew Sterian",
       author_email = "steriana@claymore.engineer.gvsu.edu",
       url = "http://claymore.engineer.gvsu.edu/~steriana/Python",
       packages = ['Sam_I_Am'],
       platforms = ['Linux'],
       data_files = [ (DestDir, AuxFiles), 
                      (os.path.join(DestDir,'doc'), DocFiles),
                      (os.path.join(DestDir,'sample'), SampleFiles),
                      (os.path.join(DestDir,'flashif'), FlashifFiles),
                      (BinDir, BinFiles) ]
)

do_fix_perms = 0
cmd = None
for cmd in dist.commands:
 if cmd[:7]=='install':
  do_fix_perms = 1
  break

if do_fix_perms:
  # Ensure package files and misc/help files are world readable-searchable.
  # Shouldn't Distutils do this for us?
  print 'Setting permissions on installed files...',
  try:
    def fixperms(arg, dirname, names):
      os.chmod(dirname, 0755)
      for name in names:
        fullname = os.path.join(dirname, name)
        if os.access(fullname, os.X_OK):
          os.chmod(fullname, 0755)
        else:
          os.chmod(fullname, 0644)

    os.path.walk(DestDir, fixperms, 1)
    os.path.walk(os.path.join(DestLib, 'site-packages/Sam_I_Am'), fixperms, 1)

    os.chmod(os.path.join(BinDir, 'Sam_I_Am'), 0755)
    print 'done'
  except:
    print 'FAILED'
    print
    print '*** Please verify that the installed files have correct permissions. On'
    print "*** systems without permission flags, you don't need to"
    print '*** worry about it.' 

if (cmd is not None) and cmd[:7]=='install':
  print
  print '******** Installation Complete ******** '
  print
  print 'Documentation has been installed in:'
  print '   ', DestDir
  print
  print 'A shortcut to starting the program has been installed as:'
  print '   ', os.path.join(BinDir, 'Sam_I_Am')
  print
