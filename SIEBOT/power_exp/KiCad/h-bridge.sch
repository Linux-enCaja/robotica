EESchema Schematic File Version 2  date dom 03 oct 2010 18:02:12 COT
LIBS:dc-dc
LIBS:headers
LIBS:lm3478
LIBS:mpc17529
LIBS:mmbt2222a
LIBS:mm74hc14m
LIBS:device
LIBS:hole
LIBS:SIE_power_module-cache
EELAYER 24  0
EELAYER END
$Descr A4 11700 8267
Sheet 5 5
Title ""
Date "3 oct 2010"
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	4250 2900 4150 2900
Wire Wire Line
	4150 2950 4450 2950
Wire Wire Line
	4450 2950 4450 2850
Wire Wire Line
	4450 2850 4600 2850
Wire Wire Line
	5100 2850 5150 2850
Wire Wire Line
	5150 3000 5100 3000
Wire Wire Line
	3050 4750 3050 4550
Wire Wire Line
	3050 3950 3050 4150
Wire Wire Line
	2800 3950 2800 4150
Wire Wire Line
	4250 3300 4150 3300
Wire Wire Line
	2550 4650 2550 4550
Wire Wire Line
	3450 3300 3550 3300
Wire Wire Line
	2050 4050 2050 4150
Wire Wire Line
	2050 4650 2050 4550
Wire Wire Line
	2300 4650 2300 4550
Wire Wire Line
	3450 3150 3550 3150
Wire Wire Line
	3100 3000 3550 3000
Wire Wire Line
	2550 2850 2600 2850
Wire Wire Line
	5050 4050 4800 4050
Wire Wire Line
	5050 3950 4800 3950
Wire Bus Line
	4600 4200 4700 4200
Wire Bus Line
	4700 4200 4700 3800
Wire Wire Line
	4000 4250 3650 4250
Wire Wire Line
	3550 3350 3450 3350
Wire Wire Line
	4000 4000 3650 4000
Wire Wire Line
	4000 3900 3650 3900
Wire Wire Line
	3550 3250 3450 3250
Wire Wire Line
	4250 3050 4150 3050
Wire Wire Line
	3450 3200 3550 3200
Wire Wire Line
	4150 3200 4250 3200
Wire Wire Line
	4250 3100 4150 3100
Wire Wire Line
	3550 3100 3450 3100
Wire Wire Line
	4250 3250 4150 3250
Wire Wire Line
	3450 3050 3550 3050
Wire Wire Line
	3650 3850 4000 3850
Wire Wire Line
	3650 3950 4000 3950
Wire Wire Line
	4250 3350 4150 3350
Wire Wire Line
	3650 4200 4000 4200
Wire Wire Line
	3650 4150 4000 4150
Wire Wire Line
	5050 3900 4800 3900
Wire Wire Line
	5050 4000 4800 4000
Wire Wire Line
	3550 2900 3450 2900
Wire Wire Line
	3550 2950 3250 2950
Wire Wire Line
	3250 2950 3250 2850
Wire Wire Line
	3250 2850 3100 2850
Wire Wire Line
	2550 3000 2600 3000
Wire Wire Line
	2300 4050 2300 4150
Wire Wire Line
	2550 3950 2550 4150
Wire Wire Line
	2800 4750 2800 4550
Wire Wire Line
	4250 3150 4150 3150
Wire Wire Line
	1800 4650 1800 4550
Wire Wire Line
	1800 4050 1800 4150
Wire Wire Line
	4600 3000 4150 3000
Text GLabel 4250 2900 2    20   BiDi ~ 0
GND
Text GLabel 4250 3050 2    20   BiDi ~ 0
VMOTOR
Text GLabel 1800 4050 1    20   BiDi ~ 0
VMOTOR
$Comp
L C C5
U 1 1 4C702BD5
P 1800 4350
F 0 "C5" H 1850 4450 50  0000 L CNN
F 1 "100n" H 1850 4250 50  0000 L CNN
	1    1800 4350
	1    0    0    -1  
$EndComp
Text GLabel 1800 4650 3    20   BiDi ~ 0
GND
Text GLabel 4250 3150 2    20   BiDi ~ 0
GNDMOTOR
Text Label 3050 4750 1    20   ~ 0
C1L
Text Label 2800 4750 1    20   ~ 0
C2L
$Comp
L C C10
U 1 1 4C702B0C
P 3050 4350
F 0 "C10" H 3100 4450 50  0000 L CNN
F 1 "100n" H 3100 4250 50  0000 L CNN
	1    3050 4350
	1    0    0    -1  
$EndComp
Text Label 3050 3950 3    20   ~ 0
C1H
$Comp
L C C9
U 1 1 4C702AFE
P 2800 4350
F 0 "C9" H 2850 4450 50  0000 L CNN
F 1 "100n" H 2850 4250 50  0000 L CNN
	1    2800 4350
	1    0    0    -1  
$EndComp
Text Label 2800 3950 3    20   ~ 0
C2H
Text Label 4250 3350 2    20   ~ 0
C1H
Text Label 4250 3300 2    20   ~ 0
C1L
Text Label 4250 3250 2    20   ~ 0
C2L
Text Label 3450 3350 0    20   ~ 0
C2H
Text Label 2550 3950 3    20   ~ 0
CRES
Text GLabel 2550 4650 3    20   BiDi ~ 0
GND
$Comp
L C C8
U 1 1 4C7029EC
P 2550 4350
F 0 "C8" H 2600 4450 50  0000 L CNN
F 1 "100n" H 2600 4250 50  0000 L CNN
	1    2550 4350
	1    0    0    -1  
$EndComp
Text Label 3450 3300 0    20   ~ 0
CRES
Text GLabel 2050 4650 3    20   BiDi ~ 0
GND
$Comp
L C C6
U 1 1 4C70297A
P 2050 4350
F 0 "C6" H 2100 4450 50  0000 L CNN
F 1 "100n" H 2100 4250 50  0000 L CNN
	1    2050 4350
	1    0    0    -1  
$EndComp
Text GLabel 2050 4050 1    20   BiDi ~ 0
VMOTOR
$Comp
L MPC17529 U5
U 1 1 4C700B25
P 3850 3150
F 0 "U5" H 3800 3500 60  0000 C CNN
F 1 "MPC17529" H 3850 2850 60  0000 C CNN
	1    3850 3150
	1    0    0    -1  
$EndComp
Text GLabel 2300 4050 1    20   BiDi ~ 0
3.3V
$Comp
L C C7
U 1 1 4C656F91
P 2300 4350
F 0 "C7" H 2350 4450 50  0000 L CNN
F 1 "100n" H 2350 4250 50  0000 L CNN
	1    2300 4350
	1    0    0    -1  
$EndComp
Text GLabel 2300 4650 3    20   BiDi ~ 0
GND
Text GLabel 5050 4050 2    20   BiDi ~ 0
MOTR_B_IN
Text GLabel 5050 4000 2    20   BiDi ~ 0
MOTR_A_IN
Text GLabel 5050 3950 2    20   BiDi ~ 0
MOTL_B_IN
Text GLabel 5050 3900 2    20   BiDi ~ 0
MOTL_A_IN
Text Label 4900 4000 2    20   ~ 0
DIG15
Text Label 4900 4050 2    20   ~ 0
DIG14
Text Label 4900 3950 2    20   ~ 0
DIG1
Text Label 4900 3900 2    20   ~ 0
DIG0
Text GLabel 5150 3000 2    20   BiDi ~ 0
MOTL_B_IN
Text GLabel 5150 2850 2    20   BiDi ~ 0
MOTL_A_IN
Text GLabel 2550 3000 0    20   BiDi ~ 0
MOTR_B_IN
Text GLabel 2550 2850 0    20   BiDi ~ 0
MOTR_A_IN
Text HLabel 4600 4200 0    20   BiDi ~ 0
DIG[0..3]
Entry Wire Line
	4700 3950 4800 4050
Entry Wire Line
	4700 3900 4800 4000
Entry Wire Line
	4700 3850 4800 3950
Entry Wire Line
	4700 3800 4800 3900
Text GLabel 3650 4150 0    20   BiDi ~ 0
3.3V
Text HLabel 4000 4150 2    20   BiDi ~ 0
3.3V
Text HLabel 4000 4200 2    20   BiDi ~ 0
VMOTOR
Text HLabel 4000 4250 2    20   BiDi ~ 0
GND
Text GLabel 3650 4200 0    20   BiDi ~ 0
VMOTOR
Text GLabel 3650 4250 0    20   BiDi ~ 0
GND
Text GLabel 3450 3250 0    20   BiDi ~ 0
VMOTOR
Text HLabel 4000 4000 2    20   BiDi ~ 0
MOTR_B
Text HLabel 4000 3950 2    20   BiDi ~ 0
MOTR_A
Text HLabel 4000 3900 2    20   BiDi ~ 0
MOTL_B
Text HLabel 4000 3850 2    20   BiDi ~ 0
MOTL_A
Text GLabel 3650 4000 0    20   BiDi ~ 0
MOTR_B
Text GLabel 3650 3950 0    20   BiDi ~ 0
MOTR_A
Text GLabel 3650 3900 0    20   BiDi ~ 0
MOTL_B
Text GLabel 3650 3850 0    20   BiDi ~ 0
MOTL_A
Text GLabel 3450 2900 0    20   BiDi ~ 0
3.3V
Text GLabel 4250 3200 2    20   BiDi ~ 0
MOTR_B
Text GLabel 3450 3200 0    20   BiDi ~ 0
MOTR_A
Text GLabel 4250 3100 2    20   BiDi ~ 0
MOTL_B
Text GLabel 3450 3100 0    20   BiDi ~ 0
MOTL_A
$Comp
L R R20
U 1 1 4C5F79BA
P 4850 3000
F 0 "R20" V 4930 3000 50  0000 C CNN
F 1 "470" V 4850 3000 50  0000 C CNN
	1    4850 3000
	0    1    1    0   
$EndComp
$Comp
L R R19
U 1 1 4C5F79B9
P 4850 2850
F 0 "R19" V 4930 2850 50  0000 C CNN
F 1 "470" V 4850 2850 50  0000 C CNN
	1    4850 2850
	0    1    1    0   
$EndComp
$Comp
L R R17
U 1 1 4C5F79B8
P 2850 2850
F 0 "R17" V 2930 2850 50  0000 C CNN
F 1 "470" V 2850 2850 50  0000 C CNN
	1    2850 2850
	0    1    1    0   
$EndComp
$Comp
L R R18
U 1 1 4C5F79B7
P 2850 3000
F 0 "R18" V 2930 3000 50  0000 C CNN
F 1 "470" V 2850 3000 50  0000 C CNN
	1    2850 3000
	0    1    1    0   
$EndComp
Text GLabel 3450 3050 0    20   BiDi ~ 0
GND
Text GLabel 3450 3150 0    20   BiDi ~ 0
GNDMOTOR
$EndSCHEMATC
