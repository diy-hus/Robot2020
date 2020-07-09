

void banhlai(void)
{ 
      OCR1A=800;
      OCR1B=800; 
      //lai banh truoc
      Udk_1 = PID_control();  
      RC=151;
      //lai banh sau
      if (Udk_1<0)
             {
             PORTB.2 = 0;  
             OCR1A=speed-Udk_1*(Udk_1/0.8); 
             RC=(int)(148+Udk_1/1.2);
      OCR3CH=RC*10/256;
      OCR3CL=RC*10%256; 
             }
      if (Udk_1>0)
            {
           PORTB.3 = 0; 
            OCR1B=speed+Udk_1*(-Udk_1/1.2);  
            RC=(int)(148+Udk_1/1.2);
      OCR3CH=RC*10/256;
      OCR3CL=RC*10%256;   
            }
}
