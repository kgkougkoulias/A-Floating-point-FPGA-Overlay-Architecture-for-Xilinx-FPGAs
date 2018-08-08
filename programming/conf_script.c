#include <stdio.h>
#include <stdlib.h>
#include <inttypes.h>


uint8_t get_conf(int ch){
    
    uint8_t conf;
    
    switch(ch){
        
        case 1: conf = 0x00;
                break;
            
        case 2: conf = 0x01;
                break;
                
        case 3: conf = 0x02;
                break;
                
        case 4: conf = 0x03;
                break;
                
        case 5: conf = 0x04;
                break;
        
        case 6: conf = 0x08;
                break;
        
    }
    
    return conf;
    
}




void main(){

    int ch;
    int ch2;
    uint16_t fu_conf = 0x0000;
    uint16_t buffer  = 0x0000;
    uint8_t buffer2  = 0x00;
    uint32_t sw_conf = 0x00000000;
    
    printf("Type of configuration\n");
    printf("Choose \n 1. Tile \t 2. Switch");
    scanf("%d",&ch);
  
    if(ch == 1) {
        printf("Type of Operation\n");
        printf("Choose \n 1. Addition \t 2. Subtraction \t 3. Multiplication\n");
        scanf("%d",&ch);
    
        switch (ch){
        
            case 1: fu_conf = fu_conf | 0x0000;
                break;
               
            case 2: fu_conf = fu_conf | 0x4000;
                break;
            
            case 3: fu_conf = fu_conf | 0x8000;
                break;
        
        }
        
        printf("1st Input\n");
        printf("Choose \n 1. SW \t 2. NW \t 3. NE \t 4. SE \t 5. Empty \n");
        scanf("%d",&ch);
        
        printf("2nd Input\n");
        printf("Choose \n 1. SW \t 2. NW \t 3. NE \t 4. SE \t 5. Empty \n");
        scanf("%d",&ch2);
        
        switch(ch){
            
            case 1: fu_conf = fu_conf | 0x0000;
                    break;
            
            case 2: fu_conf = fu_conf | 0x0022;
                    break;
            
            case 3: fu_conf = fu_conf | 0x0044;
                    break;
                    
            case 4: fu_conf = fu_conf | 0x00cc;
                    break;
                    
            case 5: fu_conf = fu_conf | 0x0000;
                    break;
            
        }
        
        switch(ch2){
            
            case 1: fu_conf = fu_conf | 0x0000;
                    break;
            
            case 2: fu_conf = fu_conf | 0x0008;
                    break;
            
            case 3: fu_conf = fu_conf | 0x0010;
                    break;
                    
            case 4: fu_conf = fu_conf | 0x0018;
                    break;
            
            case 5: fu_conf = fu_conf | 0x0000;
                    break;
            
        }     
        
    } else {
      fu_conf = 0x0000;
    }

    printf("West output source \n");
    printf("1.Emptry  2.North-West  3.East  4.North  5.South  6.West");
    scanf("%d",&ch);
    
    buffer2 = get_conf(ch);
    sw_conf = sw_conf | (buffer2<<28);
    
    printf("South-West output source \n");
    printf("1.Emptry  2.North-West  3.East  4.North  5.South  6.West");
    scanf("%d",&ch);
    
    buffer2 = get_conf(ch);
    sw_conf = sw_conf | (buffer2<<24);
    
    printf("South output source \n");
    printf("1.Emptry  2.North-West  3.East  4.North  5.South  6.West");
    scanf("%d",&ch);
    
    buffer2 = get_conf(ch);
    sw_conf = sw_conf | (buffer2<<20);
    
    printf("South-East output source \n");
    printf("1.Emptry  2.North-West  3.East  4.North  5.South  6.West");
    scanf("%d",&ch);
    
    buffer2 = get_conf(ch);
    sw_conf = sw_conf | (buffer2<<16);
    
    printf("East output source \n");
    printf("1.Emptry  2.North-West  3.East  4.North  5.South  6.West");
    scanf("%d",&ch);
    
    buffer2 = get_conf(ch);
    sw_conf = sw_conf | (buffer2<<12);
    
    printf("North-East output source \n");
    printf("1.Emptry  2.North-West  3.East  4.North  5.South  6.West");
    scanf("%d",&ch);
    
    buffer2 = get_conf(ch);
    sw_conf = sw_conf | (buffer2<<8);
    
    printf("North output source \n");
    printf("1.Emptry  2.North-West  3.East  4.North  5.South  6.West");
    scanf("%d",&ch);
    
    buffer2 = get_conf(ch);
    sw_conf = sw_conf | (buffer2<<4);
    
    printf("North-West output source \n");
    printf("1.Emptry  2.North-West  3.East  4.North  5.South  6.West");
    scanf("%d",&ch);
    
    buffer2 = get_conf(ch);
    sw_conf = sw_conf | buffer2;
    
    
    //printf("fu_conf = 0x%04X\n",fu_conf);
    //printf("sw_conf = 0x%8X\n",sw_conf);
    
    
    printf("\n\nFinal configuration = 0x%04X%08X\n",fu_conf,sw_conf);

}
