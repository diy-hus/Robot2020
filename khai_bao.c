unsigned char chanel = 8;
//unsigned int adc[8];
unsigned char status[chanel] = {1, 2, 4, 8, 16, 32, 64, 128};
int outStatus;

float error, old_error, error_sum, Kp = 2, Kd = 12, Ki = 0;
int Udk_1;
int k[2] = {250, 250};
eeprom unsigned int level[chanel];
int dem, max_e, Mid = 700;
int speed = 800;
unsigned char tt = 0, g = 0, RC, RC1, RC2, RC3, RC4, RC5, ttv = 0, v = 0;
unsigned char i = 0;