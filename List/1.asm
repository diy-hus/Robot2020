
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Release
;Chip type              : ATmega128L
;Program type           : Application
;Clock frequency        : 8.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 1024 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': Yes
;'char' is unsigned     : Yes
;8 bit enums            : Yes
;Global 'const' stored in FLASH: No
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega128L
	#pragma AVRPART MEMORY PROG_FLASH 131072
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 4096
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU RAMPZ=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x6D
	.EQU XMCRB=0x6C

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x10FF
	.EQU __DSTACK_SIZE=0x0400
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTBSR
	STD  Y+@1,R@0
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _outStatus=R5
	.DEF _Udk_1=R6
	.DEF _Udk_1_msb=R7
	.DEF _dem=R8
	.DEF _dem_msb=R9
	.DEF _max_e=R10
	.DEF _max_e_msb=R11
	.DEF _Mid=R12
	.DEF _Mid_msb=R13
	.DEF _tt=R4

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer0_comp_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0
	.DB  0xBC,0x2

_0x3:
	.DB  0x1,0x2,0x4,0x8,0x10,0x20,0x40,0x80
_0x4:
	.DB  0x0,0x0,0x0,0x40
_0x5:
	.DB  0x0,0x0,0x40,0x41
_0x6:
	.DB  0xFA,0x0,0xFA
_0x7:
	.DB  0x20,0x3
_0x0:
	.DB  0x25,0x64,0x20,0x25,0x64,0x20,0x25,0x64
	.DB  0x20,0x25,0x64,0x0,0x64,0x6F,0x63,0x20
	.DB  0x76,0x61,0x63,0x68,0x20,0x74,0x72,0x61
	.DB  0x6E,0x67,0x0,0x64,0x6F,0x63,0x20,0x76
	.DB  0x61,0x63,0x68,0x20,0x64,0x65,0x6E,0x0
	.DB  0x74,0x69,0x6E,0x68,0x20,0x6E,0x67,0x75
	.DB  0x6F,0x6E,0x67,0x0,0x25,0x64,0x20,0x25
	.DB  0x64,0x20,0x0,0x64,0x61,0x20,0x6C,0x75
	.DB  0x75,0x20,0x73,0x61,0x6E,0x0,0x56,0x69
	.DB  0x74,0x72,0x69,0x78,0x65,0x3D,0x25,0x64
	.DB  0x20,0x25,0x64,0x0,0x25,0x64,0x20,0x20
	.DB  0x25,0x64,0x20,0x0
_0x2020003:
	.DB  0x80,0xC0

__GLOBAL_INI_TBL:
	.DW  0x0A
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x08
	.DW  _status
	.DW  _0x3*2

	.DW  0x04
	.DW  _Kp
	.DW  _0x4*2

	.DW  0x04
	.DW  _Kd
	.DW  _0x5*2

	.DW  0x02
	.DW  _speed
	.DW  _0x7*2

	.DW  0x02
	.DW  __base_y_G101
	.DW  _0x2020003*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRB,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

	OUT  RAMPZ,R24

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x500

	.CSEG
;/*****************************************************
;This program was produced by the
;CodeWizardAVR V2.05.0 Professional
;Automatic Program Generator
;© Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;
;Project :
;Version :
;Date    : 05/12/2014
;Author  : NeVaDa
;Company :
;Comments:
;
;
;Chip type               : ATmega128L
;Program type            : Application
;AVR Core Clock frequency: 8,000000 MHz
;Memory model            : Small
;External RAM size       : 0
;Data Stack size         : 1024
;*****************************************************/
;
;#include <mega128.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;#include <stdio.h>
;
;#include <delay.h>
;
;#include <alcd.h>
;
;#define chanel 8
;#include "khai_bao.c"
; unsigned int adc[8];
;  unsigned char status[chanel] = {1,2,4,8,16,32,64,128};

	.DSEG
;  unsigned char outStatus;
;
;  float error, old_error, error_sum, Kp=2, Kd=12, Ki=0;
;  int  Udk_1;
;  int k[2]={250,250};
;  eeprom unsigned int level[chanel] = {300,700,700,700,700,700,700,600};
;  int dem,max_e, Mid=700;
;  int  speed=800;
;  unsigned char tt=0,g=0,RC,RC1,RC2,RC3,RC4,RC5,ttv=0,v=0;
;unsigned int max_adc[8];
;unsigned int min_adc[8];
;  unsigned char i=0;
;#include "dinh_nghia.c"
;
;#define tiemcan_1 PIND.6
;#define tiemcan_2 PIND.7
;#define tiemcan_3 PINC.0
;#define tiemcan_4 PINC.1
;#define tiemcan_5 PINC.2
;// Ð?nh nghia các servo
;#define servo_1  PORTC.3
;#define servo_2  PORTC.4
;#define servo_3  PORTC.5
;#define servo_4  PORTC.6
;#define servo_5  PORTC.7
;
;
;// Ð?nh nghia các nút ch?n chuong trình
;#define doc_adc      PIND.3
;#define CT4          PIND.4
;//#define CT2          PIND.5
;//#define CT3          PIND.2
;
;#include "khoi_tao.c"
;#define ADC_VREF_TYPE 0x00
;
;// Read the AD conversion result
;unsigned int read_adc(unsigned char adc_input)
; 0000 0022 {

	.CSEG
_read_adc:
; .FSTART _read_adc
;ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
	ST   -Y,R26
;	adc_input -> Y+0
	LD   R30,Y
	OUT  0x7,R30
;// Delay needed for the stabilization of the ADC input voltage
;delay_us(10);
	__DELAY_USB 27
;// Start the AD conversion
;ADCSRA|=0x40;
	SBI  0x6,6
;// Wait for the AD conversion to complete
;while ((ADCSRA & 0x10)==0);
_0x8:
	SBIS 0x6,4
	RJMP _0x8
;ADCSRA|=0x10;
	SBI  0x6,4
;return 1023-ADCW;
	IN   R30,0x4
	IN   R31,0x4+1
	LDI  R26,LOW(1023)
	LDI  R27,HIGH(1023)
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	ADIW R28,1
	RET
;}
; .FEND
;// Timer 0 output compare interrupt service routine
;interrupt [TIM0_COMP] void timer0_comp_isr(void)
;{
_timer0_comp_isr:
; .FSTART _timer0_comp_isr
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; //Place your code here
;dem++;
	MOVW R30,R8
	ADIW R30,1
	MOVW R8,R30
;if (dem==200){dem=0;}
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	CP   R30,R8
	CPC  R31,R9
	BRNE _0xB
	CLR  R8
	CLR  R9
;if (RC1>dem){servo_1=1;}else{servo_1=0;}
_0xB:
	MOVW R30,R8
	LDS  R26,_RC1
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BRGE _0xC
	SBI  0x15,3
	RJMP _0xF
_0xC:
	CBI  0x15,3
_0xF:
;if (RC2>dem){servo_2=1;}else{servo_2=0;}
	MOVW R30,R8
	LDS  R26,_RC2
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x12
	SBI  0x15,4
	RJMP _0x15
_0x12:
	CBI  0x15,4
_0x15:
;if (RC3>dem){servo_3=1;}else{servo_3=0;}
	MOVW R30,R8
	LDS  R26,_RC3
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x18
	SBI  0x15,5
	RJMP _0x1B
_0x18:
	CBI  0x15,5
_0x1B:
;if (RC4>dem){servo_4=1;}else{servo_4=0;}
	MOVW R30,R8
	LDS  R26,_RC4
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x1E
	SBI  0x15,6
	RJMP _0x21
_0x1E:
	CBI  0x15,6
_0x21:
;if (RC5>dem){servo_5=1;}else{servo_5=0;}
	MOVW R30,R8
	LDS  R26,_RC5
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x24
	SBI  0x15,7
	RJMP _0x27
_0x24:
	CBI  0x15,7
_0x27:
;
;
;}
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
; .FEND
;#include "doc_adc.c"
;//dat sensor vao vach trang nhan CT1
;//dat sensor vao vach den nhan CT1
;//cho luu gia tri nguong vao eeprom
;
;
; void read_adc_all()
; 0000 0023   {
_read_adc_all:
; .FSTART _read_adc_all
;    unsigned char i;
;    unsigned int temp;
;    outStatus = 0;
	CALL __SAVELOCR4
;	i -> R17
;	temp -> R18,R19
	CLR  R5
;    for (i=0; i<chanel; i++)
	LDI  R17,LOW(0)
_0x2B:
	CPI  R17,8
	BRSH _0x2C
;    {
;        temp = read_adc(i);
	MOV  R26,R17
	RCALL _read_adc
	MOVW R18,R30
;        if (temp<level[i])
	CALL SUBOPT_0x0
	ADD  R26,R30
	ADC  R27,R31
	CALL __EEPROMRDW
	CP   R18,R30
	CPC  R19,R31
	BRSH _0x2D
;        {
;            adc[i]=0;
	CALL SUBOPT_0x1
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
;        }
;        else
	RJMP _0x2E
_0x2D:
;        {
;            adc[i]=temp;
	CALL SUBOPT_0x1
	ADD  R30,R26
	ADC  R31,R27
	ST   Z,R18
	STD  Z+1,R19
;            outStatus |= status[i];
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_status)
	SBCI R31,HIGH(-_status)
	LD   R30,Z
	OR   R5,R30
;        }
_0x2E:
;        delay_us(50);
	__DELAY_USB 133
;    }
	SUBI R17,-1
	RJMP _0x2B
_0x2C:
;
;  }
	CALL __LOADLOCR4
	ADIW R28,4
	RET
; .FEND
;void setnguong(void)
;{   unsigned char j=0,lcd_buffer[16];
_setnguong:
; .FSTART _setnguong
;
;  sprintf(lcd_buffer,"%d %d %d %d",read_adc(0),read_adc(1),read_adc(2),read_adc(3));
	SBIW R28,16
	ST   -Y,R17
;	j -> R17
;	lcd_buffer -> Y+1
	LDI  R17,0
	CALL SUBOPT_0x2
	LDI  R26,LOW(0)
	CALL SUBOPT_0x3
	LDI  R26,LOW(1)
	CALL SUBOPT_0x3
	LDI  R26,LOW(2)
	CALL SUBOPT_0x3
	LDI  R26,LOW(3)
	CALL SUBOPT_0x3
	CALL SUBOPT_0x4
;  lcd_gotoxy(0,0);
	CALL SUBOPT_0x5
;  lcd_puts(lcd_buffer);
;  sprintf(lcd_buffer,"%d %d %d %d",read_adc(4),read_adc(5),read_adc(6),read_adc(7));
	LDI  R26,LOW(4)
	CALL SUBOPT_0x3
	LDI  R26,LOW(5)
	CALL SUBOPT_0x3
	LDI  R26,LOW(6)
	CALL SUBOPT_0x3
	LDI  R26,LOW(7)
	CALL SUBOPT_0x3
	CALL SUBOPT_0x4
;  lcd_gotoxy(0,1);
	CALL SUBOPT_0x6
;  lcd_puts(lcd_buffer);
;    if((PIND.3==0)&&(i==0))
	SBIC 0x10,3
	RJMP _0x30
	LDS  R26,_i
	CPI  R26,LOW(0x0)
	BREQ _0x31
_0x30:
	RJMP _0x2F
_0x31:
;        {
;        while(!PIND.3)
_0x32:
	SBIC 0x10,3
	RJMP _0x34
;            lcd_clear();
	CALL _lcd_clear
	RJMP _0x32
_0x34:
	CALL SUBOPT_0x7
;            lcd_putsf("doc vach trang");
	__POINTW2FN _0x0,12
	CALL SUBOPT_0x8
;            delay_ms(20);
;            {   for(j=1;j<7;j++)
_0x36:
	CPI  R17,7
	BRSH _0x37
;                {
;                    max_adc[j]=read_adc(j);
	CALL SUBOPT_0x9
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	MOV  R26,R17
	RCALL _read_adc
	POP  R26
	POP  R27
	ST   X+,R30
	ST   X,R31
;                }
	SUBI R17,-1
	RJMP _0x36
_0x37:
;            }
;        i=1;
	LDI  R30,LOW(1)
	STS  _i,R30
;        }
;         //hien thi gia tri len lcd
;        sprintf(lcd_buffer,"%d %d %d %d", max_adc[0], max_adc[1], max_adc[2], max_adc[3]);
_0x2F:
	CALL SUBOPT_0x2
	LDS  R30,_max_adc
	LDS  R31,_max_adc+1
	CALL SUBOPT_0xA
	__GETW1MN _max_adc,2
	CALL SUBOPT_0xA
	__GETW1MN _max_adc,4
	CALL SUBOPT_0xA
	__GETW1MN _max_adc,6
	CALL SUBOPT_0xA
	CALL SUBOPT_0x4
;        lcd_gotoxy(0,0);
	CALL SUBOPT_0x5
;        lcd_puts(lcd_buffer);
;        sprintf(lcd_buffer,"%d %d %d %d", max_adc[4], max_adc[5], max_adc[6], max_adc[7]);
	__GETW1MN _max_adc,8
	CALL SUBOPT_0xA
	__GETW1MN _max_adc,10
	CALL SUBOPT_0xA
	__GETW1MN _max_adc,12
	CALL SUBOPT_0xA
	__GETW1MN _max_adc,14
	CALL SUBOPT_0xA
	CALL SUBOPT_0x4
;        lcd_gotoxy(0,1);
	CALL SUBOPT_0x6
;        lcd_puts(lcd_buffer);
;            if((PIND.3==0)&&(i==1))
	SBIC 0x10,3
	RJMP _0x39
	LDS  R26,_i
	CPI  R26,LOW(0x1)
	BREQ _0x3A
_0x39:
	RJMP _0x38
_0x3A:
;
;        {
;        while(!PIND.3)
_0x3B:
	SBIC 0x10,3
	RJMP _0x3D
;            {
;            lcd_clear();
	CALL SUBOPT_0xB
;            lcd_gotoxy(0,0);
;            lcd_putsf("doc vach den");
	__POINTW2FN _0x0,27
	CALL SUBOPT_0x8
;            delay_ms(20);
;             for(j=1;j<7;j++)
_0x3F:
	CPI  R17,7
	BRSH _0x40
;                {
;                    min_adc[j]=read_adc(j);
	CALL SUBOPT_0xC
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	MOV  R26,R17
	RCALL _read_adc
	POP  R26
	POP  R27
	ST   X+,R30
	ST   X,R31
;                }
	SUBI R17,-1
	RJMP _0x3F
_0x40:
;            }
	RJMP _0x3B
_0x3D:
;        i=2;
	LDI  R30,LOW(2)
	STS  _i,R30
;        //hien thi gia tri len lcd
;        sprintf(lcd_buffer,"%d %d %d %d", min_adc[0], min_adc[1], min_adc[2], min_adc[3]);
	CALL SUBOPT_0x2
	LDS  R30,_min_adc
	LDS  R31,_min_adc+1
	CALL SUBOPT_0xA
	__GETW1MN _min_adc,2
	CALL SUBOPT_0xA
	__GETW1MN _min_adc,4
	CALL SUBOPT_0xA
	__GETW1MN _min_adc,6
	CALL SUBOPT_0xA
	CALL SUBOPT_0x4
;        lcd_gotoxy(0,0);
	CALL SUBOPT_0x5
;        lcd_puts(lcd_buffer);
;        sprintf(lcd_buffer,"%d %d %d %d", min_adc[4], min_adc[5], min_adc[6], min_adc[7]);
	__GETW1MN _min_adc,8
	CALL SUBOPT_0xA
	__GETW1MN _min_adc,10
	CALL SUBOPT_0xA
	__GETW1MN _min_adc,12
	CALL SUBOPT_0xA
	__GETW1MN _min_adc,14
	CALL SUBOPT_0xA
	CALL SUBOPT_0x4
;        lcd_gotoxy(0,1);
	LDI  R26,LOW(1)
	CALL _lcd_gotoxy
;
;            lcd_clear();
	CALL SUBOPT_0xB
;            lcd_gotoxy(0,0);
;            lcd_putsf("tinh nguong");
	__POINTW2FN _0x0,40
	CALL _lcd_putsf
;            delay_ms(200);
	LDI  R26,LOW(200)
	LDI  R27,0
	CALL _delay_ms
;
;        for(j=1;j<7;j++)
	LDI  R17,LOW(1)
_0x42:
	CPI  R17,7
	BRLO PC+2
	RJMP _0x43
;            {
;            level[j]=(max_adc[j]+min_adc[j])/2;
	CALL SUBOPT_0x0
	ADD  R30,R26
	ADC  R31,R27
	MOVW R22,R30
	CALL SUBOPT_0x9
	ADD  R26,R30
	ADC  R27,R31
	LD   R0,X+
	LD   R1,X
	CALL SUBOPT_0xC
	CALL SUBOPT_0xD
	MOVW R26,R0
	ADD  R26,R30
	ADC  R27,R31
	MOVW R30,R26
	LSR  R31
	ROR  R30
	MOVW R26,R22
	CALL __EEPROMWRW
;            delay_ms(200);
	LDI  R26,LOW(200)
	LDI  R27,0
	CALL _delay_ms
;            sprintf(lcd_buffer,"%d %d %d %d",level[1],level[2],level[3],level[4]);
	CALL SUBOPT_0x2
	__POINTW2MN _level,2
	CALL SUBOPT_0xE
	__POINTW2MN _level,4
	CALL SUBOPT_0xE
	__POINTW2MN _level,6
	CALL SUBOPT_0xE
	__POINTW2MN _level,8
	CALL SUBOPT_0xE
	CALL SUBOPT_0x4
;            lcd_gotoxy(0,0);
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
;            lcd_puts(lcd_buffer);
	MOVW R26,R28
	ADIW R26,1
	CALL _lcd_puts
;            sprintf(lcd_buffer,"%d %d ",level[5],level[6]);
	MOVW R30,R28
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,52
	ST   -Y,R31
	ST   -Y,R30
	__POINTW2MN _level,10
	CALL SUBOPT_0xE
	__POINTW2MN _level,12
	CALL SUBOPT_0xE
	CALL SUBOPT_0xF
;            lcd_gotoxy(0,1);
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL SUBOPT_0x6
;            lcd_puts(lcd_buffer);
;            delay_ms(20);
	CALL SUBOPT_0x10
;            }
	SUBI R17,-1
	RJMP _0x42
_0x43:
;        lcd_clear();
	CALL SUBOPT_0xB
;        lcd_gotoxy(0,0);
;        lcd_putsf("da luu san");
	__POINTW2FN _0x0,59
	CALL _lcd_putsf
;        delay_ms(20);
	CALL SUBOPT_0x10
;        }
;
;}
_0x38:
	LDD  R17,Y+0
	ADIW R28,17
	RET
; .FEND
;#include "PID.c"
; /////////////////////// TINH VI TRI XE/////////////////////////////////////
;int vitrixe()
; 0000 0024  {
_vitrixe:
; .FSTART _vitrixe
;
;
;    char j;
;    unsigned int sum1=0, sum2=0;
;    float temp;
;    read_adc_all();
	SBIW R28,4
	CALL __SAVELOCR6
;	j -> R17
;	sum1 -> R18,R19
;	sum2 -> R20,R21
;	temp -> Y+6
	__GETWRN 18,19,0
	__GETWRN 20,21,0
	RCALL _read_adc_all
;    for (j=1; j<7;j++)
	LDI  R17,LOW(1)
_0x45:
	CPI  R17,7
	BRSH _0x46
;    {
;        sum1=sum1+adc[j]*(j+1);
	CALL SUBOPT_0x1
	CALL SUBOPT_0xD
	MOVW R26,R30
	MOV  R30,R17
	LDI  R31,0
	ADIW R30,1
	CALL __MULW12U
	__ADDWRR 18,19,30,31
;        sum2=sum2+adc[j];
	CALL SUBOPT_0x1
	CALL SUBOPT_0xD
	__ADDWRR 20,21,30,31
;    }
	SUBI R17,-1
	RJMP _0x45
_0x46:
;    if (sum2!=0)
	MOV  R0,R20
	OR   R0,R21
	BREQ _0x47
;    {
;        temp = (float)sum1*10;
	MOVW R30,R18
	CLR  R22
	CLR  R23
	CALL __CDF1
	__GETD2N 0x41200000
	CALL __MULF12
	__PUTD1S 6
;        temp = temp/sum2;
	MOVW R30,R20
	__GETD2S 6
	CLR  R22
	CLR  R23
	CALL __CDF1
	CALL __DIVF21
	__PUTD1S 6
;    }
;    else
	RJMP _0x48
_0x47:
;        temp=0;
	LDI  R30,LOW(0)
	__CLRD1S 6
;    return temp-45;
_0x48:
	__GETD1S 6
	__GETD2N 0x42340000
	CALL __SUBF12
	CALL __CFD1
	CALL __LOADLOCR6
	ADIW R28,10
	RET
; }
; .FEND
;
;//---------------------------------------------------
;int PID_control()
; {
_PID_control:
; .FSTART _PID_control
;    float delta, Udk;
;    int error_sum=0,Max = 42;
;
;    error =(float)vitrixe();            // Sai so dieu khien
	SBIW R28,8
	CALL __SAVELOCR4
;	delta -> Y+8
;	Udk -> Y+4
;	error_sum -> R16,R17
;	Max -> R18,R19
	__GETWRN 16,17,0
	__GETWRN 18,19,42
	RCALL _vitrixe
	CALL SUBOPT_0x11
	CALL SUBOPT_0x12
;
;
;    if ((error<-35) && (old_error>=0)) {error=-error;}
	LDS  R26,_error
	LDS  R27,_error+1
	LDS  R24,_error+2
	LDS  R25,_error+3
	__GETD1N 0xC20C0000
	CALL __CMPF12
	BRSH _0x4A
	LDS  R26,_old_error+3
	TST  R26
	BRPL _0x4B
_0x4A:
	RJMP _0x49
_0x4B:
	CALL SUBOPT_0x13
	CALL __ANEGF1
	CALL SUBOPT_0x12
;
;    delta = (error - old_error);
_0x49:
	LDS  R26,_old_error
	LDS  R27,_old_error+1
	LDS  R24,_old_error+2
	LDS  R25,_old_error+3
	CALL SUBOPT_0x13
	CALL __SUBF12
	__PUTD1S 8
;    old_error = error;                  //Luu gia tri sai so
	CALL SUBOPT_0x13
	STS  _old_error,R30
	STS  _old_error+1,R31
	STS  _old_error+2,R22
	STS  _old_error+3,R23
;    error_sum = error_sum+error; // Thanh phan tich phan
	CALL SUBOPT_0x13
	MOVW R26,R16
	CALL SUBOPT_0x14
	CALL SUBOPT_0x15
	MOVW R16,R30
;
;    // Khong cho thanh phan tich phan vuot qua gia tri max
;    if (error_sum <-max_e) error_sum = -max_e;
	MOVW R30,R10
	CALL __ANEGW1
	CP   R16,R30
	CPC  R17,R31
	BRGE _0x4C
	MOVW R30,R10
	CALL __ANEGW1
	MOVW R16,R30
;    if (error_sum > max_e) error_sum = max_e;
_0x4C:
	__CPWRR 10,11,16,17
	BRGE _0x4D
	MOVW R16,R10
;
;    Udk = Kp*error + Ki*error_sum + Kd*delta;  //Tin hieu dieu khien
_0x4D:
	CALL SUBOPT_0x13
	LDS  R26,_Kp
	LDS  R27,_Kp+1
	LDS  R24,_Kp+2
	LDS  R25,_Kp+3
	CALL __MULF12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	MOVW R30,R16
	LDS  R26,_Ki
	LDS  R27,_Ki+1
	LDS  R24,_Ki+2
	LDS  R25,_Ki+3
	CALL SUBOPT_0x11
	CALL __MULF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDF12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	__GETD1S 8
	LDS  R26,_Kd
	LDS  R27,_Kd+1
	LDS  R24,_Kd+2
	LDS  R25,_Kd+3
	CALL __MULF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDF12
	CALL SUBOPT_0x16
;
;    // Giam sat gia tri dieu khien ko duoc vuot qua ngwong
;    if (Udk <-Max) Udk = -Max;
	MOVW R30,R18
	CALL __ANEGW1
	CALL SUBOPT_0x17
	BRSH _0x4E
	MOVW R30,R18
	CALL __ANEGW1
	CALL SUBOPT_0x11
	CALL SUBOPT_0x16
;    if (Udk > Max) Udk = Max;
_0x4E:
	MOVW R30,R18
	CALL SUBOPT_0x17
	BREQ PC+2
	BRCC PC+2
	RJMP _0x4F
	MOVW R30,R18
	CALL SUBOPT_0x11
	CALL SUBOPT_0x16
;
;    return (int)Udk;
_0x4F:
	__GETD1S 4
	CALL __CFD1
	CALL __LOADLOCR4
	ADIW R28,12
	RET
; }
; .FEND
;
;#include "dk_motor.c"
;// Chuong trinh dieu khien Motor
;#define motor_1 0
;#define motor_2 1
;#define motor_3 2
;#define motor_4 3
;
;#define run_thuan 1
;#define run_nguoc 0
;
;void control_motor_(unsigned char motor,unsigned char dir_motor, unsigned char speed);
;
;void control_motor_(unsigned char motor,unsigned char dir_motor, unsigned char speed)
; 0000 0025 {
;    switch(motor)
;	motor -> Y+2
;	dir_motor -> Y+1
;	speed -> Y+0
;    {
;        case 0:
;        {
;            PORTB.2 = dir_motor;
;            //if(speed>100)   speed = 100;
;
;          OCR1A=speed-Udk_1*(Udk_1/2);
;            break;
;        }
;        case 1:
;        {
;            PORTB.3 = dir_motor;
;            //if(speed>100)   speed = 100;
;
;            OCR1B=speed+Udk_1*(-Udk_1/2);  ;
;            break;
;        }
;        case 2:
;        {
;            PORTE.1 = dir_motor;
;            //if(speed>100)   speed = 100;
;            if(dir_motor == 1)  {OCR3AH = (int)(speed+Udk_1*(-Udk_1/2.1))/256;OCR3AL = (int)(speed+Udk_1*(-Udk_1/2.1))%2 ...
;            else {OCR3AH = 1023-(int)(speed+Udk_1*(-Udk_1/2.1))/256;OCR3AL = 1023-(int)(speed+Udk_1*(-Udk_1/2.1))%256;}  ...
;            break;
;        }
;        case 3:
;        {
;            PORTE.2 = dir_motor;
;            //if(speed>100)   speed = 100;
;            if(dir_motor == 1)  {OCR3BH = (int)(speed-Udk_1*(-Udk_1/2.1))/256;OCR3BL = (int)(speed-Udk_1*(-Udk_1/2.1))%2 ...
;            else {OCR3BH = 1023-(int)(speed-Udk_1*(-Udk_1/2.1))/256;OCR3BL = 1023-(int)(speed-Udk_1*(-Udk_1/2.1))%256;}  ...
;            break;
;        }
;
;    }
;}
;#include "banhlai_hus.c"
;
;
;void banhlai(void)
; 0000 0026 {
_banhlai:
; .FSTART _banhlai
;      OCR1A=800;
	LDI  R30,LOW(800)
	LDI  R31,HIGH(800)
	OUT  0x2A+1,R31
	OUT  0x2A,R30
;      OCR1B=800;
	OUT  0x28+1,R31
	OUT  0x28,R30
;      //lai banh truoc
;      Udk_1 = PID_control();
	RCALL _PID_control
	MOVW R6,R30
;      RC=151;
	LDI  R30,LOW(151)
	STS  _RC,R30
;      //lai banh sau
;      if (Udk_1<0)
	CLR  R0
	CP   R6,R0
	CPC  R7,R0
	BRGE _0x63
;             {
;             PORTB.2 = 0;
	CBI  0x18,2
;             OCR1A=speed-Udk_1*(Udk_1/0.8);
	CALL SUBOPT_0x18
	__GETD1N 0x3F4CCCCD
	CALL SUBOPT_0x19
	CALL __SWAPD12
	CALL __SUBF12
	CALL __CFD1U
	OUT  0x2A+1,R31
	OUT  0x2A,R30
;             RC=(int)(148+Udk_1/1.2);
	CALL SUBOPT_0x18
	CALL SUBOPT_0x1A
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x1C
;      OCR3CH=RC*10/256;
;      OCR3CL=RC*10%256;
;             }
;      if (Udk_1>0)
_0x63:
	CLR  R0
	CP   R0,R6
	CPC  R0,R7
	BRGE _0x66
;            {
;           PORTB.3 = 0;
	CBI  0x18,3
;            OCR1B=speed+Udk_1*(-Udk_1/1.2);
	MOVW R30,R6
	CALL __ANEGW1
	CALL SUBOPT_0x11
	MOVW R26,R30
	MOVW R24,R22
	CALL SUBOPT_0x1A
	CALL SUBOPT_0x19
	CALL __ADDF12
	CALL __CFD1U
	OUT  0x28+1,R31
	OUT  0x28,R30
;            RC=(int)(148+Udk_1/1.2);
	CALL SUBOPT_0x18
	CALL SUBOPT_0x1A
	CALL SUBOPT_0x1B
	CALL SUBOPT_0x1C
;      OCR3CH=RC*10/256;
;      OCR3CL=RC*10%256;
;            }
;}
_0x66:
	RET
; .FEND
;#include "ham_main.c"
;void main(void)
; 0000 0027 {
_main:
; .FSTART _main
; unsigned char lcd_buffer[16];
;// Declare your local variables here
;
;// Input/Output Ports initialization
;// Port A initialization
;// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
;// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
;PORTA=0x00;
	SBIW R28,16
;	lcd_buffer -> Y+0
	LDI  R30,LOW(0)
	OUT  0x1B,R30
;DDRA=0x00;
	OUT  0x1A,R30
;
;// Port B initialization
;// Func7=In Func6=Out Func5=Out Func4=In Func3=In Func2=In Func1=In Func0=In
;// State7=T State6=0 State5=0 State4=T State3=T State2=T State1=T State0=T
;PORTB=0x00;
	OUT  0x18,R30
;DDRB=0x60;
	LDI  R30,LOW(96)
	OUT  0x17,R30
;
;// Port C initialization
;// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
;// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
;PORTC=0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
;DDRC=0x00;
	OUT  0x14,R30
;
;// Port D initialization
;// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
;// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
;PORTD=0xFF;
	LDI  R30,LOW(255)
	OUT  0x12,R30
;DDRD=0x00;
	LDI  R30,LOW(0)
	OUT  0x11,R30
;
;// Port E initialization
;// Func7=Out Func6=Out Func5=Out Func4=Out Func3=Out Func2=In Func1=In Func0=In
;// State7=0 State6=0 State5=0 State4=0 State3=0 State2=T State1=T State0=T
;PORTE=0x00;
	OUT  0x3,R30
;DDRE=0xF8;
	LDI  R30,LOW(248)
	OUT  0x2,R30
;
;// Port F initialization
;// Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In
;// State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T
;PORTF=0x00;
	LDI  R30,LOW(0)
	STS  98,R30
;DDRF=0x00;
	STS  97,R30
;
;// Port G initialization
;// Func4=In Func3=In Func2=In Func1=In Func0=In
;// State4=T State3=T State2=T State1=T State0=T
;PORTG=0x00;
	STS  101,R30
;DDRG=0x00;
	STS  100,R30
;
;// Timer/Counter 0 initialization
;// Clock source: System Clock
;// Clock value: 1000,000 kHz
;// Mode: CTC top=OCR0
;// OC0 output: Disconnected
;ASSR=0x00;
	OUT  0x30,R30
;TCCR0=0x0A;
	LDI  R30,LOW(10)
	OUT  0x33,R30
;TCNT0=0x00;
	LDI  R30,LOW(0)
	OUT  0x32,R30
;OCR0=0x63;
	LDI  R30,LOW(99)
	OUT  0x31,R30
;
;// Timer/Counter 1 initialization
;// Clock source: System Clock
;// Clock value: 125,000 kHz
;// Mode: Fast PWM top=0x03FF
;// OC1A output: Non-Inv.
;// OC1B output: Non-Inv.
;// OC1C output: Discon.
;// Noise Canceler: Off
;// Input Capture on Falling Edge
;// Timer1 Overflow Interrupt: Off
;// Input Capture Interrupt: Off
;// Compare A Match Interrupt: Off
;// Compare B Match Interrupt: Off
;// Compare C Match Interrupt: Off
;TCCR1A=0xA3;
	LDI  R30,LOW(163)
	OUT  0x2F,R30
;TCCR1B=0x0B;
	LDI  R30,LOW(11)
	OUT  0x2E,R30
;TCNT1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x2D,R30
;TCNT1L=0x00;
	OUT  0x2C,R30
;ICR1H=0x00;
	OUT  0x27,R30
;ICR1L=0x00;
	OUT  0x26,R30
;OCR1AH=0x00;
	OUT  0x2B,R30
;OCR1AL=0x00;
	OUT  0x2A,R30
;OCR1BH=0x00;
	OUT  0x29,R30
;OCR1BL=0x00;
	OUT  0x28,R30
;OCR1CH=0x00;
	STS  121,R30
;OCR1CL=0x00;
	STS  120,R30
;
;// Timer/Counter 2 initialization
;// Clock source: System Clock
;// Clock value: Timer2 Stopped
;// Mode: Normal top=0xFF
;// OC2 output: Disconnected
;TCCR2=0x00;
	OUT  0x25,R30
;TCNT2=0x00;
	OUT  0x24,R30
;OCR2=0x00;
	OUT  0x23,R30
;
;// Timer/Counter 3 initialization
;// Clock source: System Clock
;// Clock value: 1000,000 kHz
;// Mode: Fast PWM top=ICR3
;// OC3A output: Non-Inv.
;// OC3B output: Non-Inv.
;// OC3C output: Non-Inv.
;// Noise Canceler: Off
;// Input Capture on Falling Edge
;// Timer3 Overflow Interrupt: Off
;// Input Capture Interrupt: Off
;// Compare A Match Interrupt: Off
;// Compare B Match Interrupt: Off
;// Compare C Match Interrupt: Off
;TCCR3A=0xAA;
	LDI  R30,LOW(170)
	STS  139,R30
;TCCR3B=0x1A;
	LDI  R30,LOW(26)
	STS  138,R30
;TCNT3H=0x00;
	LDI  R30,LOW(0)
	STS  137,R30
;TCNT3L=0x00;
	STS  136,R30
;ICR3H=20000/256;
	LDI  R30,LOW(78)
	STS  129,R30
;ICR3L=20000/256;
	STS  128,R30
;OCR3CH=1480/256;
	LDI  R30,LOW(5)
	STS  131,R30
;OCR3CL=1480%256;
	LDI  R30,LOW(200)
	STS  130,R30
;OCR3BH=2000/256;
	LDI  R30,LOW(7)
	STS  133,R30
;OCR3BL=2000%256;
	LDI  R30,LOW(208)
	STS  132,R30
;OCR3AH=2000/256;;
	LDI  R30,LOW(7)
	STS  135,R30
;OCR3AL=2000%256;
	LDI  R30,LOW(208)
	STS  134,R30
;// External Interrupt(s) initialization
;// INT0: Off
;// INT1: Off
;// INT2: Off
;// INT3: Off
;// INT4: Off
;// INT5: Off
;// INT6: Off
;// INT7: Off
;EICRA=0x00;
	LDI  R30,LOW(0)
	STS  106,R30
;EICRB=0x00;
	OUT  0x3A,R30
;EIMSK=0x00;
	OUT  0x39,R30
;
;// Timer(s)/Counter(s) Interrupt(s) initialization
;TIMSK=0x02;
	LDI  R30,LOW(2)
	OUT  0x37,R30
;
;ETIMSK=0x00;
	LDI  R30,LOW(0)
	STS  125,R30
;
;// USART0 initialization
;// USART0 disabled
;UCSR0B=0x00;
	OUT  0xA,R30
;
;// USART1 initialization
;// USART1 disabled
;UCSR1B=0x00;
	STS  154,R30
;
;// Analog Comparator initialization
;// Analog Comparator: Off
;// Analog Comparator Input Capture by Timer/Counter 1: Off
;ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
;SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;
;// ADC initialization
;// ADC Clock frequency: 1000,000 kHz
;// ADC Voltage Reference: AREF pin
;ADMUX=ADC_VREF_TYPE & 0xff;
	OUT  0x7,R30
;ADCSRA=0x83;
	LDI  R30,LOW(131)
	OUT  0x6,R30
;
;// SPI initialization
;// SPI disabled
;SPCR=0x00;
	LDI  R30,LOW(0)
	OUT  0xD,R30
;
;// TWI initialization
;// TWI disabled
;TWCR=0x00;
	STS  116,R30
;
;// Alphanumeric LCD initialization
;// Connections specified in the
;// Project|Configure|C Compiler|Libraries|Alphanumeric LCD menu:
;// RS - PORTA Bit 0
;// RD - PORTA Bit 1
;// EN - PORTA Bit 2
;// D4 - PORTA Bit 4
;// D5 - PORTA Bit 5
;// D6 - PORTA Bit 6
;// D7 - PORTA Bit 7
;// Characters/line: 16
;lcd_init(16);
	LDI  R26,LOW(16)
	CALL _lcd_init
;
;TWCR=0x00;
	LDI  R30,LOW(0)
	STS  116,R30
;
;max_e=Mid/5;
	MOVW R26,R12
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CALL __DIVW21
	MOVW R10,R30
;
; #asm("sei")
	sei
; //level[0]=k[0];
; //level[7]=k[1];
; 0000 0028 while (1)
_0x69:
; 0000 0029       {
; 0000 002A       setnguong();
	RCALL _setnguong
; 0000 002B       if(PIND.5==0)
	SBIC 0x10,5
	RJMP _0x6C
; 0000 002C       while(1)
_0x6D:
; 0000 002D       {
; 0000 002E       banhlai();
	RCALL _banhlai
; 0000 002F       // dieu khien servo
; 0000 0030       RC1=200;
	LDI  R30,LOW(200)
	STS  _RC1,R30
; 0000 0031       RC2=300;
	LDI  R30,LOW(44)
	STS  _RC2,R30
; 0000 0032 
; 0000 0033       //hien thi len lcd
; 0000 0034       sprintf(lcd_buffer,"Vitrixe=%d %d",Udk_1,v);
	MOVW R30,R28
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,70
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R6
	CALL __CWD1
	CALL __PUTPARD1
	LDS  R30,_v
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	CALL SUBOPT_0xF
; 0000 0035         lcd_gotoxy(0,0);
	CALL SUBOPT_0x7
; 0000 0036         lcd_puts(lcd_buffer);
	MOVW R26,R28
	CALL _lcd_puts
; 0000 0037         sprintf(lcd_buffer,"%d  %d ",OCR1A,OCR1B);
	MOVW R30,R28
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,84
	ST   -Y,R31
	ST   -Y,R30
	IN   R30,0x2A
	IN   R31,0x2A+1
	CALL SUBOPT_0xA
	IN   R30,0x28
	IN   R31,0x28+1
	CALL SUBOPT_0xA
	CALL SUBOPT_0xF
; 0000 0038         lcd_gotoxy(0,1);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(1)
	CALL _lcd_gotoxy
; 0000 0039         lcd_puts(lcd_buffer);
	MOVW R26,R28
	CALL _lcd_puts
; 0000 003A 
; 0000 003B }
	RJMP _0x6D
; 0000 003C } }
_0x6C:
	RJMP _0x69
_0x70:
	RJMP _0x70
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG
_put_buff_G100:
; .FSTART _put_buff_G100
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	CALL __GETW1P
	SBIW R30,0
	BREQ _0x2000010
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,4
	CALL __GETW1P
	MOVW R16,R30
	SBIW R30,0
	BREQ _0x2000012
	__CPWRN 16,17,2
	BRLO _0x2000013
	MOVW R30,R16
	SBIW R30,1
	MOVW R16,R30
	__PUTW1SNS 2,4
_0x2000012:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ADIW R26,2
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	SBIW R30,1
	LDD  R26,Y+4
	STD  Z+0,R26
_0x2000013:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	CALL __GETW1P
	TST  R31
	BRMI _0x2000014
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
_0x2000014:
	RJMP _0x2000015
_0x2000010:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	ST   X+,R30
	ST   X,R31
_0x2000015:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
; .FEND
__print_G100:
; .FSTART __print_G100
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,6
	CALL __SAVELOCR6
	LDI  R17,0
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
_0x2000016:
	LDD  R30,Y+18
	LDD  R31,Y+18+1
	ADIW R30,1
	STD  Y+18,R30
	STD  Y+18+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R18,R30
	CPI  R30,0
	BRNE PC+2
	RJMP _0x2000018
	MOV  R30,R17
	CPI  R30,0
	BRNE _0x200001C
	CPI  R18,37
	BRNE _0x200001D
	LDI  R17,LOW(1)
	RJMP _0x200001E
_0x200001D:
	CALL SUBOPT_0x1D
_0x200001E:
	RJMP _0x200001B
_0x200001C:
	CPI  R30,LOW(0x1)
	BRNE _0x200001F
	CPI  R18,37
	BRNE _0x2000020
	CALL SUBOPT_0x1D
	RJMP _0x20000CC
_0x2000020:
	LDI  R17,LOW(2)
	LDI  R20,LOW(0)
	LDI  R16,LOW(0)
	CPI  R18,45
	BRNE _0x2000021
	LDI  R16,LOW(1)
	RJMP _0x200001B
_0x2000021:
	CPI  R18,43
	BRNE _0x2000022
	LDI  R20,LOW(43)
	RJMP _0x200001B
_0x2000022:
	CPI  R18,32
	BRNE _0x2000023
	LDI  R20,LOW(32)
	RJMP _0x200001B
_0x2000023:
	RJMP _0x2000024
_0x200001F:
	CPI  R30,LOW(0x2)
	BRNE _0x2000025
_0x2000024:
	LDI  R21,LOW(0)
	LDI  R17,LOW(3)
	CPI  R18,48
	BRNE _0x2000026
	ORI  R16,LOW(128)
	RJMP _0x200001B
_0x2000026:
	RJMP _0x2000027
_0x2000025:
	CPI  R30,LOW(0x3)
	BREQ PC+2
	RJMP _0x200001B
_0x2000027:
	CPI  R18,48
	BRLO _0x200002A
	CPI  R18,58
	BRLO _0x200002B
_0x200002A:
	RJMP _0x2000029
_0x200002B:
	LDI  R26,LOW(10)
	MUL  R21,R26
	MOV  R21,R0
	MOV  R30,R18
	SUBI R30,LOW(48)
	ADD  R21,R30
	RJMP _0x200001B
_0x2000029:
	MOV  R30,R18
	CPI  R30,LOW(0x63)
	BRNE _0x200002F
	CALL SUBOPT_0x1E
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	LDD  R26,Z+4
	ST   -Y,R26
	CALL SUBOPT_0x1F
	RJMP _0x2000030
_0x200002F:
	CPI  R30,LOW(0x73)
	BRNE _0x2000032
	CALL SUBOPT_0x1E
	CALL SUBOPT_0x20
	CALL _strlen
	MOV  R17,R30
	RJMP _0x2000033
_0x2000032:
	CPI  R30,LOW(0x70)
	BRNE _0x2000035
	CALL SUBOPT_0x1E
	CALL SUBOPT_0x20
	CALL _strlenf
	MOV  R17,R30
	ORI  R16,LOW(8)
_0x2000033:
	ORI  R16,LOW(2)
	ANDI R16,LOW(127)
	LDI  R19,LOW(0)
	RJMP _0x2000036
_0x2000035:
	CPI  R30,LOW(0x64)
	BREQ _0x2000039
	CPI  R30,LOW(0x69)
	BRNE _0x200003A
_0x2000039:
	ORI  R16,LOW(4)
	RJMP _0x200003B
_0x200003A:
	CPI  R30,LOW(0x75)
	BRNE _0x200003C
_0x200003B:
	LDI  R30,LOW(_tbl10_G100*2)
	LDI  R31,HIGH(_tbl10_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(5)
	RJMP _0x200003D
_0x200003C:
	CPI  R30,LOW(0x58)
	BRNE _0x200003F
	ORI  R16,LOW(8)
	RJMP _0x2000040
_0x200003F:
	CPI  R30,LOW(0x78)
	BREQ PC+2
	RJMP _0x2000071
_0x2000040:
	LDI  R30,LOW(_tbl16_G100*2)
	LDI  R31,HIGH(_tbl16_G100*2)
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R17,LOW(4)
_0x200003D:
	SBRS R16,2
	RJMP _0x2000042
	CALL SUBOPT_0x1E
	CALL SUBOPT_0x21
	LDD  R26,Y+11
	TST  R26
	BRPL _0x2000043
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	CALL __ANEGW1
	STD  Y+10,R30
	STD  Y+10+1,R31
	LDI  R20,LOW(45)
_0x2000043:
	CPI  R20,0
	BREQ _0x2000044
	SUBI R17,-LOW(1)
	RJMP _0x2000045
_0x2000044:
	ANDI R16,LOW(251)
_0x2000045:
	RJMP _0x2000046
_0x2000042:
	CALL SUBOPT_0x1E
	CALL SUBOPT_0x21
_0x2000046:
_0x2000036:
	SBRC R16,0
	RJMP _0x2000047
_0x2000048:
	CP   R17,R21
	BRSH _0x200004A
	SBRS R16,7
	RJMP _0x200004B
	SBRS R16,2
	RJMP _0x200004C
	ANDI R16,LOW(251)
	MOV  R18,R20
	SUBI R17,LOW(1)
	RJMP _0x200004D
_0x200004C:
	LDI  R18,LOW(48)
_0x200004D:
	RJMP _0x200004E
_0x200004B:
	LDI  R18,LOW(32)
_0x200004E:
	CALL SUBOPT_0x1D
	SUBI R21,LOW(1)
	RJMP _0x2000048
_0x200004A:
_0x2000047:
	MOV  R19,R17
	SBRS R16,1
	RJMP _0x200004F
_0x2000050:
	CPI  R19,0
	BREQ _0x2000052
	SBRS R16,3
	RJMP _0x2000053
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	LPM  R18,Z+
	STD  Y+6,R30
	STD  Y+6+1,R31
	RJMP _0x2000054
_0x2000053:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
_0x2000054:
	CALL SUBOPT_0x1D
	CPI  R21,0
	BREQ _0x2000055
	SUBI R21,LOW(1)
_0x2000055:
	SUBI R19,LOW(1)
	RJMP _0x2000050
_0x2000052:
	RJMP _0x2000056
_0x200004F:
_0x2000058:
	LDI  R18,LOW(48)
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL __GETW1PF
	STD  Y+8,R30
	STD  Y+8+1,R31
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,2
	STD  Y+6,R30
	STD  Y+6+1,R31
_0x200005A:
	LDD  R30,Y+8
	LDD  R31,Y+8+1
	LDD  R26,Y+10
	LDD  R27,Y+10+1
	CP   R26,R30
	CPC  R27,R31
	BRLO _0x200005C
	SUBI R18,-LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	LDD  R30,Y+10
	LDD  R31,Y+10+1
	SUB  R30,R26
	SBC  R31,R27
	STD  Y+10,R30
	STD  Y+10+1,R31
	RJMP _0x200005A
_0x200005C:
	CPI  R18,58
	BRLO _0x200005D
	SBRS R16,3
	RJMP _0x200005E
	SUBI R18,-LOW(7)
	RJMP _0x200005F
_0x200005E:
	SUBI R18,-LOW(39)
_0x200005F:
_0x200005D:
	SBRC R16,4
	RJMP _0x2000061
	CPI  R18,49
	BRSH _0x2000063
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,1
	BRNE _0x2000062
_0x2000063:
	RJMP _0x20000CD
_0x2000062:
	CP   R21,R19
	BRLO _0x2000067
	SBRS R16,0
	RJMP _0x2000068
_0x2000067:
	RJMP _0x2000066
_0x2000068:
	LDI  R18,LOW(32)
	SBRS R16,7
	RJMP _0x2000069
	LDI  R18,LOW(48)
_0x20000CD:
	ORI  R16,LOW(16)
	SBRS R16,2
	RJMP _0x200006A
	ANDI R16,LOW(251)
	ST   -Y,R20
	CALL SUBOPT_0x1F
	CPI  R21,0
	BREQ _0x200006B
	SUBI R21,LOW(1)
_0x200006B:
_0x200006A:
_0x2000069:
_0x2000061:
	CALL SUBOPT_0x1D
	CPI  R21,0
	BREQ _0x200006C
	SUBI R21,LOW(1)
_0x200006C:
_0x2000066:
	SUBI R19,LOW(1)
	LDD  R26,Y+8
	LDD  R27,Y+8+1
	SBIW R26,2
	BRLO _0x2000059
	RJMP _0x2000058
_0x2000059:
_0x2000056:
	SBRS R16,0
	RJMP _0x200006D
_0x200006E:
	CPI  R21,0
	BREQ _0x2000070
	SUBI R21,LOW(1)
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL SUBOPT_0x1F
	RJMP _0x200006E
_0x2000070:
_0x200006D:
_0x2000071:
_0x2000030:
_0x20000CC:
	LDI  R17,LOW(0)
_0x200001B:
	RJMP _0x2000016
_0x2000018:
	LDD  R26,Y+12
	LDD  R27,Y+12+1
	CALL __GETW1P
	CALL __LOADLOCR6
	ADIW R28,20
	RET
; .FEND
_sprintf:
; .FSTART _sprintf
	PUSH R15
	MOV  R15,R24
	SBIW R28,6
	CALL __SAVELOCR4
	CALL SUBOPT_0x22
	SBIW R30,0
	BRNE _0x2000072
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	RJMP _0x2080003
_0x2000072:
	MOVW R26,R28
	ADIW R26,6
	CALL __ADDW2R15
	MOVW R16,R26
	CALL SUBOPT_0x22
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDI  R30,LOW(0)
	STD  Y+8,R30
	STD  Y+8+1,R30
	MOVW R26,R28
	ADIW R26,10
	CALL __ADDW2R15
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R30,LOW(_put_buff_G100)
	LDI  R31,HIGH(_put_buff_G100)
	ST   -Y,R31
	ST   -Y,R30
	MOVW R26,R28
	ADIW R26,10
	RCALL __print_G100
	MOVW R18,R30
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R30,R18
_0x2080003:
	CALL __LOADLOCR4
	ADIW R28,10
	POP  R15
	RET
; .FEND
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif

	.DSEG

	.CSEG
__lcd_write_nibble_G101:
; .FSTART __lcd_write_nibble_G101
	ST   -Y,R26
	LD   R30,Y
	ANDI R30,LOW(0x10)
	BREQ _0x2020004
	SBI  0x1B,3
	RJMP _0x2020005
_0x2020004:
	CBI  0x1B,3
_0x2020005:
	LD   R30,Y
	ANDI R30,LOW(0x20)
	BREQ _0x2020006
	SBI  0x1B,2
	RJMP _0x2020007
_0x2020006:
	CBI  0x1B,2
_0x2020007:
	LD   R30,Y
	ANDI R30,LOW(0x40)
	BREQ _0x2020008
	SBI  0x1B,1
	RJMP _0x2020009
_0x2020008:
	CBI  0x1B,1
_0x2020009:
	LD   R30,Y
	ANDI R30,LOW(0x80)
	BREQ _0x202000A
	SBI  0x1B,0
	RJMP _0x202000B
_0x202000A:
	CBI  0x1B,0
_0x202000B:
	__DELAY_USB 13
	SBI  0x1B,4
	__DELAY_USB 13
	CBI  0x1B,4
	__DELAY_USB 13
	RJMP _0x2080001
; .FEND
__lcd_write_data:
; .FSTART __lcd_write_data
	ST   -Y,R26
	LD   R26,Y
	RCALL __lcd_write_nibble_G101
    ld    r30,y
    swap  r30
    st    y,r30
	LD   R26,Y
	RCALL __lcd_write_nibble_G101
	__DELAY_USB 133
	RJMP _0x2080001
; .FEND
_lcd_gotoxy:
; .FSTART _lcd_gotoxy
	ST   -Y,R26
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-__base_y_G101)
	SBCI R31,HIGH(-__base_y_G101)
	LD   R30,Z
	LDD  R26,Y+1
	ADD  R26,R30
	RCALL __lcd_write_data
	LDD  R30,Y+1
	STS  __lcd_x,R30
	LD   R30,Y
	STS  __lcd_y,R30
	ADIW R28,2
	RET
; .FEND
_lcd_clear:
; .FSTART _lcd_clear
	LDI  R26,LOW(2)
	CALL SUBOPT_0x23
	LDI  R26,LOW(12)
	RCALL __lcd_write_data
	LDI  R26,LOW(1)
	CALL SUBOPT_0x23
	LDI  R30,LOW(0)
	STS  __lcd_y,R30
	STS  __lcd_x,R30
	RET
; .FEND
_lcd_putchar:
; .FSTART _lcd_putchar
	ST   -Y,R26
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BREQ _0x2020011
	LDS  R30,__lcd_maxx
	LDS  R26,__lcd_x
	CP   R26,R30
	BRLO _0x2020010
_0x2020011:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R26,__lcd_y
	SUBI R26,-LOW(1)
	STS  __lcd_y,R26
	RCALL _lcd_gotoxy
	LD   R26,Y
	CPI  R26,LOW(0xA)
	BRNE _0x2020013
	RJMP _0x2080001
_0x2020013:
_0x2020010:
	LDS  R30,__lcd_x
	SUBI R30,-LOW(1)
	STS  __lcd_x,R30
	SBI  0x1B,6
	LD   R26,Y
	RCALL __lcd_write_data
	CBI  0x1B,6
	RJMP _0x2080001
; .FEND
_lcd_puts:
; .FSTART _lcd_puts
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2020014:
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LD   R30,X+
	STD  Y+1,R26
	STD  Y+1+1,R27
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2020016
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2020014
_0x2020016:
	RJMP _0x2080002
; .FEND
_lcd_putsf:
; .FSTART _lcd_putsf
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
_0x2020017:
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	ADIW R30,1
	STD  Y+1,R30
	STD  Y+1+1,R31
	SBIW R30,1
	LPM  R30,Z
	MOV  R17,R30
	CPI  R30,0
	BREQ _0x2020019
	MOV  R26,R17
	RCALL _lcd_putchar
	RJMP _0x2020017
_0x2020019:
_0x2080002:
	LDD  R17,Y+0
	ADIW R28,3
	RET
; .FEND
_lcd_init:
; .FSTART _lcd_init
	ST   -Y,R26
	SBI  0x1A,3
	SBI  0x1A,2
	SBI  0x1A,1
	SBI  0x1A,0
	SBI  0x1A,4
	SBI  0x1A,6
	SBI  0x1A,5
	CBI  0x1B,4
	CBI  0x1B,6
	CBI  0x1B,5
	LD   R30,Y
	STS  __lcd_maxx,R30
	SUBI R30,-LOW(128)
	__PUTB1MN __base_y_G101,2
	LD   R30,Y
	SUBI R30,-LOW(192)
	__PUTB1MN __base_y_G101,3
	CALL SUBOPT_0x10
	CALL SUBOPT_0x24
	CALL SUBOPT_0x24
	CALL SUBOPT_0x24
	LDI  R26,LOW(32)
	RCALL __lcd_write_nibble_G101
	__DELAY_USW 200
	LDI  R26,LOW(40)
	RCALL __lcd_write_data
	LDI  R26,LOW(4)
	RCALL __lcd_write_data
	LDI  R26,LOW(133)
	RCALL __lcd_write_data
	LDI  R26,LOW(6)
	RCALL __lcd_write_data
	RCALL _lcd_clear
_0x2080001:
	ADIW R28,1
	RET
; .FEND

	.CSEG

	.CSEG
_strlen:
; .FSTART _strlen
	ST   -Y,R27
	ST   -Y,R26
    ld   r26,y+
    ld   r27,y+
    clr  r30
    clr  r31
strlen0:
    ld   r22,x+
    tst  r22
    breq strlen1
    adiw r30,1
    rjmp strlen0
strlen1:
    ret
; .FEND
_strlenf:
; .FSTART _strlenf
	ST   -Y,R27
	ST   -Y,R26
    clr  r26
    clr  r27
    ld   r30,y+
    ld   r31,y+
strlenf0:
	lpm  r0,z+
    tst  r0
    breq strlenf1
    adiw r26,1
    rjmp strlenf0
strlenf1:
    movw r30,r26
    ret
; .FEND

	.DSEG
_adc:
	.BYTE 0x10
_status:
	.BYTE 0x8
_error:
	.BYTE 0x4
_old_error:
	.BYTE 0x4
_Kp:
	.BYTE 0x4
_Kd:
	.BYTE 0x4
_Ki:
	.BYTE 0x4

	.ESEG
_level:
	.DB  0x2C,0x1,0xBC,0x2
	.DB  0xBC,0x2,0xBC,0x2
	.DB  0xBC,0x2,0xBC,0x2
	.DB  0xBC,0x2,0x58,0x2

	.DSEG
_speed:
	.BYTE 0x2
_RC:
	.BYTE 0x1
_RC1:
	.BYTE 0x1
_RC2:
	.BYTE 0x1
_RC3:
	.BYTE 0x1
_RC4:
	.BYTE 0x1
_RC5:
	.BYTE 0x1
_v:
	.BYTE 0x1
_max_adc:
	.BYTE 0x10
_min_adc:
	.BYTE 0x10
_i:
	.BYTE 0x1
__base_y_G101:
	.BYTE 0x4
__lcd_x:
	.BYTE 0x1
__lcd_y:
	.BYTE 0x1
__lcd_maxx:
	.BYTE 0x1

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	MOV  R30,R17
	LDI  R26,LOW(_level)
	LDI  R27,HIGH(_level)
	LDI  R31,0
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x1:
	MOV  R30,R17
	LDI  R26,LOW(_adc)
	LDI  R27,HIGH(_adc)
	LDI  R31,0
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:33 WORDS
SUBOPT_0x2:
	MOVW R30,R28
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0x0,0
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:25 WORDS
SUBOPT_0x3:
	CALL _read_adc
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x4:
	LDI  R24,16
	CALL _sprintf
	ADIW R28,20
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x5:
	LDI  R26,LOW(0)
	CALL _lcd_gotoxy
	MOVW R26,R28
	ADIW R26,1
	CALL _lcd_puts
	RJMP SUBOPT_0x2

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x6:
	LDI  R26,LOW(1)
	CALL _lcd_gotoxy
	MOVW R26,R28
	ADIW R26,1
	JMP  _lcd_puts

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x7:
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(0)
	JMP  _lcd_gotoxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x8:
	CALL _lcd_putsf
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _delay_ms
	LDI  R17,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	MOV  R30,R17
	LDI  R26,LOW(_max_adc)
	LDI  R27,HIGH(_max_adc)
	LDI  R31,0
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 24 TIMES, CODE SIZE REDUCTION:43 WORDS
SUBOPT_0xA:
	CLR  R22
	CLR  R23
	CALL __PUTPARD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB:
	CALL _lcd_clear
	RJMP SUBOPT_0x7

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xC:
	MOV  R30,R17
	LDI  R26,LOW(_min_adc)
	LDI  R27,HIGH(_min_adc)
	LDI  R31,0
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD:
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0xE:
	CALL __EEPROMRDW
	RJMP SUBOPT_0xA

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xF:
	LDI  R24,8
	CALL _sprintf
	ADIW R28,12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x10:
	LDI  R26,LOW(20)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x11:
	CALL __CWD1
	CALL __CDF1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x12:
	STS  _error,R30
	STS  _error+1,R31
	STS  _error+2,R22
	STS  _error+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x13:
	LDS  R30,_error
	LDS  R31,_error+1
	LDS  R22,_error+2
	LDS  R23,_error+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x14:
	CALL __CWD2
	CALL __CDF2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x15:
	CALL __ADDF12
	CALL __CFD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x16:
	__PUTD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x17:
	__GETD2S 4
	RCALL SUBOPT_0x11
	CALL __CMPF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x18:
	MOVW R30,R6
	RCALL SUBOPT_0x11
	MOVW R26,R30
	MOVW R24,R22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x19:
	CALL __DIVF21
	MOVW R26,R6
	RCALL SUBOPT_0x14
	CALL __MULF12
	LDS  R26,_speed
	LDS  R27,_speed+1
	RJMP SUBOPT_0x14

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1A:
	__GETD1N 0x3F99999A
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1B:
	CALL __DIVF21
	__GETD2N 0x43140000
	RJMP SUBOPT_0x15

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:16 WORDS
SUBOPT_0x1C:
	STS  _RC,R30
	LDS  R26,_RC
	LDI  R30,LOW(10)
	MUL  R30,R26
	MOVW R30,R0
	MOVW R26,R30
	LDI  R30,LOW(256)
	LDI  R31,HIGH(256)
	CALL __DIVW21
	STS  131,R30
	LDS  R30,_RC
	LDI  R26,LOW(10)
	MULS R30,R26
	MOVW R30,R0
	STS  130,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x1D:
	ST   -Y,R18
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x1E:
	LDD  R30,Y+16
	LDD  R31,Y+16+1
	SBIW R30,4
	STD  Y+16,R30
	STD  Y+16+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1F:
	LDD  R26,Y+13
	LDD  R27,Y+13+1
	LDD  R30,Y+15
	LDD  R31,Y+15+1
	ICALL
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x20:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x21:
	LDD  R26,Y+16
	LDD  R27,Y+16+1
	ADIW R26,4
	CALL __GETW1P
	STD  Y+10,R30
	STD  Y+10+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x22:
	MOVW R26,R28
	ADIW R26,12
	CALL __ADDW2R15
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x23:
	CALL __lcd_write_data
	LDI  R26,LOW(3)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x24:
	LDI  R26,LOW(48)
	CALL __lcd_write_nibble_G101
	__DELAY_USW 200
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ANEGF1:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __ANEGF10
	SUBI R23,0x80
__ANEGF10:
	RET

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__SWAPACC:
	PUSH R20
	MOVW R20,R30
	MOVW R30,R26
	MOVW R26,R20
	MOVW R20,R22
	MOVW R22,R24
	MOVW R24,R20
	MOV  R20,R0
	MOV  R0,R1
	MOV  R1,R20
	POP  R20
	RET

__UADD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	RET

__NEGMAN1:
	COM  R30
	COM  R31
	COM  R22
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	RET

__SUBF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129
	LDI  R21,0x80
	EOR  R1,R21

	RJMP __ADDF120

__ADDF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129

__ADDF120:
	CPI  R23,0x80
	BREQ __ADDF128
__ADDF121:
	MOV  R21,R23
	SUB  R21,R25
	BRVS __ADDF1211
	BRPL __ADDF122
	RCALL __SWAPACC
	RJMP __ADDF121
__ADDF122:
	CPI  R21,24
	BRLO __ADDF123
	CLR  R26
	CLR  R27
	CLR  R24
__ADDF123:
	CPI  R21,8
	BRLO __ADDF124
	MOV  R26,R27
	MOV  R27,R24
	CLR  R24
	SUBI R21,8
	RJMP __ADDF123
__ADDF124:
	TST  R21
	BREQ __ADDF126
__ADDF125:
	LSR  R24
	ROR  R27
	ROR  R26
	DEC  R21
	BRNE __ADDF125
__ADDF126:
	MOV  R21,R0
	EOR  R21,R1
	BRMI __ADDF127
	RCALL __UADD12
	BRCC __ADDF129
	ROR  R22
	ROR  R31
	ROR  R30
	INC  R23
	BRVC __ADDF129
	RJMP __MAXRES
__ADDF128:
	RCALL __SWAPACC
__ADDF129:
	RCALL __REPACK
	POP  R21
	RET
__ADDF1211:
	BRCC __ADDF128
	RJMP __ADDF129
__ADDF127:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	BREQ __ZERORES
	BRCC __ADDF1210
	COM  R0
	RCALL __NEGMAN1
__ADDF1210:
	TST  R22
	BRMI __ADDF129
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVC __ADDF1210

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__CMPF12:
	TST  R25
	BRMI __CMPF120
	TST  R23
	BRMI __CMPF121
	CP   R25,R23
	BRLO __CMPF122
	BRNE __CMPF121
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	BRLO __CMPF122
	BREQ __CMPF123
__CMPF121:
	CLZ
	CLC
	RET
__CMPF122:
	CLZ
	SEC
	RET
__CMPF123:
	SEZ
	CLC
	RET
__CMPF120:
	TST  R23
	BRPL __CMPF122
	CP   R25,R23
	BRLO __CMPF121
	BRNE __CMPF122
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	BRLO __CMPF122
	BREQ __CMPF123
	RJMP __CMPF121

__ADDW2R15:
	CLR  R0
	ADD  R26,R15
	ADC  R27,R0
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__CWD2:
	MOV  R24,R27
	ADD  R24,R24
	SBC  R24,R24
	MOV  R25,R24
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__CDF2U:
	SET
	RJMP __CDF2U0
__CDF2:
	CLT
__CDF2U0:
	RCALL __SWAPD12
	RCALL __CDF1U0

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__EEPROMRDW:
	ADIW R26,1
	RCALL __EEPROMRDB
	MOV  R31,R30
	SBIW R26,1

__EEPROMRDB:
	SBIC EECR,EEWE
	RJMP __EEPROMRDB
	PUSH R31
	IN   R31,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R30,EEDR
	OUT  SREG,R31
	POP  R31
	RET

__EEPROMWRW:
	RCALL __EEPROMWRB
	ADIW R26,1
	PUSH R30
	MOV  R30,R31
	RCALL __EEPROMWRB
	POP  R30
	SBIW R26,1
	RET

__EEPROMWRB:
	SBIS EECR,EEWE
	RJMP __EEPROMWRB1
	WDR
	RJMP __EEPROMWRB
__EEPROMWRB1:
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:
