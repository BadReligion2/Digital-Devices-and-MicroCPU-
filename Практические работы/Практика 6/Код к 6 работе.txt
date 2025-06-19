#include <8051.h>

void tput(unsigned char ch)
{
    SBUF = ch;
    while(!TI);
    TI = 0;
}

void main()
{
    char z;
    int i;
    unsigned char data[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'};
    
    PCON = 0b00000000;  
    SCON = 0b11101000;   
    TMOD = 0b00100000;    
    TH1 = 0xFD;           
    
    TR1 = 1;             

    tput('\n');
    
    for (i = 0; i < 20; i++)  
    {
        tput(data[i]);
    }
    while(1) {}
}