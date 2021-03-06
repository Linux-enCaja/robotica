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
Sheet 4 4
Title ""
Date "29 aug 2011"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
NoConn ~ 5750 4500
Text Label 9000 6150 2    60   ~ 0
OTG_SOF
Text Label 9000 6050 2    60   ~ 0
OTG_VBUS
Text Label 9000 5950 2    60   ~ 0
OTG_ID
Text Label 9000 5850 2    60   ~ 0
OTG_DM
Text Label 9000 5750 2    60   ~ 0
OTG_DP
$Comp
L CP1 C13
U 1 1 4E2DF30C
P 10400 2450
F 0 "C13" H 10450 2550 50  0000 L CNN
F 1 "10uF Tant." H 10450 2350 50  0000 L CNN
	1    10400 2450
	1    0    0    -1  
$EndComp
Text GLabel 9000 6150 2    60   BiDi ~ 0
OTG_SOF
Wire Wire Line
	6900 4500 5750 4500
Wire Wire Line
	9900 5800 10050 5800
Wire Wire Line
	10050 5900 10050 6200
Wire Wire Line
	5750 2300 6850 2300
Wire Notes Line
	10450 6500 10450 5550
Wire Wire Line
	8750 1000 9200 1000
Wire Wire Line
	8650 1200 8500 1200
Wire Wire Line
	8500 1200 8500 1500
Wire Wire Line
	8500 1500 8600 1500
Wire Bus Line
	7000 4200 7000 4800
Wire Bus Line
	7000 4800 6350 4800
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
Wire Bus Line
	850  4350 1400 4350
Wire Bus Line
	6750 3950 6750 2850
Wire Bus Line
	6750 2850 6600 2850
Wire Wire Line
	6650 3450 5750 3450
Wire Wire Line
	6650 3250 5750 3250
Wire Wire Line
	2800 2650 950  2650
Wire Notes Line
	11050 600  11050 1700
Wire Notes Line
	11050 600  8450 600 
Wire Notes Line
	8450 600  8450 1700
Wire Wire Line
	6100 6400 5750 6400
Wire Wire Line
	6100 6200 5750 6200
Wire Wire Line
	5750 6000 6100 6000
Wire Wire Line
	5750 4400 6900 4400
Wire Wire Line
	5750 4200 6900 4200
Connection ~ 4100 7300
Connection ~ 4200 7300
Wire Wire Line
	4500 7300 4000 7300
Wire Wire Line
	9500 4900 9500 4800
Wire Wire Line
	9200 4250 9200 4200
Wire Wire Line
	9200 4200 9500 4200
Wire Wire Line
	8900 4300 8900 4200
Wire Wire Line
	10450 4200 10450 4150
Wire Wire Line
	10450 4150 10150 4150
Wire Wire Line
	10900 4200 10900 4150
Wire Wire Line
	10900 4150 10750 4150
Wire Wire Line
	10750 4150 10750 4250
Wire Notes Line
	9850 5050 8450 5050
Wire Notes Line
	9850 3800 8450 3800
Connection ~ 9700 3500
Wire Wire Line
	9700 3100 10050 3100
Connection ~ 10050 2650
Wire Wire Line
	8650 3100 8650 2800
Connection ~ 9000 2650
Connection ~ 9350 2650
Wire Wire Line
	9700 2250 10050 2250
Wire Notes Line
	10450 6500 9650 6500
Wire Notes Line
	10450 5550 9650 5550
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
Connection ~ 10500 3100
Wire Wire Line
	10500 3100 10500 2950
Wire Wire Line
	10500 2950 10750 2950
Wire Wire Line
	10400 2250 10400 2100
Wire Wire Line
	10050 2250 10050 1950
Wire Wire Line
	8650 2250 8650 1950
Wire Wire Line
	4300 900  4300 1250
Wire Wire Line
	4100 900  4100 1250
Connection ~ 10600 3500
Wire Wire Line
	10600 3600 10600 3500
Wire Wire Line
	4500 7300 4500 7200
Wire Wire Line
	4300 7200 4300 7400
Wire Wire Line
	4100 7300 4100 7200
Wire Wire Line
	4000 7300 4000 7200
Wire Wire Line
	4200 7300 4200 7200
Wire Notes Line
	11050 1750 8450 1750
Wire Notes Line
	11050 1750 11050 3750
Wire Notes Line
	11050 3750 8450 3750
Wire Notes Line
	8450 3750 8450 1750
Wire Wire Line
	4000 900  4000 1250
Wire Wire Line
	4200 900  4200 1250
Wire Wire Line
	10050 3100 10050 2800
Wire Wire Line
	9350 1950 9350 2250
Wire Wire Line
	4500 900  4500 1250
Wire Wire Line
	10800 3100 10400 3100
Wire Wire Line
	2500 2400 2800 2400
Wire Notes Line
	9900 3800 9900 5050
Wire Notes Line
	11050 3800 11050 5050
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
Wire Notes Line
	9850 3800 9850 5050
Wire Notes Line
	8450 3800 8450 5050
Wire Wire Line
	950  2850 2800 2850
Wire Wire Line
	950  3450 2800 3450
Wire Wire Line
	950  3650 2800 3650
Wire Wire Line
	950  3850 2800 3850
Wire Wire Line
	2800 2200 2350 2200
Wire Wire Line
	2350 2200 2350 1700
Wire Wire Line
	4700 1150 4700 1250
Wire Notes Line
	8450 1700 11050 1700
Wire Wire Line
	2350 1700 1400 1700
Connection ~ 1550 1700
Connection ~ 1550 2300
Wire Wire Line
	9350 2250 9000 2250
Connection ~ 9700 2650
Wire Wire Line
	10700 2650 8650 2650
Connection ~ 10400 2650
Wire Wire Line
	10800 3500 8650 3500
Connection ~ 10400 3500
Connection ~ 10050 3500
Wire Notes Line
	11050 3800 9900 3800
Wire Notes Line
	11050 5050 9900 5050
Wire Wire Line
	10750 4750 10750 4850
Wire Wire Line
	10750 4850 10450 4850
Wire Wire Line
	10450 4850 10450 4800
Wire Wire Line
	8900 4800 8900 4900
Wire Wire Line
	8900 4900 9200 4900
Wire Wire Line
	9200 4900 9200 4850
Wire Wire Line
	9500 4200 9500 4300
Connection ~ 4300 7300
Wire Wire Line
	1400 2300 2800 2300
Wire Wire Line
	5750 4100 6900 4100
Wire Wire Line
	5750 4300 6900 4300
Wire Wire Line
	6100 6100 5750 6100
Wire Wire Line
	6100 6300 5750 6300
Wire Wire Line
	10450 4050 10150 4050
Wire Wire Line
	10150 4050 10150 4250
Connection ~ 10150 4150
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
Wire Bus Line
	6000 5700 6200 5700
Wire Bus Line
	6200 5700 6200 6300
Wire Bus Line
	850  6450 850  2550
Wire Wire Line
	9250 1500 9100 1500
Wire Wire Line
	9200 1000 9200 1200
Wire Wire Line
	9200 1200 9050 1200
Wire Wire Line
	9900 1200 10050 1200
Wire Wire Line
	10050 1200 10050 1000
Wire Wire Line
	10050 1000 9450 1000
Wire Wire Line
	10100 1500 9950 1500
Wire Wire Line
	9450 1500 9350 1500
Wire Wire Line
	9350 1500 9350 1200
Wire Wire Line
	9350 1200 9500 1200
Wire Wire Line
	10350 1200 10200 1200
Wire Wire Line
	10200 1200 10200 1500
Wire Wire Line
	10200 1500 10300 1500
Wire Wire Line
	10950 1500 10800 1500
Wire Wire Line
	10300 1000 10900 1000
Wire Wire Line
	10900 1000 10900 1200
Wire Wire Line
	10900 1200 10750 1200
Wire Notes Line
	7150 2000 5750 2000
Wire Notes Line
	7150 2000 7150 1550
Wire Notes Line
	7150 1550 5750 1550
Wire Notes Line
	5750 1550 5750 2000
Wire Notes Line
	9650 5550 9650 6500
Wire Wire Line
	6350 2200 5750 2200
Wire Wire Line
	10050 4900 10150 4900
Wire Wire Line
	10150 4900 10150 4750
Wire Wire Line
	10050 6200 9900 6200
Wire Wire Line
	9900 6200 9900 6100
Wire Wire Line
	10300 6350 9800 6350
Entry Wire Line
	6900 4500 7000 4600
Text Label 6900 4500 2    60   ~ 0
OTG_SOF
Text GLabel 6500 1700 2    60   BiDi ~ 0
USB_SW
Text GLabel 9000 6050 2    60   BiDi ~ 0
OTG_VBUS
Text GLabel 9000 5850 2    60   BiDi ~ 0
OTG_DM
Text GLabel 9000 5750 2    60   BiDi ~ 0
OTG_DP
Text GLabel 9000 5950 2    60   BiDi ~ 0
OTG_ID
Text GLabel 5750 6400 2    60   BiDi ~ 0
JTRST
Text GLabel 5750 6300 2    60   BiDi ~ 0
JTDO
Text GLabel 5750 6200 2    60   BiDi ~ 0
JTMS
Text GLabel 5750 6100 2    60   BiDi ~ 0
JTCK
Text GLabel 5750 6000 2    60   BiDi ~ 0
JTDI
$Comp
L 5V #PWR043
U 1 1 4E2A2E71
P 9800 6350
F 0 "#PWR043" H 9800 6450 30  0001 C CNN
F 1 "5V" H 9800 6460 30  0000 C CNN
	1    9800 6350
	1    0    0    -1  
$EndComp
$Comp
L 3V3_AN #PWR044
U 1 1 4E2A2E5F
P 9900 5800
F 0 "#PWR044" H 9900 5900 30  0001 C CNN
F 1 "3V3_AN" H 9900 5910 30  0000 C CNN
	1    9900 5800
	1    0    0    -1  
$EndComp
$Comp
L 3V3 #PWR045
U 1 1 4E2A2E5B
P 9900 6100
F 0 "#PWR045" H 9900 6200 30  0001 C CNN
F 1 "3V3" H 9900 6210 30  0000 C CNN
	1    9900 6100
	1    0    0    -1  
$EndComp
$Comp
L 3V3 #PWR046
U 1 1 4E2A2E30
P 10050 4900
F 0 "#PWR046" H 10050 5000 30  0001 C CNN
F 1 "3V3" H 10050 5010 30  0000 C CNN
	1    10050 4900
	1    0    0    -1  
$EndComp
$Comp
L 3V3 #PWR047
U 1 1 4E2A2E29
P 8900 4200
F 0 "#PWR047" H 8900 4300 30  0001 C CNN
F 1 "3V3" H 8900 4310 30  0000 C CNN
	1    8900 4200
	1    0    0    -1  
$EndComp
$Comp
L 3V3 #PWR048
U 1 1 4E2A2E11
P 10400 2100
F 0 "#PWR048" H 10400 2200 30  0001 C CNN
F 1 "3V3" H 10400 2210 30  0000 C CNN
	1    10400 2100
	1    0    0    -1  
$EndComp
$Comp
L 3V3 #PWR049
U 1 1 4E2A2E03
P 8750 1000
F 0 "#PWR049" H 8750 1100 30  0001 C CNN
F 1 "3V3" H 8750 1110 30  0000 C CNN
	1    8750 1000
	1    0    0    -1  
$EndComp
$Comp
L 3V3 #PWR050
U 1 1 4E2A2DF0
P 4700 1150
F 0 "#PWR050" H 4700 1250 30  0001 C CNN
F 1 "3V3" H 4700 1260 30  0000 C CNN
	1    4700 1150
	1    0    0    -1  
$EndComp
Text HLabel 10450 4050 2    60   BiDi ~ 0
RESET
Text HLabel 6500 1700 0    60   BiDi ~ 0
USB_PORT
Text Label 6500 1700 0    60   ~ 0
USB_SW
Text Notes 5750 2400 0    60   ~ 0
A high level on this pin enables \nVbus of the USB host connector \nand switches the USB data lines \nto that connector
Text Label 6850 2300 2    60   ~ 0
USB_SW
Text Label 6350 2200 2    60   ~ 0
OV_Current
Text Label 6350 2300 2    60   ~ 0
Vbus_EN
Text Label 10300 6350 2    60   ~ 0
OTG_VBUS
Text Label 6500 1900 0    60   ~ 0
Vbus_EN
Text Label 6500 1800 0    60   ~ 0
OV_Current
Text HLabel 6500 1900 0    60   BiDi ~ 0
Vbus_EN
Text HLabel 6500 1800 0    60   BiDi ~ 0
OV_Current
Text Label 10050 5800 0    60   ~ 0
VDDA
Text Notes 6350 6550 1    60   ~ 0
SLOT_JTAG - JTAG_PORT
Text Notes 7150 4950 1    60   ~ 0
SLOT_USB - USB_PORT
Text Notes 6950 3750 1    60   ~ 0
SLOT1 - 8 pins
Text Notes 650  5750 1    60   ~ 0
SLOT2 - COMM
Text Notes 700  3750 1    60   ~ 0
SLOT0 - 16 pins
Text Label 10300 1000 0    60   ~ 0
STM32_FP17
$Comp
L GND #PWR051
U 1 1 4E188E68
P 10950 1500
F 0 "#PWR051" H 10950 1500 30  0001 C CNN
F 1 "GND" H 10950 1430 30  0001 C CNN
	1    10950 1500
	-1   0    0    -1  
$EndComp
$Comp
L LED D3
U 1 1 4E188E67
P 10550 1200
F 0 "D3" H 10550 1300 50  0000 C CNN
F 1 "LED" H 10550 1100 50  0000 C CNN
	1    10550 1200
	-1   0    0    1   
$EndComp
$Comp
L R R8
U 1 1 4E188E66
P 10550 1500
F 0 "R8" V 10630 1500 50  0000 C CNN
F 1 "1k" V 10550 1500 50  0000 C CNN
	1    10550 1500
	0    1    1    0   
$EndComp
$Comp
L R R6
U 1 1 4E188E50
P 9700 1500
F 0 "R6" V 9780 1500 50  0000 C CNN
F 1 "1k" V 9700 1500 50  0000 C CNN
	1    9700 1500
	0    1    1    0   
$EndComp
$Comp
L LED D2
U 1 1 4E188E4F
P 9700 1200
F 0 "D2" H 9700 1300 50  0000 C CNN
F 1 "LED" H 9700 1100 50  0000 C CNN
	1    9700 1200
	-1   0    0    1   
$EndComp
$Comp
L GND #PWR052
U 1 1 4E188E4E
P 10100 1500
F 0 "#PWR052" H 10100 1500 30  0001 C CNN
F 1 "GND" H 10100 1430 30  0001 C CNN
	1    10100 1500
	-1   0    0    -1  
$EndComp
Text Label 9450 1000 0    60   ~ 0
STM32_FP16
Text Label 8850 1000 0    60   ~ 0
POWER
Text HLabel 6350 4800 0    60   BiDi ~ 0
USB_PORT
Entry Wire Line
	6900 4400 7000 4500
Entry Wire Line
	6900 4300 7000 4400
Entry Wire Line
	6900 4200 7000 4300
Entry Wire Line
	6900 4100 7000 4200
Entry Wire Line
	850  6450 950  6550
Text Label 1000 4650 0    60   ~ 0
STM32_FP24
Text Label 1000 4750 0    60   ~ 0
STM32_FP25
Text Label 1000 4850 0    60   ~ 0
STM32_FP26
Text Label 1000 4950 0    60   ~ 0
STM32_FP27
Text Label 1000 5200 0    60   ~ 0
STM32_FP28
Text Label 1000 5300 0    60   ~ 0
STM32_FP29
Text Label 1000 5550 0    60   ~ 0
STM32_FP30
Text Label 1000 5650 0    60   ~ 0
STM32_FP31
Text Label 1000 5900 0    60   ~ 0
STM32_FP32
Text Label 1000 6000 0    60   ~ 0
STM32_FP33
Text Label 1000 6100 0    60   ~ 0
STM32_FP34
Text Label 1000 6550 0    60   ~ 0
STM32_FP35
Entry Wire Line
	850  6000 950  6100
Entry Wire Line
	850  5900 950  6000
Entry Wire Line
	850  5800 950  5900
Entry Wire Line
	850  5550 950  5650
Entry Wire Line
	850  5450 950  5550
Entry Wire Line
	850  5200 950  5300
Entry Wire Line
	850  5100 950  5200
Entry Wire Line
	850  4850 950  4950
Entry Wire Line
	850  4750 950  4850
Entry Wire Line
	850  4650 950  4750
Entry Wire Line
	850  4550 950  4650
Text Label 5950 3550 0    60   ~ 0
STM32_FP20
Text Label 5950 3650 0    60   ~ 0
STM32_FP21
Text Label 5950 3750 0    60   ~ 0
STM32_FP22
Text Label 5950 3850 0    60   ~ 0
STM32_FP23
Entry Wire Line
	6650 3550 6750 3650
Entry Wire Line
	6650 3650 6750 3750
Entry Wire Line
	6650 3750 6750 3850
Entry Wire Line
	6650 3850 6750 3950
Entry Wire Line
	6650 3450 6750 3550
Entry Wire Line
	6650 3350 6750 3450
Entry Wire Line
	6650 3250 6750 3350
Entry Wire Line
	6650 3150 6750 3250
Text HLabel 6600 2850 0    60   BiDi ~ 0
STM32_FP[0..35]
Text Label 5950 3450 0    60   ~ 0
STM32_FP19
Text Label 5950 3350 0    60   ~ 0
STM32_FP18
Text Label 5950 3250 0    60   ~ 0
STM32_FP17
Text Label 5950 3150 0    60   ~ 0
STM32_FP16
Text Label 1000 4150 0    60   ~ 0
STM32_FP15
Text Label 1000 4050 0    60   ~ 0
STM32_FP14
Text Label 1000 3950 0    60   ~ 0
STM32_FP13
Text Label 1000 3850 0    60   ~ 0
STM32_FP12
Text Label 1000 3750 0    60   ~ 0
STM32_FP11
Text Label 1000 3650 0    60   ~ 0
STM32_FP10
Text Label 1000 3550 0    60   ~ 0
STM32_FP9
Text Label 1000 3450 0    60   ~ 0
STM32_FP8
Text Label 1000 3350 0    60   ~ 0
STM32_FP7
Text Label 1000 3250 0    60   ~ 0
STM32_FP6
Text Label 1000 3150 0    60   ~ 0
STM32_FP5
Text Label 1000 3050 0    60   ~ 0
STM32_FP4
Text Label 1000 2950 0    60   ~ 0
STM32_FP3
Text Label 1000 2850 0    60   ~ 0
STM32_FP2
Text Label 1000 2750 0    60   ~ 0
STM32_FP1
Text Label 10450 4050 2    60   ~ 0
JTRST
$Comp
L GND #PWR053
U 1 1 4E186DEB
P 9250 1500
F 0 "#PWR053" H 9250 1500 30  0001 C CNN
F 1 "GND" H 9250 1430 30  0001 C CNN
	1    9250 1500
	-1   0    0    -1  
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
Text Label 6900 4400 2    60   ~ 0
OTG_VBUS
Text Label 6900 4300 2    60   ~ 0
OTG_ID
Text Label 6900 4200 2    60   ~ 0
OTG_DM
Text Label 6900 4100 2    60   ~ 0
OTG_DP
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
L STM32F105RC U2
U 1 1 4E07C22E
P 4200 4800
F 0 "U2" H 3200 8150 60  0000 C CNN
F 1 "STM32F105RC" H 5100 2600 60  0000 C CNN
F 2 "lqfp64" H 3140 8210 60  0001 C CNN
	1    4200 4800
	1    0    0    -1  
$EndComp
$Comp
L R R5
U 1 1 4E079478
P 9500 4550
F 0 "R5" V 9580 4550 50  0000 C CNN
F 1 "10k" V 9500 4550 50  0000 C CNN
	1    9500 4550
	-1   0    0    1   
$EndComp
$Comp
L R R4
U 1 1 4E0793F5
P 8900 4550
F 0 "R4" V 8980 4550 50  0000 C CNN
F 1 "510" V 8900 4550 50  0000 C CNN
	1    8900 4550
	-1   0    0    1   
$EndComp
$Comp
L JUMPER JP2
U 1 1 4E0793CB
P 9200 4550
F 0 "JP2" H 9200 4700 60  0000 C CNN
F 1 "JUMPER" H 9200 4470 40  0000 C CNN
	1    9200 4550
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR054
U 1 1 4E0791D9
P 2500 1900
F 0 "#PWR054" H 2500 1900 30  0001 C CNN
F 1 "GND" H 2500 1830 30  0001 C CNN
	1    2500 1900
	-1   0    0    -1  
$EndComp
$Comp
L R R7
U 1 1 4E078DDC
P 10150 4500
F 0 "R7" V 10230 4500 50  0000 C CNN
F 1 "10k" V 10150 4500 50  0000 C CNN
	1    10150 4500
	-1   0    0    1   
$EndComp
$Comp
L R R9
U 1 1 4E078DC6
P 10750 4500
F 0 "R9" V 10830 4500 50  0000 C CNN
F 1 "1k" V 10750 4500 50  0000 C CNN
	1    10750 4500
	-1   0    0    1   
$EndComp
$Comp
L SW_PUSH SW1
U 1 1 4E078D2F
P 10450 4500
F 0 "SW1" H 10600 4610 50  0000 C CNN
F 1 "SW_PUSH" H 10450 4420 50  0000 C CNN
	1    10450 4500
	0    -1   -1   0   
$EndComp
$Comp
L C C10
U 1 1 4E0787F5
P 9700 3300
F 0 "C10" H 9750 3400 50  0000 L CNN
F 1 "1uF" H 9750 3200 50  0000 L CNN
	1    9700 3300
	1    0    0    -1  
$EndComp
Text Label 8650 2800 3    60   ~ 0
VDD_3
$Comp
L C C4
U 1 1 4E07879C
P 8650 3300
F 0 "C4" H 8700 3400 50  0000 L CNN
F 1 "1uF" H 8700 3200 50  0000 L CNN
	1    8650 3300
	1    0    0    -1  
$EndComp
$Comp
L C C9
U 1 1 4E078720
P 9700 2450
F 0 "C9" H 9750 2550 50  0000 L CNN
F 1 "1uF" H 9750 2350 50  0000 L CNN
	1    9700 2450
	1    0    0    -1  
$EndComp
$Comp
L C C5
U 1 1 4E0786EA
P 9000 2450
F 0 "C5" H 9050 2550 50  0000 L CNN
F 1 "1uF" H 9050 2350 50  0000 L CNN
	1    9000 2450
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR055
U 1 1 4E07869F
P 10700 2650
F 0 "#PWR055" H 10700 2650 30  0001 C CNN
F 1 "GND" H 10700 2580 30  0001 C CNN
	1    10700 2650
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR056
U 1 1 4DCDB18D
P 4300 7400
F 0 "#PWR056" H 4300 7400 30  0001 C CNN
F 1 "GND" H 4300 7330 30  0001 C CNN
	1    4300 7400
	1    0    0    -1  
$EndComp
Text Label 6300 4400 2    60   ~ 0
USART1_TX
Text Label 6300 4300 2    60   ~ 0
USART1_RX
$Comp
L C C12
U 1 1 4DCDB189
P 10050 3300
F 0 "C12" H 10100 3400 50  0000 L CNN
F 1 "0.1uF" H 10100 3200 50  0000 L CNN
	1    10050 3300
	1    0    0    -1  
$EndComp
$Comp
L C C3
U 1 1 4DCDB188
P 8650 2450
F 0 "C3" H 8700 2550 50  0000 L CNN
F 1 "0.1uF" H 8700 2350 50  0000 L CNN
	1    8650 2450
	1    0    0    -1  
$EndComp
$Comp
L C C7
U 1 1 4DCDB187
P 9350 2450
F 0 "C7" H 9400 2550 50  0000 L CNN
F 1 "0.1uF" H 9400 2350 50  0000 L CNN
	1    9350 2450
	1    0    0    -1  
$EndComp
$Comp
L C C11
U 1 1 4DCDB186
P 10050 2450
F 0 "C11" H 10100 2550 50  0000 L CNN
F 1 "0.1uF" H 10100 2350 50  0000 L CNN
	1    10050 2450
	1    0    0    -1  
$EndComp
$Comp
L C C14
U 1 1 4DCDB185
P 10400 3300
F 0 "C14" H 10450 3400 50  0000 L CNN
F 1 "0.1uF" H 10450 3200 50  0000 L CNN
	1    10400 3300
	1    0    0    -1  
$EndComp
$Comp
L C C15
U 1 1 4DCDB184
P 10800 3300
F 0 "C15" H 10850 3400 50  0000 L CNN
F 1 "1uF" H 10850 3200 50  0000 L CNN
	1    10800 3300
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR057
U 1 1 4DCDB183
P 10600 3600
F 0 "#PWR057" H 10600 3600 30  0001 C CNN
F 1 "GND" H 10600 3530 30  0001 C CNN
	1    10600 3600
	1    0    0    -1  
$EndComp
Text Notes 9450 1900 0    60   ~ 0
DECOUPLING
Text Label 4000 900  3    60   ~ 0
VDD_4
Text Label 4100 900  3    60   ~ 0
VDD_3
Text Label 4200 900  3    60   ~ 0
VDD_2
Text Label 4300 900  3    60   ~ 0
VDD_1
Text Label 10050 2800 3    60   ~ 0
VDD_4
Text Label 8650 1950 3    60   ~ 0
VDD_3
Text Label 9350 1950 3    60   ~ 0
VDD_2
Text Label 10050 1950 3    60   ~ 0
VDD_1
Text Label 10050 5900 0    60   ~ 0
VDD_4
Text Label 10050 6000 0    60   ~ 0
VDD_3
Text Label 10050 6100 0    60   ~ 0
VDD_2
Text Label 10050 6200 0    60   ~ 0
VDD_1
Text Label 4500 900  3    60   ~ 0
VDDA
Text Label 10750 2950 2    60   ~ 0
VDDA
Text Label 2500 2400 0    60   ~ 0
NRST
Text Label 10450 4150 2    60   ~ 0
NRST
$Comp
L GND #PWR058
U 1 1 4DCDB181
P 10900 4200
F 0 "#PWR058" H 10900 4200 30  0001 C CNN
F 1 "GND" H 10900 4130 30  0001 C CNN
	1    10900 4200
	1    0    0    -1  
$EndComp
Text Notes 10150 3950 0    60   ~ 0
RESET STM32
$Comp
L GND #PWR059
U 1 1 4DCDB180
P 700 2050
F 0 "#PWR059" H 700 2050 30  0001 C CNN
F 1 "GND" H 700 1980 30  0001 C CNN
	1    700  2050
	-1   0    0    -1  
$EndComp
$Comp
L CRYSTAL X1
U 1 1 4DCDB17F
P 1550 2000
F 0 "X1" H 1650 2150 60  0000 C CNN
F 1 "8 MHz" H 1550 1850 60  0000 C CNN
	1    1550 2000
	0    -1   1    0   
$EndComp
Text Label 2500 1800 0    60   ~ 0
BOOT0
Text Label 2500 1900 0    60   ~ 0
BOOT1
Text Label 9500 4200 2    60   ~ 0
BOOT0
$Comp
L GND #PWR060
U 1 1 4DCDB17D
P 9500 4900
F 0 "#PWR060" H 9500 4900 30  0001 C CNN
F 1 "GND" H 9500 4830 30  0001 C CNN
	1    9500 4900
	1    0    0    -1  
$EndComp
Text Notes 8750 3950 0    60   ~ 0
Boot mode select
Entry Wire Line
	850  3950 950  4050
Entry Wire Line
	850  2550 950  2650
Entry Wire Line
	850  2650 950  2750
Entry Wire Line
	850  2750 950  2850
Entry Wire Line
	850  2850 950  2950
Entry Wire Line
	850  2950 950  3050
Entry Wire Line
	850  3050 950  3150
Entry Wire Line
	850  3150 950  3250
Entry Wire Line
	850  3250 950  3350
Entry Wire Line
	850  3350 950  3450
Entry Wire Line
	850  3450 950  3550
Entry Wire Line
	850  3550 950  3650
Entry Wire Line
	850  3650 950  3750
Entry Wire Line
	850  3750 950  3850
Entry Wire Line
	850  3850 950  3950
Entry Wire Line
	850  4050 950  4150
Text HLabel 1400 4350 2    60   BiDi ~ 0
STM32_FP[0..35]
Text Label 1000 2650 0    60   ~ 0
STM32_FP0
Text Label 2000 5900 0    60   ~ 0
SPI2_MOSI
Text Label 2000 5550 0    60   ~ 0
USART3_TX
Text Label 2000 5650 0    60   ~ 0
USART3_RX
Entry Wire Line
	6200 6200 6100 6300
Entry Wire Line
	6200 6000 6100 6100
Entry Wire Line
	6200 5900 6100 6000
Entry Wire Line
	6200 6100 6100 6200
Text HLabel 6000 5700 0    60   BiDi ~ 0
JTAG
Entry Wire Line
	6200 6300 6100 6400
Text Label 2000 4750 0    60   ~ 0
I2C1_SDA
Text Label 2000 4650 0    60   ~ 0
I2C1_SCL
Text Label 2000 5200 0    60   ~ 0
I2C2_SCL
Text Label 2000 5300 0    60   ~ 0
I2C2_SDA
$Comp
L LED D1
U 1 1 4DCDB178
P 8850 1200
F 0 "D1" H 8850 1300 50  0000 C CNN
F 1 "LED" H 8850 1100 50  0000 C CNN
	1    8850 1200
	-1   0    0    1   
$EndComp
$Comp
L R R3
U 1 1 4DCDB177
P 8850 1500
F 0 "R3" V 8930 1500 50  0000 C CNN
F 1 "1k" V 8850 1500 50  0000 C CNN
	1    8850 1500
	0    1    1    0   
$EndComp
Text Notes 9600 750  0    60   ~ 0
LEDS
$Comp
L C C1
U 1 1 4DCDB175
P 1200 1700
F 0 "C1" H 1250 1800 50  0000 L CNN
F 1 "20pF" H 1250 1600 50  0000 L CNN
	1    1200 1700
	0    1    1    0   
$EndComp
$Comp
L C C2
U 1 1 4DCDB174
P 1200 2300
F 0 "C2" H 1250 2400 50  0000 L CNN
F 1 "20pF" H 1250 2200 50  0000 L CNN
	1    1200 2300
	0    1    1    0   
$EndComp
$EndSCHEMATC
