/*****************************************************
This program was produced by the
CodeWizardAVR V2.05.0 Professional
Automatic Program Generator
© Copyright 1998-2010 Pavel Haiduc, HP InfoTech s.r.l.
http://www.hpinfotech.com

Project : 
Version : 
Date    : 05/12/2014
Author  : NeVaDa
Company : 
Comments: 


Chip type               : ATmega128L
Program type            : Application
AVR Core Clock frequency: 8,000000 MHz
Memory model            : Small
External RAM size       : 0
Data Stack size         : 1024
*****************************************************/

#include <mega128.h>
#include <stdio.h>

#include <delay.h>

#include <alcd.h>

#define chanel 8
#include "khai_bao.c"
#include "dinh_nghia.c"
#include "khoi_tao.c"
#include "doc_adc.c"
#include "PID.c"
#include "dk_motor.c"
#include "banhlai_hus.c"
#include "ham_main.c"
while (1)
      {  
      setnguong();
      if(PIND.5==0)
      while(1)
      {
      banhlai(); 
      // dieu khien servo
      RC1=200;
      RC2=300;  
      
      //hien thi len lcd            
      sprintf(lcd_buffer,"Vitrixe=%d %d",Udk_1,v);
        lcd_gotoxy(0,0);
        lcd_puts(lcd_buffer);  
        sprintf(lcd_buffer,"%d  %d ",OCR1A,OCR1B);
        lcd_gotoxy(0,1);
        lcd_puts(lcd_buffer);          

}
} }