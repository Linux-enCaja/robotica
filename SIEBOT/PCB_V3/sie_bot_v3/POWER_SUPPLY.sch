EESchema Schematic File Version 2  date Thu 22 Sep 2011 09:11:06 AM COT
LIBS:con-jack
LIBS:adm3101e
LIBS:microsd
LIBS:transistor-npn
LIBS:ipc-7351-transistor
LIBS:switch-misc
LIBS:power
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
LIBS:micron_ddr_512Mb
LIBS:iMX23
LIBS:sdmmc
LIBS:usbconn
LIBS:fsusb20
LIBS:r_pack2
LIBS:pasives-connectors
LIBS:EEPROM
LIBS:PWR
LIBS:m25p32
LIBS:PROpendous-cache
LIBS:w_analog
LIBS:gl850g
LIBS:srf2012
LIBS:rclamp0502b
LIBS:mcp130
LIBS:ABM8G
LIBS:usb_a
LIBS:Reset
LIBS:stm32f100vxx
LIBS:lt1117cst
LIBS:i.mx233stamp-cache
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 2 6
Title ""
Date "22 sep 2011"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	1400 3300 2500 3300
Text Label 2650 1300 2    20   ~ 0
BAT_V
Wire Wire Line
	2500 1300 2650 1300
Wire Wire Line
	1350 1150 1350 950 
Wire Wire Line
	8800 4950 8800 5050
Wire Wire Line
	8800 5050 8450 5050
Wire Wire Line
	10150 2050 10150 2150
Wire Wire Line
	7300 5100 7300 4900
Wire Wire Line
	8050 5100 8050 4900
Wire Wire Line
	1850 3850 1850 3700
Wire Wire Line
	7750 4900 7750 5100
Wire Wire Line
	7150 4900 7150 5100
Wire Wire Line
	7000 4900 7000 5100
Wire Wire Line
	6700 4900 6700 5100
Connection ~ 7400 3450
Wire Wire Line
	7650 3450 6800 3450
Wire Wire Line
	1350 950  1400 950 
Wire Wire Line
	2500 3750 2500 3900
Connection ~ 1850 3300
Wire Wire Line
	6150 3400 5900 3400
Wire Wire Line
	7400 3850 7400 3950
Wire Wire Line
	6900 3400 6800 3400
Wire Wire Line
	4250 4500 4000 4500
Wire Wire Line
	5200 5000 5200 5100
Wire Wire Line
	4900 4500 5100 4500
Wire Wire Line
	4100 4600 4000 4600
Wire Wire Line
	6800 3450 6800 3500
Wire Wire Line
	5890 3500 6000 3500
Wire Wire Line
	1250 1150 1250 950 
Wire Wire Line
	1250 950  1150 950 
Wire Wire Line
	4900 4600 5350 4600
Connection ~ 5200 4600
Wire Wire Line
	6800 3400 6800 3300
Wire Wire Line
	6850 5100 6850 4900
Wire Wire Line
	7900 5100 7900 4900
Wire Wire Line
	7600 5100 7600 4900
Wire Wire Line
	10150 1550 10150 1450
Wire Wire Line
	10150 890  10150 1050
Wire Wire Line
	8450 5050 8450 4950
Wire Wire Line
	7450 4900 7450 5100
Wire Wire Line
	2500 3300 2500 3350
Wire Wire Line
	2500 1200 2650 1200
Text Label 2650 1200 2    20   ~ 0
USB_5V
$Comp
L HEADER_2 J18
U 1 1 4DADE6B7
P 2200 1450
F 0 "J18" H 2000 1650 60  0000 C CNN
F 1 "HEADER_2" H 2300 1400 60  0000 C CNN
	1    2200 1450
	1    0    0    -1  
$EndComp
Text HLabel 7450 4900 0    20   BiDi ~ 0
VRTC
Text GLabel 7450 5100 2    20   BiDi ~ 0
VRTC
Text GLabel 8800 4950 0    20   BiDi ~ 0
VRTC
Text GLabel 8450 4950 0    20   BiDi ~ 0
3.3V
Text GLabel 10150 890  0    20   BiDi ~ 0
3.3V
Text GLabel 10150 2150 2    20   BiDi ~ 0
GND
$Comp
L R R31
U 1 1 4BA5068A
P 10150 1800
F 0 "R31" V 10230 1800 50  0000 C CNN
F 1 "1K" V 10150 1800 50  0000 C CNN
	1    10150 1800
	1    0    0    -1  
$EndComp
$Comp
L LED D7
U 1 1 4BA50684
P 10150 1250
F 0 "D7" H 10150 1350 50  0000 C CNN
F 1 "LED" H 10150 1150 50  0000 C CNN
	1    10150 1250
	0    1    1    0   
$EndComp
Text GLabel 7300 5100 2    20   BiDi ~ 0
GND
Text HLabel 7300 4900 0    20   BiDi ~ 0
GND
Text GLabel 8050 5100 2    20   BiDi ~ 0
USB_5V
Text HLabel 8050 4900 0    20   BiDi ~ 0
USB_5V
Text GLabel 1150 950  0    20   BiDi ~ 0
GND
Text GLabel 2500 3900 2    20   BiDi ~ 0
GND
Text GLabel 1850 3850 2    20   BiDi ~ 0
GND
Text GLabel 7400 3950 2    20   BiDi ~ 0
GND
Text GLabel 5890 3500 0    20   BiDi ~ 0
GND
Text GLabel 5200 5100 2    20   BiDi ~ 0
GND
Text GLabel 4000 4600 0    20   BiDi ~ 0
GND
Text GLabel 1400 950  2    20   BiDi ~ 0
BAT_V
Text GLabel 1400 3300 0    20   BiDi ~ 0
BAT_V
Text GLabel 7650 3450 2    20   BiDi ~ 0
3.3V
Text GLabel 6900 3400 2    20   BiDi ~ 0
3.3V
Text GLabel 6800 3300 0    20   BiDi ~ 0
3V3
Text GLabel 5900 3400 0    20   BiDi ~ 0
BAT_V
Text GLabel 5350 4600 2    20   BiDi ~ 0
1.8v
Text GLabel 5100 4500 2    20   BiDi ~ 0
1.8v
Text GLabel 4000 4500 0    20   BiDi ~ 0
BAT_V
Text GLabel 7600 5100 2    20   BiDi ~ 0
2V5
Text GLabel 7750 5100 2    20   BiDi ~ 0
2.5V
Text GLabel 7900 5100 2    20   BiDi ~ 0
1V2
Text GLabel 7150 5100 2    20   BiDi ~ 0
1.2V
Text GLabel 7000 5100 2    20   BiDi ~ 0
1.8V
Text GLabel 6850 5100 2    20   BiDi ~ 0
3V3
Text GLabel 6700 5100 2    20   BiDi ~ 0
3.3V
Text HLabel 7600 4900 0    20   BiDi ~ 0
2V5
Text HLabel 7750 4900 0    20   BiDi ~ 0
2.5V
Text HLabel 7900 4900 0    20   BiDi ~ 0
1V2
Text HLabel 7150 4900 0    20   BiDi ~ 0
1.2V
Text HLabel 7000 4900 0    20   BiDi ~ 0
1.8V
Text HLabel 6850 4900 0    20   BiDi ~ 0
3V3
Text HLabel 6700 4900 0    20   BiDi ~ 0
3.3V
$Comp
L HOLE J14
U 1 1 4B7C701D
P 10750 6800
F 0 "J14" H 10650 7100 60  0000 C CNN
F 1 "HOLE4" H 10750 6800 60  0000 C CNN
	1    10750 6800
	1    0    0    -1  
$EndComp
$Comp
L HOLE J13
U 1 1 4B7C701B
P 10100 6800
F 0 "J13" H 10000 7100 60  0000 C CNN
F 1 "HOLE3" H 10100 6800 60  0000 C CNN
	1    10100 6800
	1    0    0    -1  
$EndComp
$Comp
L HOLE J12
U 1 1 4B7C7019
P 9500 6800
F 0 "J12" H 9400 7100 60  0000 C CNN
F 1 "HOLE1" H 9500 6800 60  0000 C CNN
	1    9500 6800
	1    0    0    -1  
$EndComp
$Comp
L HOLE J11
U 1 1 4B7C7014
P 8850 6800
F 0 "J11" H 8750 7100 60  0000 C CNN
F 1 "HOLE1" H 8850 6800 60  0000 C CNN
	1    8850 6800
	1    0    0    -1  
$EndComp
$Comp
L C C42
U 1 1 4B7C6CBC
P 7400 3650
F 0 "C42" H 7450 3750 50  0000 L CNN
F 1 "100n" H 7450 3550 50  0000 L CNN
	1    7400 3650
	1    0    0    -1  
$EndComp
$Comp
L C C41
U 1 1 4B7C6CBA
P 5200 4800
F 0 "C41" H 5250 4900 50  0000 L CNN
F 1 "100n" H 5250 4700 50  0000 L CNN
	1    5200 4800
	1    0    0    -1  
$EndComp
$Comp
L C C53
U 1 1 4B7C6CB7
P 1850 3500
F 0 "C53" H 1900 3600 50  0000 L CNN
F 1 "100n" H 1900 3400 50  0000 L CNN
	1    1850 3500
	1    0    0    -1  
$EndComp
$Comp
L C C56
U 1 1 4B7C6CB4
P 2500 3550
F 0 "C56" H 2550 3650 50  0000 L CNN
F 1 "10u" H 2550 3450 50  0000 L CNN
	1    2500 3550
	1    0    0    1   
$EndComp
$Comp
L HEADER_2 J17
U 1 1 4B7C6CA6
P 1500 1450
F 0 "J17" V 1350 1700 60  0000 C CNN
F 1 "POWER" V 1250 1700 60  0000 C CNN
	1    1500 1450
	0    -1   -1   0   
$EndComp
$Comp
L LT1117CST U7
U 1 1 4B7C6C99
P 4600 4700
F 0 "U7" H 4450 5000 60  0000 C CNN
F 1 "LT1117CST-1.8" H 4600 4700 40  0000 C CNN
	1    4600 4700
	1    0    0    -1  
$EndComp
$Comp
L LT1117CST U8
U 1 1 4B7C6C33
P 6500 3600
F 0 "U8" H 6350 3900 60  0000 C CNN
F 1 "LT1117CST-3.3" H 6500 3600 40  0000 C CNN
	1    6500 3600
	1    0    0    -1  
$EndComp
$EndSCHEMATC
