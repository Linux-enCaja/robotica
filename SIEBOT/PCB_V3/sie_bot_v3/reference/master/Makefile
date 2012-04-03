PROGRAM = main

# One of "ram" or "flash"
MODE = flash

# "cl"
DENSITY = cl

# Object files
OBJS = main.o hardware_init.o irda.o paquet.o spi.o glip-image.o glip-animation.o\
	   checksum.o envoi.o lfsr.o neighbours.o synchro.o master-synchro.o debug.o\
	   tasks.o port.o list.o heap_1.o queue.o fatal.o recevoir.o

include ../Makefile.inc

CFLAGS += -DMASTER -DDEBUG -DIRDA_MIN=2 -I../common -DDEBUG_CHECK
VPATH += ../common

CFLAGS += -I../data
VPATH += ../data
