# Common library make definitions

# $Id: common.mk 3058 2011-09-26 11:02:33Z svn $

COMMON_DIR	?= $(ARMSRC)/common
CFLAGS		+= -I$(COMMON_DIR)

.PHONY: common_lib common_clean

COMMON_OBJS	= $(COMMON_DIR)/device.o $(COMMON_DIR)/inet.o $(COMMON_DIR)/syscalls.o

# Add common object files to the MCU library

common_lib: $(COMMON_OBJS)
	$(AR) crs lib$(MCU).a $(COMMON_OBJS)

# Remove common object files

common_clean:
	rm -f $(COMMON_OBJS)
