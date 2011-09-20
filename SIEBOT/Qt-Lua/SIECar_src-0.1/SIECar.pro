#-------------------------------------------------
#
# Project created by QtCreator 2010-12-15T00:49:38
#
#-------------------------------------------------

QT       += core gui

TARGET = SIECar
TEMPLATE = app

SOURCES += main.cpp\
        ui/output.cpp \
    globals/configuration.cpp \
    include/jz47xx_gpio.c \
    include/jz47xx_mmap.c

HEADERS  += ui/output.h \
    globals/configuration.h \
    functions/definitions.h


LIBS += -B/home/juanjo/NanoNote/toolchain-new/openwrt-xburst/staging_dir/target-mipsel_uClibc-0.9.30.1/usr/lib/ -B/home/juanjo/NanoNote/toolchain-new/openwrt-xburst/build_dir/toolchain-mipsel_gcc-4.3.3+cs_uClibc-0.9.30.1/uClibc-0.9.30.1/lib -lgcc_s -L/home/juanjo/NanoNote/toolchain-new/openwrt-xburst/build_dir/toolchain-mipsel_gcc-4.3.3+cs_uClibc-0.9.30.1/gcc-4.3.3-final/mipsel-openwrt-linux-uclibc/libgcc -llua -ldl -lcrypt

RESOURCES += \
    ui/resources.qrc
    win:{
    CONFIG += console
QMAKE_LFLAGS += /NODEFAULTLIB:msvcrt.lib
}