********************************************************************************
* Software License Agreement                                                   *
*                                                                              *
* The software supplied herewith by Microchip Technology Incorporated (the     *
* 'Company') is intended and supplied to you, the Company's customer, for use  *
* solely and exclusively on Microchip products.                                 *
*                                                                              *
* The software is owned by the Company and/or its supplier, and is protected   *
* under applicable copyright laws. All rights are reserved. Any use in         *
* violation of the foregoing restrictions may subject the user to criminal     *
* sanctions under applicable laws, as well as to civil liability for the       *
* breach of the terms and conditions of this license.                          *
*                                                                              *
* THIS SOFTWARE IS PROVIDED IN AN 'AS IS' CONDITION. NO WARRANTIES, WHETHER    *
* EXPRESS, IMPLIED OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED        *
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO  *
* THIS SOFTWARE. THE COMPANY SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR    *
* SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.     *
*************************************************************************
.SUBCKT MCP6006 1 2 3 4 5
*               | | | | |
*               | | | | Output
*               | | | Negative Supply
*               | | Positive Supply
*               | Inverting Input
*               Non-inverting Input
*
*
* The following op-amps are covered by this model:
*      MCP6006/6R/6U/7/9
*
* Date of model creation: 10-16-2020_9:37:12_AM
* Level of Model Creator: MCP6006_1P00 / 10-14-20
*
* Revision History:
*      REV A: 5-Oct-20, Initial Input
*      REV B: 14-Oct-20, Corrected VCM+, CM/DM, Noise
*      REV C: 15-Oct-20, Updated VCM-
*      REV D: 16-Oct-20, Updated RINCM/ZIN
*       
*
* Recommendations:
*      Use PSPICE (or SPICE 2G6; other simulators may require translation)
*      For a quick, effective design, use a combination of: data sheet
*            specs, bench testing, and simulations with this macromodel
*      For high impedance circuits, set GMIN=100F in the .OPTIONS statement
*
* Supported:
*      Typical performance for temperature range (-40 to 125) degrees Celsius
*      DC, AC, Transient, and Noise analyses.
*      Most specs, including: offsets, DC PSRR, DC CMRR, input impedance,
*            open loop gain, voltage ranges, supply current, ... , etc.
*      Temperature effects for Ibias, Iquiescent, Iout short circuit 
*            current, Vsat on both rails, Slew Rate vs. Temp and P.S.
*
* Not Supported:
*      Some Variation in specs vs. Power Supply Voltage
*      Vos distribution, Ib distribution for Monte Carlo
*      Distortion (detailed non-linear behavior)
*      Some Temperature analysis
*      Process variation
*      Behavior outside normal operating region
*
* Known Discrepancies in Model vs. Datasheet:
*       
*
*
* EMI Stage
*
RF1 1 1A 304
RF2 2 2A 304
RF3 1A 1B 304
RF4 2A 2B 304
CF1 1A 4 3E-12
CF2 4 2A 3E-12
CF3 1B 4 3E-12
CF4 4 2B 3E-12
*
* Input Stage
*
V10  3 10 -500M
R10 10 11 69.0K
R11 10 12 69.0K
G10 10 11 10 11 1.44M
G11 10 12 10 12 1.44M
C11 11 12 115E-15
C13  1B 2B 1.00P
E12 71 14 VALUE { (-200U) + V(20) * 3.83 + V(21) * 3.83 + V(22) * 3.83 + V(23) * 3.83 }

* Generate Input Bias 1 and 2 and  Input Offset
EG12 VIBIAS 0 62 0 1
EG13 VIBIOS 0 63 0 1

* Calculate IB1 and IB2 based on IOS
EIB1 VIB1 0 VALUE { (V(VIBIAS)+V(VIBIOS)) /2 }
EIB2 VIB2 0 VALUE { (V(VIBIAS)-V(VIBIOS)) /2 }

* Convert Voltage to Current on Pins 1 and 2
GIB1 1B 0 VIB1 0 1u
GIB2 2B 0 VIB2 0 1u

M12 11 14 15 15 NMI 
M14 12 2B 15 15 NMI 
I15 15 4 500U
V16 16 4 -295M
GD16 16 1B TABLE { V(16,1B) } ((-100,-50.0E-15)(0,0)(1m,1u)(2m,1m)) 
V13 3 13 -300M
GD13 2B 13 TABLE { V(2B,13) } ((-100,-50.0E-15)(0,0)(1m,1u)(2m,1m)) 
R71  1B  0 20.0E12
R72  2B  0 20.0E12
R73  1B  2B 10.0E12
*
* Noise 
*
I20 21 20 1.00
D20 20  0 DN1
D21  0 21 DN1
I22 22 23 1N
R22 22 0  1k
R23  0 23 1k
*
* Open Loop Gain, Slew Rate
*
G30 0 30 TABLE { V(12, 11) } ((-5.5,-11)(-0.1,-0.1)(0,0)(0.1,0.1)(5.5,11))
R30 30  0 1.00K
G31 0 31 3 4 65.6
I31 0 31 DC -88.0
R31 31 0 1
E_VDDMAX VDE 0 3 4 1
V_VDD1 31VDD1 0 1.8
V_VDD2 31VDD2 0 5.5
G_ABMII2 0 31B VALUE { V(31)*(LIMIT(((V(31VDD1)-V(VDE))/(V(31VDD1)-V(31VDD2))), 0, 1))}
R_R3 31A 0 1 TC=3.87M, 8.02U
G_ABMII1 0 31A VALUE { V(31)*(LIMIT(((V(VDE)-V(31VDD2))/(V(31VDD1)-V(31VDD2))), 0, 1))}
G_G6 30 31C TABLE { V(30, 31C) } ((-100,-1n)(0,0)(1m,0.1)(101m,190.1))
E_ABM1 31C 0 VALUE { (V(31A) + V(31B)) }
R_R8 31B 0 1 TC=188U, -6.06U
G32 32 0 3 4 57.9
I32 32 0 DC -31.4
R32 32  0 1 
G_ABMII22 32B 0 VALUE { V(32)*(LIMIT(((V(31VDD1)-V(VDE))/(V(31VDD1)-V(31VDD2))), 0, 1))}
R_R23 32A 0 1 TC=2.74M, -5.17U
G_ABMII21 32A 0 VALUE { V(32)*(LIMIT(((V(VDE)-V(31VDD2))/(V(31VDD1)-V(31VDD2))), 0, 1))}
G_G26 32C 30 TABLE { V(30, 32C) } ((-101m,190.1)(-1m,0.1)(0,0)(100,-1n))
E_ABM21 0 32C VALUE { (V(32A) + V(32B)) }
R_R28 32B 0 1 TC=-1.70M, -2.85U
G6  0 33 30 0 1m
R6  33 0 1K
*
* 1st Order Pole
*
G34  0 34 33 0 2.37
R34  34 0 1K
C34  34 0 300U
*
* 2nd Order Pole
*
G37  0 37 34 0 1m
R37  37 0 1K
C37  37 0 10.6P
*
* 3rd Order Pole
*
G377A 0 377A 37 0 1m
R377A 377A 0 1K
C377A  377A 0 159E-15
*
* 1st Order Zero
*
G38  0 38 377A 0 1m
GR38  39 0 39 0 1m
RR38  39 0 100G
L38  38 39 159N
*
* 2nd Order Zero
*
G38A  0 38A 38 0 1m
GR38A  39A 0 39A 0 1m
RR38A  39A 0 100G
L38A  38A 39A 159N
E38  35 0 38A 0 1
*
* Output Stage
*
R80 50 0 100MEG
G50 0 50 57 96 2
R58 57 96 0.50
R57 57  0 1.5K
* PSRR / CMRR 
G57  0 57 VALUE { V(35) * 666U + V(118) + V(127) + V(137) } 
*
*
* PSRR Plus Gain and GBWP Pole Neutralization and Wave Shaping 
*
* G30 THE DC GAIN FOR +PSRR 
G110 0 110 3 0 28.1U
* ADD POLE TO NEUTRALIZE GBWP ZERO
R110 110 0 10T 
GR110 110 0 110 0 1M 
C110 110 0 300U
*
*
* PSRR Plus Pole 
*
G111 0 111 110 0 1 
L111 111 112 3.53M
R112 112 0 10T 
GR112 112 0 112 0 1 
*
* PSRR Plus Zero 
*
G114 0 114 111 0 1 
R114 114 0 10T 
C114 114 0 244N
GR114 114 0 114 0 1 
*
* PSRR Plus 2nd Pole 
*
G115 0 115 114 0 1 
L115 115 116 79.6N
R116 116 0 1G 
GR116 116 0 116 0 1 
*
* PSRR Plus 2nd Zero 
*
G117 0 117 115 0 1 
R117 117 0 1G 
C117 117 0 15.9P
GR117 117 0 117 0 1 
*
* PSRR Plus 3rd Pole 
*
G118 0 118 117 0 1 
L118 118 119 79.6N
R119 119 0 1G 
GR119 119 0 119 0 1 
*
* PSRR Minus Gain and GBWP Pole Neutralization and Wave Shaping 
*
* G40 THE DC GAIN FOR -PSRR 
G120 0 120 4 0 28.1U
* ADD POLE TO NEUTRALIZE GBWP ZERO
R120 120 0 10T 
GR120 120 0 120 0 1M 
C120 120 0 300U
*
*
* PSRR Minus Pole 
*
G121 0 121 120 0 1 
L121 121 122 3.53M
R122 122 0 10T 
GR122 122 0 122 0 1 
*
* PSRR Minus Zero 
*
G124 0 124 121 0 1 
R124 124 0 10T 
C124 124 0 244N
GR124 124 0 124 0 1 
*
* PSRR Minus 2nd Pole 
*
G125 0 125 124 0 1 
L125 125 126 79.6N
R126 126 0 1G 
GR126 126 0 126 0 1 
*
* PSRR Minus 2nd Zero 
*
G1217 0 127 125 0 1 
R127 127 0 1G 
C127 127 0 15.9P
GR127 127 0 127 0 1 
*
* CMRR Gain and GBWP Pole Neutralization and Wave Shaping 
*
* G50 THE DC GAIN FOR CMRR 
G130 0 130 VALUE { ( V(15) ) * 4.99U}
* Add Zero To Neutralize GBWP Pole
R130 130 0 1G 
GR130 130 0 130 0 1m 
C130 130 0 300U
*
*
* CMRR Pole 
*
G131 0 131 130 0 1 
L131 131 132 1.59M
R132 132 0 1G 
GR132 132 0 132 0 1 
*
* CMRR Zero 
*
G133 0 133 131 0 1 
R133 133 0 1G 
C133 133 0  1.76U
GR133 133 0 133 0 1 
*
* CMRR 2nd Pole
*
G134 0 134 133 0 1 
L134 134 135 159P
R135 135 0 1G 
GR135 135 0 135 0 1 
*
* CMRR 2nd Zero 
*
G137 0 137 134 0 1 
R137 137 0 1G 
C137 137 0  159P
GR137 137 0 137 0 1 
*
GD55 55 57 TABLE { V(55,57) } ((-0.2m,-400)(-0.1m,-1m)(0,0)(10,1n))
GD56 57 56 TABLE { V(57,56) } ((-0.2m,-400)(-0.1m,-1m)(0,0)(10,1n))
E55 55  0 VALUE { 0.00 + V(3) * 1 + V(51) * -23.7M }
E56 56  0 VALUE { 0.00 + V(4) * 1 + V(52) * -21.2M }
R51 51 0 1k
R52 52 0 1k
GD51 50 51 TABLE { V(50,51) } ((-10,-1n)(0,0)(1m,1m)(2m,1))
GD52 50 52 TABLE { V(50,52) } ((-2m,-1)(-1m,-1m)(0,0)(10,1n))
G53  3  0 VALUE { -500U + V(51) * 1M }
G54  0  4 VALUE { -500U + V(52) * -1M }
*
* Current Limit
*
GD98A 98 98A TABLE { V(98,98A) } ((-3m,-1000)(-2m,-10)(-1m,-1)(0,0)(1,1n))
GD98B 98 98B TABLE { V(98,98B) } ((-1,-1n)(0,0)(1m,1)(2m,10)(3m,1000))
R98A 0 98A 1 TC=-857U,-1.66U
R98B 0 98B 1 TC=-3.01M,-461N
G99 96 5 99 0 1
G97 0 98 TABLE { V(96,5) } ((-11.0,-1.00M)(-1.00M,-990U)(0,0)(1.00M,990U)(11.0,1.00M))
E97 99 0 VALUE { V(98) * LIMIT((( V(3) - V(4) ) * 6.19 + -4.57), 0.00, 1E6 ) * LIMIT((( V(3) - V(4) ) * 5.00 + -3.5), 0, 1) }
D98 4 5 DESD
D99 5 3 DESD
*
* Temperature / Voltage Sensitive IQuiscent
*
R61 0 61 1 TC=437U,-2.12U
G61 3 4 61 0 1
G60 0 61 TABLE { V(3, 4) } ((0, 0)(600M,489N)(1.00,28.0U)(1.15,35.0U)(1.25,40.0U)(1.45,48.0U)(2.00,48.2U)
+ (3.5,48.7U)(4.00,48.9U)(6.00,49.0U))
*
* Temperature Sensitive offset voltage
*
I73 0 70 DC 1
R74 0 70 1 TC=600N
E75 1B 71 VALUE {V(70)-1}
*
* Temp Sensistive IBias
*
I62 0 62 DC 1uA
R62 622 62 REXP  4.66458
R622 0 622 REXP_2  6.08958M
*
* Temp Sensistive Offset IBias
*
I63 0 63 DC 1uA
R63 0 63 5.5 TC=-3.81M,-36.7U
*
*
G57X  0 57X VALUE { V(35) * 666U + V(118) + V(127) + V(137) } 
R57X 57X  0 1.5K
G35X 33 0 TABLE { V(57X,3) } ((-1,-1p)(0,0)(50M,1n)(375.0,1))
G36X 33 0 TABLE { V(57X,4) } ((-375.0,-1)(-50M,-1n)(0,0)(1,1p))
*
* Models
.MODEL NMI NMOS(L=2.00U W=42.0U KP=200U LEVEL=1 )
.MODEL DESD  D   N=1 IS=1.00E-15
.MODEL DN1 D   IS=1P KF=5.00P AF=1
.MODEL REXP  RES TCE=-497.70342M
.MODEL REXP_2  RES TCE= 11.00975
.ENDS MCP6006

.SUBCKT MCP6009 1 2 3 4 5 6 7 8 9 10 11 12 13 14
XUA 3 2 4 11 1 MCP6006
XUB 5 6 4 11 7 MCP6006
XUC 10 9 4 11 8 MCP6006
XUD 12 13 4 11 14 MCP6006
.ENDS
