EESchema Schematic File Version 2  date Tue 20 Sep 2011 11:06:44 AM COT
LIBS:l_mini
LIBS:power_cust
LIBS:ts3usb30e
LIBS:stmps2141
LIBS:mini-usb
LIBS:mcp1703
LIBS:max3421e
LIBS:stm32f100vxx
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:AMI-go-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 4
Title ""
Date "20 sep 2011"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Sheet
S 7400 4300 850  800 
U 4DCDB1BB
F0 "POWER" 60
F1 "power.sch" 60
F2 "Vin" B R 8250 4500 60 
F3 "OV_Current" B L 7400 5000 60 
F4 "Vbus_EN" B L 7400 4900 60 
F5 "VBUS_H" B R 8250 4600 60 
$EndSheet
Wire Wire Line
	7400 3750 7000 3750
Wire Wire Line
	7000 4900 7400 4900
Wire Bus Line
	7400 3650 7000 3650
Wire Wire Line
	8250 4500 8400 4500
Wire Wire Line
	8400 4500 8400 4000
Wire Wire Line
	8400 4000 8250 4000
Wire Bus Line
	7400 3450 7000 3450
Wire Bus Line
	7400 3550 7000 3550
Wire Wire Line
	7400 5000 7000 5000
Wire Wire Line
	8250 3900 8500 3900
Wire Wire Line
	8500 3900 8500 4600
Wire Wire Line
	8500 4600 8250 4600
$Sheet
S 7400 3350 850  750 
U 4E188FB2
F0 "CONNECTORS" 60
F1 "connectors.sch" 60
F2 "USB_CONN" B L 7400 3450 60 
F3 "Vin" B R 8250 4000 60 
F4 "VBUS_H" B R 8250 3900 60 
F5 "RESET" B L 7400 3750 60 
F6 "STM32_FP[0..35]" B L 7400 3550 60 
F7 "JTAG" B L 7400 3650 60 
$EndSheet
$Sheet
S 4800 3350 2200 1750
U 4DCDB155
F0 "STM32" 60
F1 "STM32.sch" 60
F2 "USB_PORT" B R 7000 3450 60 
F3 "STM32_FP[0..35]" B R 7000 3550 60 
F4 "Vbus_EN" B R 7000 4900 60 
F5 "OV_Current" B R 7000 5000 60 
F6 "RESET" B R 7000 3750 60 
F7 "JTAG" B R 7000 3650 60 
$EndSheet
$EndSCHEMATC
