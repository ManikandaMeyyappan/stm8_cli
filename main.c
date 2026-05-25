#define PD_ODR (*(volatile unsigned char*)0x500F)
#define PD_DDR (*(volatile unsigned char*)0x5011)
#define PD_CR1 (*(volatile unsigned char*)0x5012)
void delay(void){
volatile unsigned long i;
for(i=0;i<20000UL;i++);
}

int main(void){ 
PD_DDR |= (1<<0); 
PD_CR1 |= (1<<0); 
while(1){
PD_ODR &= ~(1<<0);
delay();
PD_ODR |= (1<<0);
delay();
}
}
