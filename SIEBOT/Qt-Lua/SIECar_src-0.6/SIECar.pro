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
    ui/splashscreen.cpp
HEADERS  += ui/output.h \
    globals/configuration.h \
    functions/definitions.h \
    events/SIEEvent.h \
    events/SIEMoveEvent.h \
    events/PWMEvent.h \
    events/GPSEvent.h \
    events/EncoderEvent.h \
    ui/splashscreen.h \
    events/DelayEvent.h



RESOURCES += \
    ui/resources.qrc

unix:{
SOURCES += include/jz47xx_gpio.c \
    include/jz47xx_mmap.c
HEADERS += include/jz47xx_gpio.h \
    include/jz47xx_mmap.h
LIBS += -B/media/c32a3391-d5f0-4ea5-8506-3a1f3336c7b0/juanjo/NanoNote/toolchain-new/openwrt-xburst/staging_dir/target-mipsel_uClibc-0.9.30.1/usr/lib/ -B/media/c32a3391-d5f0-4ea5-8506-3a1f3336c7b0/juanjo/NanoNote/toolchain-new/openwrt-xburst/build_dir/toolchain-mipsel_gcc-4.3.3+cs_uClibc-0.9.30.1/uClibc-0.9.30.1/lib -lgcc_s -L/media/c32a3391-d5f0-4ea5-8506-3a1f3336c7b0/juanjo/NanoNote/toolchain-new/openwrt-xburst/build_dir/toolchain-mipsel_gcc-4.3.3+cs_uClibc-0.9.30.1/gcc-4.3.3-final/mipsel-openwrt-linux-uclibc/libgcc -llua -ldl -lcrypt -lrt
}
win:{
    CONFIG += console
QMAKE_LFLAGS += /NODEFAULTLIB:msvcrt.lib
}
