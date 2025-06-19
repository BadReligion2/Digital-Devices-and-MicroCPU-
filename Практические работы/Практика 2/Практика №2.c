#include <8051.h>

void main()
{
    unsigned char i,j;
    unsigned char massiv[11] = 
    { 
		0xC0,
		0xF9, 
		0xA4, 
		0xB0, 
		0x99, 
		0x92, 
		0x82, 
		0xF8, 
		0x80, 
		0x90, 
		0xFF 
    }; 

    for(i = 0; i < 11; i++) 
    { 
        P2 = massiv[i]; 
        for(j = 0; j < 100; j++)
            continue; 
    } 
    while(1);   
}
