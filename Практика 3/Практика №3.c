#include <8051.h>  
void main()  
{  
	unsigned int i;  
	unsigned char *str="Samsung";   
	P0 = 0x38;  
	P2 = 0x1;  
	P2 = 0x0;  
	P0 = 0x80;  
	P2 = 0x1;  
	P2 = 0x0;  
for(i=0; i<1; i++) 
{  
P0 = str[i]; 
P2 = 0x3; 
P2 = 0x2; 
} 
P0 = 0xC0;
P2 = 0x1;  
P2 = 0x0; 
for(i=1; i<2; i++) 
{  
P0 = str[i]; 
P2 = 0x3; 
P2 = 0x2; 
} 
P0 = 0x81; 
P2 = 0x1;  
P2 = 0x0; 
for(i=2; i<3; i++) 
{  
P0 = str[i]; 
P2 = 0x3; 
P2 = 0x2; 
}  
P0 = 0xC1;
P2 = 0x1;  
P2 = 0x0; 
for(i=3; i<4; i++) 
{  
P0 = str[i]; 
P2 = 0x3; 
P2 = 0x2; 
}  
P0 = 0x82;
P2 = 0x1;  
P2 = 0x0; 
for(i=4; i<5; i++) 
{  
P0 = str[i]; 
P2 = 0x3; 
P2 = 0x2; 
} 
P0 = 0xC2; 
P2 = 0x1;  
P2 = 0x0; 
for(i=5; i<6; i++) 
{  
P0 = str[i]; 
P2 = 0x3; 
P2 = 0x2; 
} 
P0 = 0x83; 
P2 = 0x1;  
P2 = 0x0; 
for(i=6; i<7; i++) 
{  
P0 = str[i]; 
P2 = 0x3; 
P2 = 0x2; 
}   
while(1);  
} 
