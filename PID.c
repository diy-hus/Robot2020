 /////////////////////// TINH VI TRI XE/////////////////////////////////////
int vitrixe()
{
    char j;
    unsigned int sum1=0, sum2=0;
    float temp;  
    read_adc_all();
    /*for (j=1; j<7;j++)
    {
        sum1=sum1+adc[j]*(j+1);
        sum2=sum2+adc[j];
    }
    if (sum2!=0)
    {
        temp = (float)sum1*10;
        temp = temp/sum2;
    }
    else 
        temp=0;
    return temp-45;*/
    int finalPosition;
    //kiem tra adc tu 2 den 7
    for (int i=6; i>0; i--)
    {
        if (outStatus - pow(2, i) > 0) 
        {
            finalPosition = i;
        }
    }

    return finalPosition;
}

//---------------------------------------------------
int PID_control()
 { 
    float delta, Udk; 
    int error_sum=0,Max = 42;
    
    error =(float)vitrixe();            // Sai so dieu khien
    //vi tri xe chay tu 1 - 6 nen can thay doi pid tuong ung
    
    if ((error<-35) && (old_error>=0)) {error=-error;}  
    
    delta = (error - old_error);
    old_error = error;                  //Luu gia tri sai so   
    error_sum = error_sum+error; // Thanh phan tich phan
                                      
    // Khong cho thanh phan tich phan vuot qua gia tri max
    if (error_sum <-max_e) error_sum = -max_e;
    if (error_sum > max_e) error_sum = max_e;
    
    Udk = Kp*error + Ki*error_sum + Kd*delta;  //Tin hieu dieu khien
    
    // Giam sat gia tri dieu khien ko duoc vuot qua ngwong
    if (Udk <-Max) Udk = -Max;
    if (Udk > Max) Udk = Max;
    
    return (int)Udk; 
 }

