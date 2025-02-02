// Chuong trinh dieu khien Motor
#define motor_1 0
#define motor_2 1
#define motor_3 2
#define motor_4 3

#define run_thuan 1
#define run_nguoc 0

void control_motor_(unsigned char motor,unsigned char dir_motor, unsigned char speed);

void control_motor_(unsigned char motor,unsigned char dir_motor, unsigned char speed)  
{
    switch(motor)
    {
        case 0:
        {         
            PORTB.2 = dir_motor;  
            //if(speed>100)   speed = 100;
            
            OCR1A=speed-Udk_1*(Udk_1/2); 
            break;
        } 
        case 1:
        {         
            PORTB.3 = dir_motor;  
            //if(speed>100)   speed = 100;
  
            OCR1B=speed+Udk_1*(-Udk_1/2);  ;  
            break;
        }
        case 2:
        {         
            PORTE.1 = dir_motor; 
            //if(speed>100)   speed = 100;
            if(dir_motor == 1)  
            {
                OCR3AH = (int)(speed+Udk_1*(-Udk_1/2.1))/256;
                OCR3AL = (int)(speed+Udk_1*(-Udk_1/2.1))%256;
            }  
            else 
            {
                OCR3AH = 1023-(int)(speed+Udk_1*(-Udk_1/2.1))/256;
                OCR3AL = 1023-(int)(speed+Udk_1*(-Udk_1/2.1))%256;
            } 
            break;
        }
        case 3:
        {         
            PORTE.2 = dir_motor;   
            //if(speed>100)   speed = 100;
            if(dir_motor == 1)  
            {
                OCR3BH = (int)(speed-Udk_1*(-Udk_1/2.1))/256;
                OCR3BL = (int)(speed-Udk_1*(-Udk_1/2.1))%256;
            }  
            else 
            {
                OCR3BH = 1023-(int)(speed-Udk_1*(-Udk_1/2.1))/256;
                OCR3BL = 1023-(int)(speed-Udk_1*(-Udk_1/2.1))%256;
            } 
            break;
        }
    }
}
