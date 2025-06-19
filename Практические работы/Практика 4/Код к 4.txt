#include <8051.h>

void msec(int x) 
{
    while(x-- > 0) 
    {
        TH0 = (-1500) >> 8;   
        TL0 = -1500;           
        TR0 = 1;               
        while(TF0 == 0);        
        TF0 = 0;                
        TR0 = 0;                
    }
}

void main() 
{
    TMOD = 0x01;   

    while(1)
    {
        P1 = 0x01;    
        msec(3);      
        
        P1 = 0x02;   
        msec(3);      
 
        P1 = 0x0C;    
        msec(5);      
 
        P1 = 0x30;    
        msec(5);      

        P1 = 0x40;    
        msec(3);      
        
        P1 = 0x80;    
        msec(3);      
    }
}