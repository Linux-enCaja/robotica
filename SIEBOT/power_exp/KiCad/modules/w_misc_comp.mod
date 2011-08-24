PCBNEW-LibModule-V1  ven 05 mar 2010 10:53:42 CET
$INDEX
fuse_holder_CQ-2
PCB_PUSH
crystal_hc-49u
inductor_8mm-p5
inductor_25mm
$EndINDEX
$MODULE inductor_8mm-p5
Po 0 0 0 15 4A827E83 00000000 ~~
Li inductor_8mm-p5
Cd Inductor, 8mm p5
Sc 00000000
AR /4919D57E
Op 0 0 0
T0 0 -2200 600 600 0 120 N V 21 N"Inductor_8mm-p5"
T1 0 2100 600 600 0 120 N I 21 N"L***"
DC 0 0 -1600 0 150 21
$PAD
Sh "1" C 1000 1000 0 0 0
Dr 394 0 0
At STD N 00E0FFFF
Ne 0 ""
Po 984 0
$EndPAD
$PAD
Sh "2" C 1000 1000 0 0 0
Dr 394 0 0
At STD N 00E0FFFF
Ne 0 ""
Po -984 0
$EndPAD
$SHAPE3D
Na "walter/misc_comp/inductor_8mm-p5.wrl"
Sc 1.000000 1.000000 1.000000
Of 0.000000 0.000000 0.000000
Ro 0.000000 0.000000 0.000000
$EndSHAPE3D
$EndMODULE  inductor_8mm-p5
$MODULE PCB_PUSH
Po 0 0 0 15 4B90D464 00000000 ~~
Li PCB_PUSH
Cd PCB pushbutton, Tyco FSM6x6 series
Kw pushbutton
Sc 00000000
AR
Op 0 0 0
T0 0 -2000 394 394 0 39 N V 21 N"PCB_PUSH"
T1 0 2200 500 500 0 80 N V 21 N"SW***"
DS -1200 -1200 1200 -1200 120 21
DS 1200 -1200 1200 1200 120 21
DS 1200 1200 -1200 1200 120 21
DS -1200 1200 -1200 -1200 120 21
DC 0 0 -300 100 1000 21
$PAD
Sh "1" C 984 984 0 0 0
Dr 394 0 0
At STD N 00E0FFFF
Ne 0 ""
Po -886 -1280
$EndPAD
$PAD
Sh "2" C 984 984 0 0 0
Dr 394 0 0
At STD N 00E0FFFF
Ne 0 ""
Po 886 1280
$EndPAD
$PAD
Sh "4" C 984 984 0 0 0
Dr 394 0 0
At STD N 00E0FFFF
Ne 0 ""
Po 886 -1280
$EndPAD
$PAD
Sh "3" C 984 984 0 0 0
Dr 394 0 0
At STD N 00E0FFFF
Ne 0 ""
Po -886 1280
$EndPAD
$SHAPE3D
Na "walter/misc_comp/pcb_push.wrl"
Sc 1.000000 1.000000 1.000000
Of 0.000000 0.000000 0.000000
Ro 0.000000 0.000000 0.000000
$EndSHAPE3D
$EndMODULE  PCB_PUSH
$MODULE crystal_hc-49u
Po 0 0 0 15 4B90D476 00000000 ~~
Li crystal_hc-49u
Cd Crystal, HC-49U
Kw QUARTZ
Sc 00000000
AR
Op 0 A 0
T0 0 -1300 450 500 0 60 N V 21 N"HC-49U"
T1 0 1300 450 500 0 60 N V 21 N"X***"
DS -1300 700 1300 700 100 21
DS 1300 -700 -1300 -700 100 21
DA 1300 0 2000 0 900 100 21
DA 1300 0 1300 -700 900 100 21
DA -1300 0 -1300 700 900 100 21
DA -1300 0 -2000 0 900 100 21
DA 1300 0 2200 0 900 100 21
DA 1300 0 2200 0 -900 100 21
DS 1300 900 -1300 900 100 21
DS -1300 -900 1300 -900 100 21
DA -1300 0 -1300 900 900 100 21
DA -1300 0 -2200 0 900 100 21
$PAD
Sh "1" C 787 787 0 0 0
Dr 315 0 0
At STD N 00E0FFFF
Ne 0 ""
Po -1000 0
$EndPAD
$PAD
Sh "2" C 787 787 0 0 0
Dr 315 0 0
At STD N 00E0FFFF
Ne 0 ""
Po 1000 0
$EndPAD
$SHAPE3D
Na "walter/misc_comp/crystal_hc-49u.wrl"
Sc 1.000000 1.000000 1.000000
Of 0.000000 0.000000 0.000000
Ro 0.000000 0.000000 0.000000
$EndSHAPE3D
$EndMODULE  crystal_hc-49u
$MODULE fuse_holder_CQ-2
Po 0 0 0 15 4B90D488 00000000 ~~
Li fuse_holder_CQ-2
Cd Fuse holder, 5x20, CQ-200C
Kw fuse
Sc 00000000
AR
Op 0 0 0
T0 -400 5400 600 600 0 120 N V 21 N"Fuse_holder_CQ-2"
T1 100 -5400 600 600 0 120 N V 21 N"F***"
DS 1000 2200 1000 -2200 150 21
DS -1000 -2200 -1000 2200 150 21
DS -1900 -2200 1900 -2200 150 21
DS 1900 2200 -1900 2200 150 21
DS 1900 4900 -1900 4900 150 21
DS -1900 4900 -1900 -4900 150 21
DS -1900 -4900 1900 -4900 150 21
DS 1900 -4900 1900 4900 150 21
$PAD
Sh "1" C 1181 1181 0 0 0
Dr 472 0 0
At STD N 00E0FFFF
Ne 0 ""
Po 0 -4285
$EndPAD
$PAD
Sh "2" C 1181 1181 0 0 0
Dr 472 0 0
At STD N 00E0FFFF
Ne 0 ""
Po 0 4285
$EndPAD
$SHAPE3D
Na "walter/misc_comp/fuse_cq-200c.wrl"
Sc 1.000000 1.000000 1.000000
Of 0.000000 0.000000 0.000000
Ro 0.000000 0.000000 0.000000
$EndSHAPE3D
$EndMODULE  fuse_holder_CQ-2
$MODULE inductor_25mm
Po 0 0 0 15 4B90D4A3 00000000 ~~
Li inductor_25mm
Cd power inductor, 25mm
Sc 00000000
AR 
Op 0 0 0
T0 0 -1800 600 600 0 120 N V 21 N"Inductor_25mm"
T1 0 3000 600 600 0 120 N V 21 N"L***"
DC 0 0 -1100 0 100 21
DC 0 0 -4900 0 100 21
$PAD
Sh "1" C 1181 1181 0 0 0
Dr 394 0 0
At STD N 00E0FFFF
Ne 0 ""
Po 4900 0
$EndPAD
$PAD
Sh "2" C 1181 1181 0 0 0
Dr 394 0 0
At STD N 00E0FFFF
Ne 0 ""
Po -4900 0
$EndPAD
$SHAPE3D
Na "walter/misc_comp/inductor_25mm.wrl"
Sc 1.000000 1.000000 1.000000
Of 0.000000 0.000000 0.000000
Ro 0.000000 0.000000 0.000000
$EndSHAPE3D
$EndMODULE  inductor_25mm
$EndLIBRARY
