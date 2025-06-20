#include <htc.h>
#define F_OSC 12000000UL  
#define T 0.06            
#define Q_INIT 50         
#define Q_MIN 50          
#define Q_MAX 60          


#define C (F_OSC / 12)    
#define R (65536 - (unsigned int)(C * T))  

unsigned int tmpCnt;       

void imp(unsigned int cnt) {
    do {
    } while (TF2 == 0);
    
    TF2 = 0;              
    P10 = 1;             
    

    while (cnt != 0) {
        cnt--;
    }
    
    P10 = 0;              
}

void main() {
    tmpCnt = Q_INIT;      
    

    P1 = 0xFE;
    

    RCAP2H = (R >> 8) & 0xFF;  
    RCAP2L = R & 0xFF;         
    

    T2CON &= 0xFC;
    ET2 = 1;                   
    EA = 1;                    
    T2CON |= 0x4;              
    

    P00 = 1;                   
    P07 = 1;                   
    
    while (1) {

        if (P00 == 0) {       
            if (tmpCnt > Q_MIN) {
                tmpCnt--;
                while (P00 == 0);  
            }
        }
        
        if (P07 == 0) {    
            if (tmpCnt < Q_MAX) {
                tmpCnt++;
                while (P07 == 0); 
            }
        }
        
        imp(tmpCnt);
    }
}