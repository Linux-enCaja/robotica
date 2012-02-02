EESchema Schematic File Version 2  date Sat 21 Jan 2012 09:46:46 PM COT
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
LIBS:zxmhc3f381n8
LIBS:i.mx233stamp-cache
EELAYER 25  0
EELAYER END
$Descr User 12000 10000
encoding utf-8
Sheet 2 5
Title ""
Date "22 jan 2012"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L ZXMHC3F381N8 U15
U 1 1 4E8DA297
P 10300 7750
F 0 "U15" H 10600 7850 60  0000 C CNN
F 1 "ZXMHC3F381N8" H 10250 8450 60  0000 C CNN
F 2 "-SO8" H 10300 7750 60  0001 C CNN
	1    10300 7750
	1    0    0    -1  
$EndComp
Text Label 11000 7300 0    60   ~ 0
VMTR4
Text Label 9100 7400 0    60   ~ 0
GMTR4
Text Label 9100 7300 0    60   ~ 0
M41
Text Label 11000 7400 0    60   ~ 0
M42
$Comp
L MOSFET_N_OPENDOUS Q8
U 1 1 4E8DA296
P 10250 6700
F 0 "Q8" H 10250 6890 30  0000 R CNN
F 1 "BS170F" H 10250 6520 30  0000 R CNN
F 2 "BS170F" H 10250 6700 60  0001 C CNN
	1    10250 6700
	0    1    1    0   
$EndComp
$Comp
L R R44
U 1 1 4E8DA295
P 11350 7050
F 0 "R44" V 11430 7050 50  0000 C CNN
F 1 "2.2k" V 11350 7050 50  0000 C CNN
F 2 "SM0603" H 11350 7050 60  0001 C CNN
	1    11350 7050
	-1   0    0    1   
$EndComp
Text Label 9700 6800 0    60   ~ 0
GMTR4
Text Label 9700 7800 0    60   ~ 0
GMTR4
$Comp
L R R45
U 1 1 4E8DA294
P 11350 7550
F 0 "R45" V 11430 7550 50  0000 C CNN
F 1 "2.2k" V 11350 7550 50  0000 C CNN
F 2 "SM0603" H 11350 7550 60  0001 C CNN
	1    11350 7550
	-1   0    0    -1  
$EndComp
$Comp
L MOSFET_N_OPENDOUS Q9
U 1 1 4E8DA293
P 10250 7900
F 0 "Q9" H 10250 8090 30  0000 R CNN
F 1 "BS170F" H 10250 7720 30  0000 R CNN
F 2 "BS170F" H 10250 7900 60  0001 C CNN
	1    10250 7900
	0    1    -1   0   
$EndComp
Text Label 9600 8100 0    60   ~ 0
C2M4
Text Label 9650 6500 0    60   ~ 0
C1M4
$Comp
L CONN_3X2 P14
U 1 1 4E8DA292
P 10400 8600
F 0 "P14" H 10400 8850 50  0000 C CNN
F 1 "CONN_3X2" V 10400 8650 40  0000 C CNN
F 2 "pin_array_3x2" H 10400 8600 60  0001 C CNN
	1    10400 8600
	1    0    0    -1  
$EndComp
Text Label 9650 8650 0    60   ~ 0
C1M4
Text Label 9650 8450 0    60   ~ 0
GMTR4
Text Label 9650 8550 0    60   ~ 0
M41
Text Label 10850 8550 0    60   ~ 0
M42
Text Label 10850 8650 0    60   ~ 0
C2M4
Text Label 10850 8450 0    60   ~ 0
VMTR4
Connection ~ 11100 7800
Wire Wire Line
	11100 7500 11100 7800
Wire Wire Line
	11100 7200 11100 6800
Wire Wire Line
	9400 7200 9550 7200
Wire Wire Line
	9400 8100 9400 7200
Wire Wire Line
	10150 8100 9400 8100
Wire Wire Line
	10950 7500 11100 7500
Wire Wire Line
	10050 7800 9650 7800
Wire Wire Line
	9500 6500 10150 6500
Wire Wire Line
	9500 7500 9550 7500
Wire Wire Line
	10950 7200 11100 7200
Wire Wire Line
	9000 7300 9550 7300
Wire Wire Line
	11350 7300 10950 7300
Wire Wire Line
	9000 7400 9550 7400
Wire Wire Line
	11200 7400 10950 7400
Wire Wire Line
	10050 6800 9650 6800
Wire Wire Line
	11350 6800 10450 6800
Connection ~ 11100 6800
Wire Wire Line
	11350 7800 10450 7800
Wire Wire Line
	9500 7500 9500 6500
Connection ~ 11350 7300
Wire Wire Line
	9650 8450 10000 8450
Wire Wire Line
	9650 8550 10000 8550
Wire Wire Line
	9650 8650 10000 8650
Wire Wire Line
	10800 8650 11200 8650
Wire Wire Line
	10800 8550 11200 8550
Wire Wire Line
	10800 8450 11200 8450
Text Label 2050 7100 0    60   ~ 0
I2C1_SDA
Text Label 2050 7250 0    60   ~ 0
I2C1_SCL
Wire Wire Line
	2550 7250 2000 7250
Wire Wire Line
	3700 8000 3000 8000
Wire Wire Line
	1500 7900 2200 7900
Wire Wire Line
	8650 8400 9050 8400
Wire Wire Line
	8650 8500 9050 8500
Wire Wire Line
	8650 8600 9050 8600
Wire Wire Line
	7500 8600 7850 8600
Wire Wire Line
	7500 8500 7850 8500
Wire Wire Line
	7500 8400 7850 8400
Wire Wire Line
	10600 6150 11000 6150
Wire Wire Line
	10600 6050 11000 6050
Wire Wire Line
	10600 5950 11000 5950
Wire Wire Line
	9450 5950 9800 5950
Wire Wire Line
	9450 6050 9800 6050
Wire Wire Line
	9450 6150 9800 6150
Wire Wire Line
	9000 5950 9400 5950
Wire Wire Line
	9000 6050 9400 6050
Wire Wire Line
	9000 6150 9400 6150
Wire Wire Line
	7850 6150 8200 6150
Wire Wire Line
	7850 6050 8200 6050
Connection ~ 8650 7200
Wire Wire Line
	6800 7400 6800 6400
Wire Wire Line
	8650 7700 7750 7700
Connection ~ 8400 6700
Wire Wire Line
	8650 6700 7750 6700
Wire Wire Line
	7350 6700 6950 6700
Wire Wire Line
	8500 7300 8250 7300
Wire Wire Line
	6300 7300 6850 7300
Wire Wire Line
	8650 7200 8250 7200
Wire Wire Line
	6300 7200 6850 7200
Wire Wire Line
	8250 7100 8400 7100
Wire Wire Line
	6800 7400 6850 7400
Wire Wire Line
	6800 6400 7450 6400
Wire Wire Line
	7350 7700 6950 7700
Wire Wire Line
	8250 7400 8400 7400
Wire Wire Line
	7450 8000 6700 8000
Wire Wire Line
	6700 8000 6700 7100
Wire Wire Line
	6700 7100 6850 7100
Wire Wire Line
	8400 7100 8400 6700
Wire Wire Line
	8400 7400 8400 7700
Connection ~ 8400 7700
Connection ~ 11150 5300
Wire Wire Line
	11150 5300 11150 5000
Wire Wire Line
	11150 4300 11150 4700
Wire Wire Line
	9600 4700 9450 4700
Wire Wire Line
	9450 4700 9450 5600
Wire Wire Line
	9450 5600 10200 5600
Wire Wire Line
	11150 5000 11000 5000
Wire Wire Line
	10100 5300 9700 5300
Wire Wire Line
	10200 4000 9550 4000
Wire Wire Line
	9600 5000 9550 5000
Wire Wire Line
	11150 4700 11000 4700
Wire Wire Line
	9050 4800 9600 4800
Wire Wire Line
	11400 4800 11000 4800
Wire Wire Line
	9050 4900 9600 4900
Wire Wire Line
	11250 4900 11000 4900
Wire Wire Line
	10100 4300 9700 4300
Wire Wire Line
	11400 4300 10500 4300
Connection ~ 11150 4300
Wire Wire Line
	11400 5300 10500 5300
Wire Wire Line
	9550 5000 9550 4000
Connection ~ 11400 4800
Connection ~ 8900 4800
Wire Wire Line
	7050 5000 7050 4000
Wire Wire Line
	8900 5300 8000 5300
Connection ~ 8650 4300
Wire Wire Line
	8900 4300 8000 4300
Wire Wire Line
	7600 4300 7200 4300
Wire Wire Line
	8750 4900 8500 4900
Wire Wire Line
	6550 4900 7100 4900
Wire Wire Line
	1500 8200 2200 8200
Wire Wire Line
	7000 1050 6700 1050
Connection ~ 8150 1050
Wire Wire Line
	7650 1050 8150 1050
Wire Wire Line
	7750 1550 7750 1650
Connection ~ 7750 1050
Connection ~ 7750 1150
Wire Wire Line
	8150 1150 8150 900 
Wire Wire Line
	7650 1150 7750 1150
Wire Wire Line
	1000 2050 1000 2300
Wire Wire Line
	1000 2050 1150 2050
Wire Wire Line
	6650 2300 5750 2300
Wire Wire Line
	6650 2200 5750 2200
Wire Wire Line
	6650 4500 5750 4500
Wire Wire Line
	6650 4300 5750 4300
Wire Wire Line
	6650 4100 5750 4100
Wire Wire Line
	8550 2800 8550 2700
Wire Wire Line
	8550 2700 6950 2700
Wire Wire Line
	11350 2250 11350 2150
Wire Wire Line
	10750 2850 11050 2850
Wire Wire Line
	10750 2850 10750 2750
Wire Wire Line
	10750 2250 10750 2150
Wire Wire Line
	11350 2150 11050 2150
Wire Wire Line
	11350 2850 11350 2750
Wire Wire Line
	8550 2150 8550 2300
Wire Wire Line
	8550 2300 8700 2300
Wire Wire Line
	5300 7300 5300 7400
Wire Wire Line
	4300 7300 4000 7300
Connection ~ 7300 2300
Connection ~ 7650 2300
Connection ~ 4150 1250
Wire Wire Line
	4150 1250 4150 1100
Connection ~ 4100 1250
Wire Wire Line
	8750 1000 9200 1000
Wire Wire Line
	8650 1200 8500 1200
Wire Wire Line
	8500 1200 8500 1500
Wire Wire Line
	8500 1500 8600 1500
Wire Wire Line
	2800 6100 950  6100
Wire Wire Line
	2800 5300 950  5300
Wire Wire Line
	950  5900 2800 5900
Wire Wire Line
	950  5650 2800 5650
Wire Wire Line
	950  4850 2800 4850
Wire Wire Line
	950  4750 2800 4750
Wire Wire Line
	950  4950 2800 4950
Wire Wire Line
	950  5200 2800 5200
Wire Wire Line
	950  5550 2800 5550
Wire Wire Line
	950  6000 2800 6000
Wire Wire Line
	950  6550 2800 6550
Wire Wire Line
	2800 4650 950  4650
Wire Wire Line
	6650 3450 5750 3450
Wire Wire Line
	6650 3250 5750 3250
Wire Wire Line
	2800 2650 950  2650
Wire Wire Line
	6100 6400 5750 6400
Wire Wire Line
	6100 6200 5750 6200
Wire Wire Line
	5750 6000 6100 6000
Connection ~ 4100 7300
Connection ~ 4200 7300
Wire Wire Line
	10400 2850 10400 2750
Wire Wire Line
	10100 2150 10400 2150
Connection ~ 8000 2700
Connection ~ 6950 2700
Connection ~ 7300 2700
Wire Wire Line
	950  4150 2800 4150
Wire Wire Line
	950  3950 2800 3950
Wire Wire Line
	950  3750 2800 3750
Wire Wire Line
	950  3550 2800 3550
Wire Wire Line
	950  3350 2800 3350
Wire Wire Line
	950  3150 2800 3150
Wire Wire Line
	950  2950 2800 2950
Wire Wire Line
	950  2750 2800 2750
Wire Wire Line
	2500 1900 2800 1900
Wire Wire Line
	8350 2150 8350 2300
Connection ~ 9650 2700
Wire Wire Line
	9650 2800 9650 2700
Wire Wire Line
	4500 7200 4500 7300
Wire Wire Line
	4300 7200 4300 7400
Wire Wire Line
	4100 7200 4100 7300
Wire Wire Line
	4000 7300 4000 7200
Wire Wire Line
	4200 7300 4200 7200
Wire Wire Line
	4500 900  4500 1250
Wire Wire Line
	2500 2400 2800 2400
Connection ~ 900  1900
Wire Wire Line
	700  2050 700  1900
Wire Wire Line
	700  1900 900  1900
Wire Wire Line
	1000 2300 900  2300
Wire Wire Line
	900  2300 900  1700
Wire Wire Line
	900  1700 1000 1700
Wire Wire Line
	2500 1800 2800 1800
Wire Wire Line
	950  2850 2800 2850
Wire Wire Line
	950  3450 2800 3450
Wire Wire Line
	950  3650 2800 3650
Wire Wire Line
	950  3850 2800 3850
Wire Wire Line
	2800 2200 1950 2200
Wire Wire Line
	1950 2200 1950 1700
Wire Wire Line
	4700 1150 4700 1250
Wire Wire Line
	1950 1700 1400 1700
Connection ~ 1550 1700
Connection ~ 1550 2300
Connection ~ 7650 2700
Connection ~ 8350 2700
Connection ~ 9450 2700
Wire Wire Line
	10400 2150 10400 2250
Connection ~ 4300 7300
Wire Wire Line
	1400 2300 2800 2300
Wire Wire Line
	6100 6100 5750 6100
Wire Wire Line
	6100 6300 5750 6300
Wire Wire Line
	2800 3050 950  3050
Wire Wire Line
	2800 3250 950  3250
Wire Wire Line
	2800 4050 950  4050
Wire Wire Line
	6650 3150 5750 3150
Wire Wire Line
	5750 3350 6650 3350
Wire Wire Line
	5750 3750 6650 3750
Wire Wire Line
	6650 3550 5750 3550
Wire Wire Line
	6650 3650 5750 3650
Wire Wire Line
	6650 3850 5750 3850
Wire Wire Line
	9250 1500 9100 1500
Wire Wire Line
	9200 1000 9200 1200
Wire Wire Line
	9200 1200 9050 1200
Wire Wire Line
	10350 1200 10500 1200
Wire Wire Line
	10500 1200 10500 1000
Wire Wire Line
	10500 1000 9900 1000
Wire Wire Line
	10550 1500 10400 1500
Wire Wire Line
	9900 1500 9800 1500
Wire Wire Line
	9800 1500 9800 1200
Wire Wire Line
	9800 1200 9950 1200
Wire Wire Line
	4300 1250 4000 1250
Connection ~ 4200 1250
Connection ~ 6950 2300
Connection ~ 8000 2300
Wire Wire Line
	9450 2700 9850 2700
Wire Wire Line
	4500 7300 4700 7300
Wire Wire Line
	9300 2300 9850 2300
Connection ~ 9450 2300
Wire Wire Line
	11050 2150 11050 2850
Wire Wire Line
	6650 4200 5750 4200
Wire Wire Line
	6650 4400 5750 4400
Wire Wire Line
	1150 1950 1000 1950
Wire Wire Line
	1000 1950 1000 1700
Wire Wire Line
	6900 1250 6900 1150
Wire Wire Line
	6900 1150 7000 1150
Wire Wire Line
	7750 1150 7750 1050
Wire Wire Line
	8150 1550 8150 1650
Wire Wire Line
	6700 1550 6700 1650
Wire Wire Line
	6700 1000 6700 1150
Connection ~ 6700 1050
Wire Wire Line
	1500 8100 2200 8100
Wire Wire Line
	1500 8300 2200 8300
Wire Wire Line
	1500 8700 2200 8700
Wire Wire Line
	1500 8500 2200 8500
Wire Wire Line
	1500 8400 2200 8400
Wire Wire Line
	1500 8600 2200 8600
Wire Wire Line
	3000 8700 3700 8700
Wire Wire Line
	3000 8500 3700 8500
Wire Wire Line
	3000 8600 3700 8600
Wire Wire Line
	3000 8800 3700 8800
Wire Wire Line
	3000 8400 3700 8400
Wire Wire Line
	3000 8200 3700 8200
Wire Wire Line
	3000 8100 3700 8100
Wire Wire Line
	3000 8300 3700 8300
Wire Wire Line
	1500 8800 2200 8800
Wire Wire Line
	1500 8900 2200 8900
Wire Wire Line
	3000 9000 3700 9000
Wire Wire Line
	3000 8900 3700 8900
Wire Wire Line
	1500 9000 2200 9000
Wire Wire Line
	3850 8750 4550 8750
Wire Wire Line
	3850 8650 4550 8650
Wire Wire Line
	3850 8550 4550 8550
Wire Wire Line
	3850 8350 4550 8350
Wire Wire Line
	3850 8150 4550 8150
Wire Wire Line
	3850 8250 4550 8250
Wire Wire Line
	3850 8450 4550 8450
Wire Wire Line
	3850 8050 4550 8050
Wire Wire Line
	3850 7850 4550 7850
Wire Wire Line
	3850 7950 4550 7950
Wire Wire Line
	5350 8650 6050 8650
Wire Wire Line
	5350 8050 6050 8050
Wire Wire Line
	5350 7850 6050 7850
Wire Wire Line
	5350 7950 6050 7950
Wire Wire Line
	5350 8150 6050 8150
Wire Wire Line
	5350 8550 6050 8550
Wire Wire Line
	5350 8350 6050 8350
Wire Wire Line
	5350 8250 6050 8250
Wire Wire Line
	5350 8450 6050 8450
Wire Wire Line
	3850 8850 4550 8850
Wire Wire Line
	3850 8950 4550 8950
Wire Wire Line
	5350 8750 6050 8750
Wire Wire Line
	5350 8850 6050 8850
Wire Wire Line
	5350 8950 6050 8950
Wire Wire Line
	8350 2300 6950 2300
Wire Wire Line
	8900 4800 8500 4800
Wire Wire Line
	6550 4800 7100 4800
Wire Wire Line
	8500 4700 8650 4700
Wire Wire Line
	7050 5000 7100 5000
Wire Wire Line
	7050 4000 7700 4000
Wire Wire Line
	7600 5300 7200 5300
Wire Wire Line
	8500 5000 8650 5000
Wire Wire Line
	7700 5600 6950 5600
Wire Wire Line
	6950 5600 6950 4700
Wire Wire Line
	6950 4700 7100 4700
Wire Wire Line
	8650 4700 8650 4300
Wire Wire Line
	8650 5000 8650 5300
Connection ~ 8650 5300
Wire Wire Line
	7850 5950 8200 5950
Wire Wire Line
	1500 8000 2200 8000
Wire Wire Line
	3700 7900 3000 7900
Wire Wire Line
	2550 7100 2000 7100
Text HLabel 2000 7250 0    60   BiDi ~ 0
I2C1_SCL
Text HLabel 2000 7100 0    60   BiDi ~ 0
I2C1_SDA
Text Label 1800 8300 0    60   ~ 0
I2C1_SCL
Text Label 3400 8400 0    60   ~ 0
I2C1_SDA
$Comp
L 3V3 #PWR8
U 1 1 4E8A099D
P 6050 8950
F 0 "#PWR8" H 6050 9050 30  0001 C CNN
F 1 "3V3" H 6050 9060 30  0000 C CNN
	1    6050 8950
	0    1    1    0   
$EndComp
$Comp
L 3V3 #PWR3
U 1 1 4E8A0997
P 3700 7900
F 0 "#PWR3" H 3700 8000 30  0001 C CNN
F 1 "3V3" H 3700 8010 30  0000 C CNN
	1    3700 7900
	1    0    0    -1  
$EndComp
$Comp
L 3V3 #PWR2
U 1 1 4E8A0992
P 1500 7900
F 0 "#PWR2" H 1500 8000 30  0001 C CNN
F 1 "3V3" H 1500 8010 30  0000 C CNN
	1    1500 7900
	1    0    0    -1  
$EndComp
Text Label 4000 8950 0    60   ~ 0
GND
Text Label 3200 8000 0    60   ~ 0
GND
Text Label 1650 8000 0    60   ~ 0
GND
Text Label 8700 8400 0    60   ~ 0
VMTR3
Text Label 8700 8600 0    60   ~ 0
C2M3
Text Label 8700 8500 0    60   ~ 0
M32
Text Label 7500 8500 0    60   ~ 0
M31
Text Label 7500 8400 0    60   ~ 0
GMTR3
Text Label 7500 8600 0    60   ~ 0
C1M3
Text Label 10650 6050 0    60   ~ 0
M22
Text Label 10650 6150 0    60   ~ 0
C2M2
Text Label 10650 5950 0    60   ~ 0
VMTR2
Text Label 9450 6150 0    60   ~ 0
C1M2
Text Label 9450 5950 0    60   ~ 0
GMTR2
Text Label 9450 6050 0    60   ~ 0
M21
Text Label 9050 6050 0    60   ~ 0
M12
Text Label 7850 6050 0    60   ~ 0
M11
Text Label 9050 5950 0    60   ~ 0
VMTR1
Text Label 7850 5950 0    60   ~ 0
GMTR1
Text Label 9050 6150 0    60   ~ 0
C2M1
Text Label 7850 6150 0    60   ~ 0
C1M1
$Comp
L CONN_3X2 P13
U 1 1 4E88DB7E
P 8250 8550
F 0 "P13" H 8250 8800 50  0000 C CNN
F 1 "CONN_3X2" V 8250 8600 40  0000 C CNN
F 2 "pin_array_3x2" H 8250 8550 60  0001 C CNN
	1    8250 8550
	1    0    0    -1  
$EndComp
$Comp
L CONN_3X2 P12
U 1 1 4E88DB78
P 10200 6100
F 0 "P12" H 10200 6350 50  0000 C CNN
F 1 "CONN_3X2" V 10200 6150 40  0000 C CNN
F 2 "pin_array_3x2" H 10200 6100 60  0001 C CNN
	1    10200 6100
	1    0    0    -1  
$EndComp
$Comp
L CONN_3X2 P11
U 1 1 4E88DB6E
P 8600 6100
F 0 "P11" H 8600 6350 50  0000 C CNN
F 1 "CONN_3X2" V 8600 6150 40  0000 C CNN
F 2 "pin_array_3x2" H 8600 6100 60  0001 C CNN
	1    8600 6100
	1    0    0    -1  
$EndComp
Text Label 6950 6400 0    60   ~ 0
C1M3
Text Label 6900 8000 0    60   ~ 0
C2M3
Text Label 9650 5600 0    60   ~ 0
C2M2
Text Label 9650 4000 0    60   ~ 0
C1M2
Text Label 7200 5600 0    60   ~ 0
C2M1
Text Label 7200 4000 0    60   ~ 0
C1M1
$Comp
L MOSFET_N_OPENDOUS Q7
U 1 1 4E876537
P 7550 7800
F 0 "Q7" H 7550 7990 30  0000 R CNN
F 1 "BS170F" H 7550 7620 30  0000 R CNN
F 2 "BS170F" H 7550 7800 60  0001 C CNN
	1    7550 7800
	0    1    -1   0   
$EndComp
$Comp
L R R41
U 1 1 4E876536
P 8650 7450
F 0 "R41" V 8730 7450 50  0000 C CNN
F 1 "2.2k" V 8650 7450 50  0000 C CNN
F 2 "SM0603" H 8650 7450 60  0001 C CNN
	1    8650 7450
	-1   0    0    -1  
$EndComp
Text Label 7000 7700 0    60   ~ 0
GMTR3
Text Label 7000 6700 0    60   ~ 0
GMTR3
$Comp
L R R40
U 1 1 4E876535
P 8650 6950
F 0 "R40" V 8730 6950 50  0000 C CNN
F 1 "2.2k" V 8650 6950 50  0000 C CNN
F 2 "SM0603" H 8650 6950 60  0001 C CNN
	1    8650 6950
	-1   0    0    1   
$EndComp
$Comp
L MOSFET_N_OPENDOUS Q6
U 1 1 4E876534
P 7550 6600
F 0 "Q6" H 7550 6790 30  0000 R CNN
F 1 "BS170F" H 7550 6420 30  0000 R CNN
F 2 "BS170F" H 7550 6600 60  0001 C CNN
	1    7550 6600
	0    1    1    0   
$EndComp
Text Label 8300 7300 0    60   ~ 0
M32
Text Label 6400 7200 0    60   ~ 0
M31
Text Label 6400 7300 0    60   ~ 0
GMTR3
Text Label 8300 7200 0    60   ~ 0
VMTR3
$Comp
L ZXMHC3F381N8 U14
U 1 1 4E876533
P 7600 7650
F 0 "U14" H 7850 7750 60  0000 C CNN
F 1 "ZXMHC3F381N8" H 7550 8350 60  0000 C CNN
F 2 "-SO8" H 7600 7650 60  0001 C CNN
	1    7600 7650
	1    0    0    -1  
$EndComp
$Comp
L ZXMHC3F381N8 U13
U 1 1 4E8763E8
P 10350 5250
F 0 "U13" H 10650 5350 60  0000 C CNN
F 1 "ZXMHC3F381N8" H 10300 5950 60  0000 C CNN
F 2 "-SO8" H 10350 5250 60  0001 C CNN
	1    10350 5250
	1    0    0    -1  
$EndComp
Text Label 11050 4800 0    60   ~ 0
VMTR2
Text Label 9150 4900 0    60   ~ 0
GMTR2
Text Label 9150 4800 0    60   ~ 0
M21
Text Label 11050 4900 0    60   ~ 0
M22
$Comp
L MOSFET_N_OPENDOUS Q4
U 1 1 4E8763E7
P 10300 4200
F 0 "Q4" H 10300 4390 30  0000 R CNN
F 1 "BS170F" H 10300 4020 30  0000 R CNN
F 2 "BS170F" H 10300 4200 60  0001 C CNN
	1    10300 4200
	0    1    1    0   
$EndComp
$Comp
L R R38
U 1 1 4E8763E6
P 11400 4550
F 0 "R38" V 11480 4550 50  0000 C CNN
F 1 "2.2k" V 11400 4550 50  0000 C CNN
F 2 "SM0603" H 11400 4550 60  0001 C CNN
	1    11400 4550
	-1   0    0    1   
$EndComp
Text Label 9750 4300 0    60   ~ 0
GMTR2
Text Label 9750 5300 0    60   ~ 0
GMTR2
$Comp
L R R39
U 1 1 4E8763E5
P 11400 5050
F 0 "R39" V 11480 5050 50  0000 C CNN
F 1 "2.2k" V 11400 5050 50  0000 C CNN
F 2 "SM0603" H 11400 5050 60  0001 C CNN
	1    11400 5050
	-1   0    0    -1  
$EndComp
$Comp
L MOSFET_N_OPENDOUS Q5
U 1 1 4E8763E4
P 10300 5400
F 0 "Q5" H 10300 5590 30  0000 R CNN
F 1 "BS170F" H 10300 5220 30  0000 R CNN
F 2 "BS170F" H 10300 5400 60  0001 C CNN
	1    10300 5400
	0    1    -1   0   
$EndComp
$Comp
L MOSFET_N_OPENDOUS Q3
U 1 1 4E8758ED
P 7800 5400
F 0 "Q3" H 7800 5590 30  0000 R CNN
F 1 "BS170F" H 7800 5220 30  0000 R CNN
F 2 "BS170F" H 7800 5400 60  0001 C CNN
	1    7800 5400
	0    1    -1   0   
$EndComp
$Comp
L R R37
U 1 1 4E8758EC
P 8900 5050
F 0 "R37" V 8980 5050 50  0000 C CNN
F 1 "2.2k" V 8900 5050 50  0000 C CNN
F 2 "SM0603" H 8900 5050 60  0001 C CNN
	1    8900 5050
	-1   0    0    -1  
$EndComp
Text Label 7250 5300 0    60   ~ 0
GMTR1
Text Label 7250 4300 0    60   ~ 0
GMTR1
$Comp
L R R35
U 1 1 4E8756FC
P 8900 4550
F 0 "R35" V 8980 4550 50  0000 C CNN
F 1 "2.2k" V 8900 4550 50  0000 C CNN
F 2 "SM0603" H 8900 4550 60  0001 C CNN
	1    8900 4550
	-1   0    0    1   
$EndComp
$Comp
L MOSFET_N_OPENDOUS Q2
U 1 1 4E8755B4
P 7800 4200
F 0 "Q2" H 7800 4390 30  0000 R CNN
F 1 "BS170F" H 7800 4020 30  0000 R CNN
F 2 "BS170F" H 7800 4200 60  0001 C CNN
	1    7800 4200
	0    1    1    0   
$EndComp
Text Label 8550 4900 0    60   ~ 0
M12
Text Label 6650 4800 0    60   ~ 0
M11
Text Label 6650 4900 0    60   ~ 0
GMTR1
Text Label 8550 4800 0    60   ~ 0
VMTR1
$Comp
L ZXMHC3F381N8 U12
U 1 1 4E85F567
P 7850 5250
F 0 "U12" H 8100 5350 60  0000 C CNN
F 1 "ZXMHC3F381N8" H 7800 5950 60  0000 C CNN
F 2 "-SO8" H 7850 5250 60  0001 C CNN
	1    7850 5250
	1    0    0    -1  
$EndComp
Text Label 5550 8850 0    60   ~ 0
FP37
Text Label 5550 8750 0    60   ~ 0
FP39
Text Label 4000 8850 0    60   ~ 0
FP38
Text Label 5550 8650 0    60   ~ 0
FP23
Text Label 5550 7850 0    60   ~ 0
FP5
Text Label 5550 7950 0    60   ~ 0
FP7
Text Label 5550 8050 0    60   ~ 0
FP15
Text Label 5550 8150 0    60   ~ 0
FP9
Text Label 5550 8250 0    60   ~ 0
FP29
Text Label 5550 8350 0    60   ~ 0
FP34
Text Label 5550 8450 0    60   ~ 0
FP32
Text Label 5550 8550 0    60   ~ 0
FP21
Text Label 4000 7950 0    60   ~ 0
FP6
Text Label 4000 8050 0    60   ~ 0
FP14
Text Label 4000 8150 0    60   ~ 0
FP8
Text Label 4000 8250 0    60   ~ 0
FP28
Text Label 4000 8350 0    60   ~ 0
FP17
Text Label 4000 8450 0    60   ~ 0
FP33
Text Label 4000 8550 0    60   ~ 0
FP20
Text Label 4000 8650 0    60   ~ 0
FP22
Text Label 4000 8750 0    60   ~ 0
FP40
Text Label 4000 7850 0    60   ~ 0
FP4
Text Label 3200 9000 0    60   ~ 0
FP2
Text Label 3200 8900 0    60   ~ 0
FP0
Text Label 3200 8800 0    60   ~ 0
FP12
Text Label 3200 8700 0    60   ~ 0
FP10
Text Label 3200 8600 0    60   ~ 0
FP41
Text Label 3200 8500 0    60   ~ 0
FP27
Text Label 3050 8400 0    60   ~ 0
FP25
Text Label 3200 8300 0    60   ~ 0
FP19
Text Label 3200 8200 0    60   ~ 0
FP18
Text Label 1650 8100 0    60   ~ 0
FP31
Text Label 1650 9000 0    60   ~ 0
FP3
Text Label 1650 8900 0    60   ~ 0
FP1
Text Label 1650 8800 0    60   ~ 0
FP13
Text Label 1650 8700 0    60   ~ 0
FP11
Text Label 1650 8600 0    60   ~ 0
FP42
Text Label 1650 8500 0    60   ~ 0
FP35
Text Label 1650 8400 0    60   ~ 0
FP26
Text Label 1550 8300 0    60   ~ 0
FP24
Text Label 1650 8200 0    60   ~ 0
FP16
Text Label 3200 8100 0    60   ~ 0
FP30
$Comp
L CONN_12X2 P9
U 1 1 4E831B93
P 4950 8400
F 0 "P9" H 4950 9050 60  0000 C CNN
F 1 "CONN_12X2" V 4950 8400 50  0000 C CNN
F 2 "pin_array_12x2" H 4950 8400 60  0001 C CNN
	1    4950 8400
	1    0    0    -1  
$EndComp
$Comp
L CONN_12X2 P8
U 1 1 4E831B8F
P 2600 8450
F 0 "P8" H 2600 9100 60  0000 C CNN
F 1 "CONN_12X2" V 2600 8450 50  0000 C CNN
F 2 "pin_array_12x2" H 2600 8450 60  0001 C CNN
	1    2600 8450
	1    0    0    -1  
$EndComp
$Comp
L VDD5V #PWR9
U 1 1 4E7B5061
P 6700 1000
F 0 "#PWR9" H 6700 1100 30  0001 C CNN
F 1 "VDD5V" H 6700 1100 30  0000 C CNN
	1    6700 1000
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR10
U 1 1 4E7B4E89
P 6700 1650
F 0 "#PWR10" H 6700 1650 30  0001 C CNN
F 1 "GND" H 6700 1580 30  0001 C CNN
	1    6700 1650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR14
U 1 1 4E7B4E84
P 8150 1650
F 0 "#PWR14" H 8150 1650 30  0001 C CNN
F 1 "GND" H 8150 1580 30  0001 C CNN
	1    8150 1650
	1    0    0    -1  
$EndComp
$Comp
L C C76
U 1 1 4E7B4A85
P 8150 1350
F 0 "C76" H 8200 1450 50  0000 L CNN
F 1 "33uF" H 8200 1250 50  0000 L CNN
F 2 "SM1206" H 8150 1350 60  0001 C CNN
	1    8150 1350
	1    0    0    -1  
$EndComp
$Comp
L C C74
U 1 1 4E7B4A81
P 6700 1350
F 0 "C74" H 6750 1450 50  0000 L CNN
F 1 "33uF" H 6750 1250 50  0000 L CNN
F 2 "SM1206" H 6700 1350 60  0001 C CNN
	1    6700 1350
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR12
U 1 1 4E7B44BE
P 7750 1650
F 0 "#PWR12" H 7750 1650 30  0001 C CNN
F 1 "GND" H 7750 1580 30  0001 C CNN
	1    7750 1650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR11
U 1 1 4E7B44A2
P 6900 1250
F 0 "#PWR11" H 6900 1250 30  0001 C CNN
F 1 "GND" H 6900 1180 30  0001 C CNN
	1    6900 1250
	1    0    0    -1  
$EndComp
$Comp
L 3V3 #PWR13
U 1 1 4E7B4482
P 8150 900
F 0 "#PWR13" H 8150 1000 30  0001 C CNN
F 1 "3V3" H 8150 1010 30  0000 C CNN
	1    8150 900 
	1    0    0    -1  
$EndComp
$Comp
L LT1117CST U11
U 1 1 4E7B41E9
P 7350 1250
F 0 "U11" H 7200 1550 60  0000 C CNN
F 1 "LT1117CST-3.3" H 7350 1250 40  0000 C CNN
F 2 "LT1117" H 7350 1250 60  0001 C CNN
	1    7350 1250
	1    0    0    -1  
$EndComp
$Comp
L C C75
U 1 1 4E7B41E8
P 7750 1350
F 0 "C75" H 7800 1450 50  0000 L CNN
F 1 "100n" H 7800 1250 50  0000 L CNN
F 2 "SM0603" H 7750 1350 60  0001 C CNN
	1    7750 1350
	1    0    0    -1  
$EndComp
$Comp
L ABM8G X3
U 1 1 4E7A2D7B
P 1550 2000
F 0 "X3" H 1550 2150 60  0000 C CNN
F 1 "8MHz" H 1550 1850 60  0000 C CNN
F 2 "ABM3B" H 1550 2000 60  0001 C CNN
	1    1550 2000
	0    1    1    0   
$EndComp
Text Label 6000 2300 0    60   ~ 0
FP42
Text Label 6000 2200 0    60   ~ 0
FP41
Text Label 5950 4500 0    60   ~ 0
FP40
Text Label 5950 4400 0    60   ~ 0
FP39
Text Label 5950 4300 0    60   ~ 0
FP38
Text Label 5950 4200 0    60   ~ 0
FP37
Text Label 5950 4100 0    60   ~ 0
FP36
$Comp
L R R27
U 1 1 4E079478
P 10400 2500
F 0 "R27" V 10480 2500 50  0000 C CNN
F 1 "10k" V 10400 2500 50  0000 C CNN
F 2 "SM0603" H 10400 2500 60  0001 C CNN
	1    10400 2500
	-1   0    0    1   
$EndComp
Text HLabel 2500 1800 0    60   BiDi ~ 0
BOOT0
Text Notes 9700 3050 0    60   ~ 0
El procesador selecciona si inicia por \nla flash o ram internas.\nSe debe soldar solo R26 o R34\n\n
$Comp
L GND #PWR24
U 1 1 4E78C5F4
P 11350 2850
F 0 "#PWR24" H 11350 2850 30  0001 C CNN
F 1 "GND" H 11350 2780 30  0001 C CNN
	1    11350 2850
	1    0    0    -1  
$EndComp
Text Label 11350 2150 2    60   ~ 0
BOOT1
$Comp
L R R26
U 1 1 4E78C5F2
P 10750 2500
F 0 "R26" V 10830 2500 50  0000 C CNN
F 1 "510" V 10750 2500 50  0000 C CNN
F 2 "SM0603" H 10750 2500 60  0001 C CNN
	1    10750 2500
	-1   0    0    1   
$EndComp
$Comp
L R R34
U 1 1 4E78C5F1
P 11350 2500
F 0 "R34" V 11430 2500 50  0000 C CNN
F 1 "10k" V 11350 2500 50  0000 C CNN
F 2 "SM0603" H 11350 2500 60  0001 C CNN
	1    11350 2500
	-1   0    0    1   
$EndComp
$Comp
L 3V3 #PWR23
U 1 1 4E78C5F0
P 10750 2150
F 0 "#PWR23" H 10750 2250 30  0001 C CNN
F 1 "3V3" H 10750 2260 30  0000 C CNN
	1    10750 2150
	1    0    0    -1  
$EndComp
$Comp
L 3V3 #PWR16
U 1 1 4E78C319
P 8550 2150
F 0 "#PWR16" H 8550 2250 30  0001 C CNN
F 1 "3V3" H 8550 2260 30  0000 C CNN
	1    8550 2150
	1    0    0    -1  
$EndComp
$Comp
L INDUCTOR L15
U 1 1 4E78C307
P 9000 2300
F 0 "L15" V 8950 2300 40  0000 C CNN
F 1 "2A 120 ohm" V 9100 2300 40  0000 C CNN
F 2 "SM0805" H 9000 2300 60  0001 C CNN
	1    9000 2300
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR7
U 1 1 4E78C2ED
P 5300 7400
F 0 "#PWR7" H 5300 7400 30  0001 C CNN
F 1 "GND" H 5300 7330 30  0001 C CNN
	1    5300 7400
	1    0    0    -1  
$EndComp
$Comp
L INDUCTOR L14
U 1 1 4E78C2C1
P 5000 7300
F 0 "L14" V 4950 7300 40  0000 C CNN
F 1 "2A 120 ohm" V 5100 7300 40  0000 C CNN
F 2 "SM0805" H 5000 7300 60  0001 C CNN
	1    5000 7300
	0    1    1    0   
$EndComp
Text HLabel 6100 6400 2    60   BiDi ~ 0
JNRST
Text HLabel 6100 6200 2    60   BiDi ~ 0
JTMS
Text HLabel 6100 6100 2    60   BiDi ~ 0
JTCK
Text HLabel 6100 6300 2    60   BiDi ~ 0
JTDO
Text HLabel 6100 6000 2    60   BiDi ~ 0
JTDI
$Comp
L 3V3 #PWR4
U 1 1 4E78BA06
P 4150 1100
F 0 "#PWR4" H 4150 1200 30  0001 C CNN
F 1 "3V3" H 4150 1210 30  0000 C CNN
	1    4150 1100
	1    0    0    -1  
$EndComp
$Comp
L CP1 C59
U 1 1 4E2DF30C
P 8350 2500
F 0 "C59" H 8400 2600 50  0000 L CNN
F 1 "10uF Tant." H 8400 2400 50  0000 L CNN
F 2 "SM1206" H 8350 2500 60  0001 C CNN
	1    8350 2500
	1    0    0    -1  
$EndComp
$Comp
L 3V3 #PWR15
U 1 1 4E2A2E11
P 8350 2150
F 0 "#PWR15" H 8350 2250 30  0001 C CNN
F 1 "3V3" H 8350 2260 30  0000 C CNN
	1    8350 2150
	1    0    0    -1  
$EndComp
$Comp
L 3V3 #PWR18
U 1 1 4E2A2E03
P 8750 1000
F 0 "#PWR18" H 8750 1100 30  0001 C CNN
F 1 "3V3" H 8750 1110 30  0000 C CNN
	1    8750 1000
	1    0    0    -1  
$EndComp
$Comp
L 3V3 #PWR6
U 1 1 4E2A2DF0
P 4700 1150
F 0 "#PWR6" H 4700 1250 30  0001 C CNN
F 1 "3V3" H 4700 1260 30  0000 C CNN
	1    4700 1150
	1    0    0    -1  
$EndComp
Text HLabel 2500 2400 0    60   BiDi ~ 0
RESET
$Comp
L R R33
U 1 1 4E188E50
P 10150 1500
F 0 "R33" V 10230 1500 50  0000 C CNN
F 1 "1k" V 10150 1500 50  0000 C CNN
F 2 "SM0603" H 10150 1500 60  0001 C CNN
	1    10150 1500
	0    1    1    0   
$EndComp
$Comp
L LED D9
U 1 1 4E188E4F
P 10150 1200
F 0 "D9" H 10150 1300 50  0000 C CNN
F 1 "LED" H 10150 1100 50  0000 C CNN
F 2 "SM0603" H 10150 1200 60  0001 C CNN
	1    10150 1200
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR22
U 1 1 4E188E4E
P 10550 1500
F 0 "#PWR22" H 10550 1500 30  0001 C CNN
F 1 "GND" H 10550 1430 30  0001 C CNN
	1    10550 1500
	0    -1   1    0   
$EndComp
Text Label 9900 1000 0    60   ~ 0
FP16
Text Label 8850 1000 0    60   ~ 0
POWER
Text Label 1000 4650 0    60   ~ 0
FP24
Text Label 1000 4750 0    60   ~ 0
FP25
Text Label 1000 4850 0    60   ~ 0
FP26
Text Label 1000 4950 0    60   ~ 0
FP27
Text Label 1000 5200 0    60   ~ 0
FP28
Text Label 1000 5300 0    60   ~ 0
FP29
Text Label 1000 5550 0    60   ~ 0
FP30
Text Label 1000 5650 0    60   ~ 0
FP31
Text Label 1000 5900 0    60   ~ 0
FP32
Text Label 1000 6000 0    60   ~ 0
FP33
Text Label 1000 6100 0    60   ~ 0
FP34
Text Label 1000 6550 0    60   ~ 0
FP35
Text Label 5950 3550 0    60   ~ 0
FP20
Text Label 5950 3650 0    60   ~ 0
FP21
Text Label 5950 3750 0    60   ~ 0
FP22
Text Label 5950 3850 0    60   ~ 0
FP23
Text Label 5950 3450 0    60   ~ 0
FP19
Text Label 5950 3350 0    60   ~ 0
FP18
Text Label 5950 3250 0    60   ~ 0
FP17
Text Label 5950 3150 0    60   ~ 0
FP16
Text Label 1000 4150 0    60   ~ 0
FP15
Text Label 1000 4050 0    60   ~ 0
FP14
Text Label 1000 3950 0    60   ~ 0
FP13
Text Label 1000 3850 0    60   ~ 0
FP12
Text Label 1000 3750 0    60   ~ 0
FP11
Text Label 1000 3650 0    60   ~ 0
FP10
Text Label 1000 3550 0    60   ~ 0
FP9
Text Label 1000 3450 0    60   ~ 0
FP8
Text Label 1000 3350 0    60   ~ 0
FP7
Text Label 1000 3250 0    60   ~ 0
FP6
Text Label 1000 3150 0    60   ~ 0
FP5
Text Label 1000 3050 0    60   ~ 0
FP4
Text Label 1000 2950 0    60   ~ 0
FP3
Text Label 1000 2850 0    60   ~ 0
FP2
Text Label 1000 2750 0    60   ~ 0
FP1
$Comp
L GND #PWR19
U 1 1 4E186DEB
P 9250 1500
F 0 "#PWR19" H 9250 1500 30  0001 C CNN
F 1 "GND" H 9250 1430 30  0001 C CNN
	1    9250 1500
	0    -1   1    0   
$EndComp
Text Label 6100 6400 2    60   ~ 0
JTRST
Text Label 6100 6300 2    60   ~ 0
JTDO
Text Label 6100 6200 2    60   ~ 0
JTMS
Text Label 6100 6100 2    60   ~ 0
JTCK
Text Label 6100 6000 2    60   ~ 0
JTDI
Text Label 2000 6100 0    60   ~ 0
SPI2_SCK
Text Label 2000 6000 0    60   ~ 0
SPI2_MISO
Text Label 1750 3150 0    60   ~ 0
DAC2
Text Label 1750 3050 0    60   ~ 0
DAC1
Text Label 1650 2950 0    60   ~ 0
TIM5_CH4
Text Label 1650 2850 0    60   ~ 0
TIM5_CH3
Text Label 2000 4950 0    60   ~ 0
TIM4_CH4
Text Label 2000 4850 0    60   ~ 0
TIM4_CH3
Text Label 1650 3550 0    60   ~ 0
TIM3_CH4
Text Label 1650 3450 0    60   ~ 0
TIM3_CH3
Text Label 1650 3350 0    60   ~ 0
TIM3_CH2
Text Label 1650 3250 0    60   ~ 0
TIM3_CH1
Text Label 1650 2750 0    60   ~ 0
TIM5_CH2
Text Label 1650 2650 0    60   ~ 0
TIM5_CH1
Text Label 2200 2950 0    60   ~ 0
USART2_RX
Text Label 2200 2850 0    60   ~ 0
USART2_TX
$Comp
L STM32F105RC U10
U 1 1 4E07C22E
P 4200 4800
F 0 "U10" H 3200 8150 60  0000 C CNN
F 1 "STM32F105RC" H 5100 2600 60  0000 C CNN
F 2 "TQFP_64" H 3140 8210 60  0001 C CNN
	1    4200 4800
	1    0    0    -1  
$EndComp
$Comp
L C C56
U 1 1 4E078720
P 7650 2500
F 0 "C56" H 7700 2600 50  0000 L CNN
F 1 "0.1uF" H 7700 2400 50  0000 L CNN
F 2 "SM0603" H 7650 2500 60  0001 C CNN
	1    7650 2500
	1    0    0    -1  
$EndComp
$Comp
L C C54
U 1 1 4E0786EA
P 6950 2500
F 0 "C54" H 7000 2600 50  0000 L CNN
F 1 ".1uF" H 7000 2400 50  0000 L CNN
F 2 "SM0603" H 6950 2500 60  0001 C CNN
	1    6950 2500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR17
U 1 1 4E07869F
P 8550 2800
F 0 "#PWR17" H 8550 2800 30  0001 C CNN
F 1 "GND" H 8550 2730 30  0001 C CNN
	1    8550 2800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR5
U 1 1 4DCDB18D
P 4300 7400
F 0 "#PWR5" H 4300 7400 30  0001 C CNN
F 1 "GND" H 4300 7330 30  0001 C CNN
	1    4300 7400
	1    0    0    -1  
$EndComp
$Comp
L C C55
U 1 1 4DCDB187
P 7300 2500
F 0 "C55" H 7350 2600 50  0000 L CNN
F 1 "0.1uF" H 7350 2400 50  0000 L CNN
F 2 "SM0603" H 7300 2500 60  0001 C CNN
	1    7300 2500
	1    0    0    -1  
$EndComp
$Comp
L C C58
U 1 1 4DCDB186
P 8000 2500
F 0 "C58" H 8050 2600 50  0000 L CNN
F 1 "0.1uF" H 8050 2400 50  0000 L CNN
F 2 "SM0603" H 8000 2500 60  0001 C CNN
	1    8000 2500
	1    0    0    -1  
$EndComp
$Comp
L C C72
U 1 1 4DCDB185
P 9450 2500
F 0 "C72" H 9500 2600 50  0000 L CNN
F 1 "0.1uF" H 9500 2400 50  0000 L CNN
F 2 "SM0603" H 9450 2500 60  0001 C CNN
	1    9450 2500
	1    0    0    -1  
$EndComp
$Comp
L C C73
U 1 1 4DCDB184
P 9850 2500
F 0 "C73" H 9900 2600 50  0000 L CNN
F 1 "1uF" H 9900 2400 50  0000 L CNN
F 2 "SM0805" H 9850 2500 60  0001 C CNN
	1    9850 2500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR20
U 1 1 4DCDB183
P 9650 2800
F 0 "#PWR20" H 9650 2800 30  0001 C CNN
F 1 "GND" H 9650 2730 30  0001 C CNN
	1    9650 2800
	1    0    0    -1  
$EndComp
Text Notes 8500 1850 0    60   ~ 0
DECOUPLING
Text Label 4500 900  3    60   ~ 0
VDDAST
Text Label 9800 2300 2    60   ~ 0
VDDAST
Text Label 2500 2400 0    60   ~ 0
NRST
$Comp
L GND #PWR1
U 1 1 4DCDB180
P 700 2050
F 0 "#PWR1" H 700 2050 30  0001 C CNN
F 1 "GND" H 700 1980 30  0001 C CNN
	1    700  2050
	-1   0    0    -1  
$EndComp
Text Label 2500 1800 0    60   ~ 0
BOOT0
Text Label 2500 1900 0    60   ~ 0
BOOT1
Text Label 10400 2150 2    60   ~ 0
BOOT0
$Comp
L GND #PWR21
U 1 1 4DCDB17D
P 10400 2850
F 0 "#PWR21" H 10400 2850 30  0001 C CNN
F 1 "GND" H 10400 2780 30  0001 C CNN
	1    10400 2850
	1    0    0    -1  
$EndComp
Text Notes 10450 2000 0    60   ~ 0
Boot mode select
Text Label 1000 2650 0    60   ~ 0
FP0
Text Label 2000 5900 0    60   ~ 0
SPI2_MOSI
Text Label 2000 5550 0    60   ~ 0
USART3_TX
Text Label 2000 5650 0    60   ~ 0
USART3_RX
Text Label 2000 4750 0    60   ~ 0
I2C1_SDA
Text Label 2000 4650 0    60   ~ 0
I2C1_SCL
Text Label 2000 5200 0    60   ~ 0
I2C2_SCL
Text Label 2000 5300 0    60   ~ 0
I2C2_SDA
$Comp
L LED D8
U 1 1 4DCDB178
P 8850 1200
F 0 "D8" H 8850 1300 50  0000 C CNN
F 1 "LED" H 8850 1100 50  0000 C CNN
F 2 "SM0603" H 8850 1200 60  0001 C CNN
	1    8850 1200
	-1   0    0    1   
$EndComp
$Comp
L R R5
U 1 1 4DCDB177
P 8850 1500
F 0 "R5" V 8930 1500 50  0000 C CNN
F 1 "1k" V 8850 1500 50  0000 C CNN
F 2 "SM0603" H 8850 1500 60  0001 C CNN
	1    8850 1500
	0    1    1    0   
$EndComp
Text Notes 9600 750  0    60   ~ 0
LEDS
$Comp
L C C26
U 1 1 4DCDB175
P 1200 1700
F 0 "C26" H 1250 1800 50  0000 L CNN
F 1 "22pF" H 1250 1600 50  0000 L CNN
F 2 "SM0603" H 1200 1700 60  0001 C CNN
	1    1200 1700
	0    1    1    0   
$EndComp
$Comp
L C C28
U 1 1 4DCDB174
P 1200 2300
F 0 "C28" H 1250 2400 50  0000 L CNN
F 1 "22pF" H 1250 2200 50  0000 L CNN
F 2 "SM0603" H 1200 2300 60  0001 C CNN
	1    1200 2300
	0    1    1    0   
$EndComp
$EndSCHEMATC
