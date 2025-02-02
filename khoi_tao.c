#define ADC_VREF_TYPE 0x00

// Read the AD conversion result
unsigned int read_adc(unsigned char adc_input)
{
ADMUX=adc_input | (ADC_VREF_TYPE & 0xff);
// Delay needed for the stabilization of the ADC input voltage
delay_us(10);
// Start the AD conversion
ADCSRA|=0x40;
// Wait for the AD conversion to complete
while ((ADCSRA & 0x10)==0);
ADCSRA|=0x10;
return 1023-ADCW;
}
// Timer 0 output compare interrupt service routine
interrupt [TIM0_COMP] void timer0_comp_isr(void)
{
 //Place your code here
dem++;
if (dem==200){dem=0;}
if (RC1>dem){servo_1=1;}else{servo_1=0;}
if (RC2>dem){servo_2=1;}else{servo_2=0;}
if (RC3>dem){servo_3=1;}else{servo_3=0;}
if (RC4>dem){servo_4=1;}else{servo_4=0;}
if (RC5>dem){servo_5=1;}else{servo_5=0;}


}