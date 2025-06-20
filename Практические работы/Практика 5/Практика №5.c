#include <8051.h>
#include <string.h> 

void setInstruction(int instruction) 
{
    P0 = instruction;
    P2 = 0x1; P2 = 0x0;
}

void setData(char data) 
{
    P0 = data;
    P2 = 0x3; P2 = 0x2;
} 

void resetInstructionInput() 
{
    P0 = 0x0;
    P2 = 0x1; P2 = 0x0;
}

void delay(int delayTime)
{
    int i;
    for (i = 0; i < delayTime; i++) { 
        int j; 
        for (j = 0; j < 1400; j++) { } 
    }
}

void main()
{

    unsigned char keypad[4][4] = {  {'1', '2', '3', 'A'},
                                    {'4', '5', '6', 'B'},
                                    {'7', '8', '9', 'C'},
                                    {'*', '0', '#', 'D'} };

    unsigned char startPosP1;
    unsigned char startPosP3;
    unsigned char testP3;
    unsigned char col;
    unsigned char row;
    
    P2 = 0x0; 
    P0 = 0x0;

    P1 = 0b11110000;  
    P3 = 0b11111111;  

    startPosP1 = P1;
    startPosP3 = P3;

    setInstruction(0x80);

    while(1) 
    {
        if (P3 != startPosP3) 
        {
            testP3 = P3;

            if      ((P3 & 0b00000001) == 0) { col = 0; }
            else if ((P3 & 0b00000010) == 0) { col = 1; }
            else if ((P3 & 0b00000100) == 0) { col = 2; }
            else if ((P3 & 0b00001000) == 0) { col = 3; }
            
            P3 = 0b00000000;  
            P1 = 0b11111111;  

            
            if      ((P1 & 0b00000001) == 0) { row = 0; }
            else if ((P1 & 0b00000010) == 0) { row = 1; }
            else if ((P1 & 0b00000100) == 0) { row = 2; }
            else if ((P1 & 0b00001000) == 0) { row = 3; }
            
            
            if (keypad[row][col] == '*') {
                
                setInstruction(0x01);
                delay(40);
            } else {

                setData(keypad[row][col]);
                delay(40);
            }

            P3 = 0b11111111;
            P1 = 0b11110000;
            
            while (P3 == testP3) { }
        } 
    }
}