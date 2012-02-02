# GDB startup script for debugging a program in flash ROM

# $Id: main.gdb 3418 2011-11-26 09:08:27Z svn $

# Connect to the GDB server

target remote localhost:3333

# Display memory regions

info mem

# Break at beginning of main()

break main
continue
