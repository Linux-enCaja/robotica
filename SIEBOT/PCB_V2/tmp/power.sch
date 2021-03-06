EESchema Schematic File Version 2  date lun 29 ago 2011 17:14:23 COT
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
Sheet 2 4
Title ""
Date "29 aug 2011"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L PWR_FLAG #FLG01
U 1 1 4E2A3723
P 9850 3750
F 0 "#FLG01" H 9850 4020 30  0001 C CNN
F 1 "PWR_FLAG" H 9850 3980 30  0000 C CNN
	1    9850 3750
	-1   0    0    1   
$EndComp
$Comp
L 3V3_AN #PWR02
U 1 1 4E2A371D
P 9850 3750
F 0 "#PWR02" H 9850 3850 30  0001 C CNN
F 1 "3V3_AN" H 9850 3860 30  0000 C CNN
	1    9850 3750
	1    0    0    -1  
$EndComp
Wire Wire Line
	6100 4200 6100 4300
Wire Wire Line
	5600 4200 5600 4300
Wire Wire Line
	1900 3100 2550 3100
Wire Wire Line
	2000 3400 2550 3400
Connection ~ 5600 4800
Wire Wire Line
	5600 4700 5600 4800
Wire Wire Line
	5100 4700 5100 4900
Wire Wire Line
	5000 2950 5450 2950
Wire Wire Line
	8550 3750 8050 3750
Wire Wire Line
	7650 4050 7650 4150
Wire Notes Line
	9450 4050 9450 3250
Wire Notes Line
	9450 4050 10250 4050
Wire Notes Line
	10250 4050 10250 3250
Wire Notes Line
	10250 3250 9450 3250
Wire Wire Line
	7650 3250 7650 3350
Wire Wire Line
	8050 2950 8550 2950
Wire Wire Line
	7250 3750 6750 3750
Wire Wire Line
	5850 3250 5850 3350
Wire Wire Line
	6750 3750 6750 2950
Connection ~ 6750 2950
Wire Wire Line
	7250 2950 6250 2950
Wire Wire Line
	5100 4800 6100 4800
Wire Wire Line
	6100 4800 6100 4700
Connection ~ 5100 4800
Wire Wire Line
	2350 3250 2550 3250
Wire Wire Line
	3600 3400 3150 3400
Wire Wire Line
	3400 3100 3150 3100
Wire Wire Line
	5100 4200 5100 4300
$Comp
L 5V #PWR03
U 1 1 4E2A2D4E
P 5100 4200
F 0 "#PWR03" H 5100 4300 30  0001 C CNN
F 1 "5V" H 5100 4310 30  0000 C CNN
	1    5100 4200
	1    0    0    -1  
$EndComp
$Comp
L 3V3 #PWR04
U 1 1 4E2A2D4A
P 5600 4200
F 0 "#PWR04" H 5600 4300 30  0001 C CNN
F 1 "3V3" H 5600 4310 30  0000 C CNN
	1    5600 4200
	1    0    0    -1  
$EndComp
$Comp
L 3V3_AN #PWR05
U 1 1 4E2A2D3F
P 6100 4200
F 0 "#PWR05" H 6100 4300 30  0001 C CNN
F 1 "3V3_AN" H 6100 4310 30  0000 C CNN
	1    6100 4200
	1    0    0    -1  
$EndComp
$Comp
L 3V3_AN #PWR06
U 1 1 4E2A2D33
P 8550 3750
F 0 "#PWR06" H 8550 3850 30  0001 C CNN
F 1 "3V3_AN" H 8550 3860 30  0000 C CNN
	1    8550 3750
	1    0    0    -1  
$EndComp
$Comp
L 3V3 #PWR07
U 1 1 4E2A2CED
P 8550 2950
F 0 "#PWR07" H 8550 3050 30  0001 C CNN
F 1 "3V3" H 8550 3060 30  0000 C CNN
	1    8550 2950
	1    0    0    -1  
$EndComp
$Comp
L 5V #PWR08
U 1 1 4E2A2CE6
P 6750 2950
F 0 "#PWR08" H 6750 3050 30  0001 C CNN
F 1 "5V" H 6750 3060 30  0000 C CNN
	1    6750 2950
	1    0    0    -1  
$EndComp
$Comp
L 5V #PWR09
U 1 1 4E2A2CDC
P 3400 3100
F 0 "#PWR09" H 3400 3200 30  0001 C CNN
F 1 "5V" H 3400 3210 30  0000 C CNN
	1    3400 3100
	1    0    0    -1  
$EndComp
Text HLabel 1900 3100 0    60   BiDi ~ 0
VBUS_H
Text HLabel 2000 3400 0    60   BiDi ~ 0
OV_Current
Text HLabel 3600 3400 2    60   BiDi ~ 0
Vbus_EN
Text Label 3600 3400 2    60   ~ 0
Vbus_EN
Text Label 2000 3400 0    60   ~ 0
OV_Current
$Comp
L GND #PWR010
U 1 1 4E221D02
P 2350 3250
F 0 "#PWR010" H 2350 3250 30  0001 C CNN
F 1 "GND" H 2350 3180 30  0001 C CNN
	1    2350 3250
	1    0    0    -1  
$EndComp
Text Label 1900 3100 0    60   ~ 0
OTG_VBUS_H
$Comp
L STMPS2141 U3
U 1 1 4E221BEA
P 2850 3450
F 0 "U3" H 2700 3904 60  0000 C CNN
F 1 "STMPS2141" H 2850 3350 60  0000 C CNN
	1    2850 3450
	1    0    0    -1  
$EndComp
$Comp
L CP1 C18
U 1 1 4E1F183C
P 6100 4500
F 0 "C18" H 6150 4600 50  0000 L CNN
F 1 "47uF" H 6150 4400 50  0000 L CNN
	1    6100 4500
	1    0    0    -1  
$EndComp
$Comp
L CP1 C17
U 1 1 4E1F1839
P 5600 4500
F 0 "C17" H 5650 4600 50  0000 L CNN
F 1 "47uF" H 5650 4400 50  0000 L CNN
	1    5600 4500
	1    0    0    -1  
$EndComp
$Comp
L CP1 C16
U 1 1 4E1F1796
P 5100 4500
F 0 "C16" H 5150 4600 50  0000 L CNN
F 1 "47uF" H 5150 4400 50  0000 L CNN
	1    5100 4500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR011
U 1 1 4E1F177C
P 5100 4900
F 0 "#PWR011" H 5100 4900 30  0001 C CNN
F 1 "GND" H 5100 4830 30  0001 C CNN
	1    5100 4900
	1    0    0    -1  
$EndComp
Text Notes 4650 3200 0    60   ~ 0
Vin -> 7V - 16V
Text Notes 7300 3550 0    60   ~ 0
3V3 REGULATOR
Text Notes 7300 2750 0    60   ~ 0
3V3 REGULATOR
Text Notes 5500 2750 0    60   ~ 0
5V REGULATOR
Text Label 5000 2950 0    60   ~ 0
Vin
$Comp
L GND #PWR012
U 1 1 4E1F1244
P 5850 3350
F 0 "#PWR012" H 5850 3350 30  0001 C CNN
F 1 "GND" H 5850 3280 30  0001 C CNN
	1    5850 3350
	1    0    0    -1  
$EndComp
$Comp
L MCP1703T-5002E U4
U 1 1 4E1F1239
P 5850 3000
F 0 "U4" H 6000 2804 60  0000 C CNN
F 1 "MCP1703T-5002E" H 5850 3200 60  0000 C CNN
	1    5850 3000
	1    0    0    -1  
$EndComp
$Comp
L MCP1703T-3302E U5
U 1 1 4E1F11D5
P 7650 3000
F 0 "U5" H 7800 2804 60  0000 C CNN
F 1 "MCP1703T-3302E" H 7650 3200 60  0000 C CNN
	1    7650 3000
	1    0    0    -1  
$EndComp
$Comp
L MCP1703T-3302E U6
U 1 1 4E1F11CC
P 7650 3800
F 0 "U6" H 7800 3604 60  0000 C CNN
F 1 "MCP1703T-3302E" H 7650 4000 60  0000 C CNN
	1    7650 3800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR013
U 1 1 4E1F07B8
P 7650 4150
F 0 "#PWR013" H 7650 4150 30  0001 C CNN
F 1 "GND" H 7650 4080 30  0001 C CNN
	1    7650 4150
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR014
U 1 1 4E1F07B5
P 7650 3350
F 0 "#PWR014" H 7650 3350 30  0001 C CNN
F 1 "GND" H 7650 3280 30  0001 C CNN
	1    7650 3350
	1    0    0    -1  
$EndComp
Text HLabel 9900 3500 0    60   BiDi ~ 0
Vin
Text Label 9900 3500 0    60   ~ 0
Vin
Text GLabel 9900 3500 0    60   BiDi ~ 0
Vin
$EndSCHEMATC
