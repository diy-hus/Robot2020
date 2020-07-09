//dat sensor vao vach trang nhan CT1
//dat sensor vao vach den nhan CT1
//cho luu gia tri nguong vao eeprom

void read_adc_all()
{
    unsigned char i;
    unsigned int temp;
    outStatus = 0;

    for (i = 0; i < chanel; i++)
    {
        if (read_adc(i) > level[i])
        {
            outStatus = outStatus | (0x80 >> i);
        }
        delay_us(50);
    }
}

void setnguong(void)
{
    unsigned char j = 0, lcd_buffer[16];
    unsigned int max_adc[8];
    unsigned int min_adc[8];

    sprintf(lcd_buffer, "%d %d %d %d", read_adc(0), read_adc(1), read_adc(2), read_adc(3));
    lcd_gotoxy(0, 0);
    lcd_puts(lcd_buffer);
    sprintf(lcd_buffer, "%d %d %d %d", read_adc(4), read_adc(5), read_adc(6), read_adc(7));
    lcd_gotoxy(0, 1);
    lcd_puts(lcd_buffer);
    if ((PIND .3 == 0) && (i == 0))
    {
        while (!PIND .3)
            lcd_clear();
        lcd_gotoxy(0, 0);
        lcd_putsf("doc vach trang");
        delay_ms(20);
        {
            for (j = 1; j < 7; j++)
            {
                max_adc[j] = read_adc(j);
            }
        }
        i = 1;
    }
    //hien thi gia tri len lcd
    sprintf(lcd_buffer, "%d %d %d %d", max_adc[0], max_adc[1], max_adc[2], max_adc[3]);
    lcd_gotoxy(0, 0);
    lcd_puts(lcd_buffer);
    sprintf(lcd_buffer, "%d %d %d %d", max_adc[4], max_adc[5], max_adc[6], max_adc[7]);
    lcd_gotoxy(0, 1);
    lcd_puts(lcd_buffer);
    if ((PIND .3 == 0) && (i == 1))
    {
        while (!PIND .3)
        {
            lcd_clear();
            lcd_gotoxy(0, 0);
            lcd_putsf("doc vach den");
            delay_ms(20);
            for (j = 1; j < 7; j++)
            {
                min_adc[j] = read_adc(j);
            }
        }
        i = 2;
        //hien thi gia tri len lcd
        sprintf(lcd_buffer, "%d %d %d %d", min_adc[0], min_adc[1], min_adc[2], min_adc[3]);
        lcd_gotoxy(0, 0);
        lcd_puts(lcd_buffer);
        sprintf(lcd_buffer, "%d %d %d %d", min_adc[4], min_adc[5], min_adc[6], min_adc[7]);
        lcd_gotoxy(0, 1);

        lcd_clear();
        lcd_gotoxy(0, 0);
        lcd_putsf("tinh nguong");
        delay_ms(200);

        for (j = 1; j < 7; j++)
        {
            level[j] = (max_adc[j] + min_adc[j]) / 2;
            delay_ms(200);
            sprintf(lcd_buffer, "%d %d %d %d", level[1], level[2], level[3], level[4]);
            lcd_gotoxy(0, 0);
            lcd_puts(lcd_buffer);
            sprintf(lcd_buffer, "%d %d ", level[5], level[6]);
            lcd_gotoxy(0, 1);
            lcd_puts(lcd_buffer);
            delay_ms(20);
        }
        lcd_clear();
        lcd_gotoxy(0, 0);
        lcd_putsf("da luu san");
        delay_ms(20);
    }
}