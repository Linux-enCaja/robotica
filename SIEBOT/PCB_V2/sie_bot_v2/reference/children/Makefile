PROGRAM = main

# One of "ram" or "flash"
MODE = flash

# One of "hd" or "md" or "cl"
DENSITY = cl

# Object files
OBJS = main.o hardware_init.o irda.o paquet.o spi.o\
	   checksum.o envoi.o synchro.o \
	   glip-image.o glip-animation.o lfsr.o recevoir.o\
	   tasks.o port.o list.o heap_1.o queue.o fatal.o

include ../Makefile.inc

CFLAGS += -DDEBUG -I../common -DDEBUG_CHECK
VPATH += ../common

CFLAGS += -I../data
VPATH += ../data
