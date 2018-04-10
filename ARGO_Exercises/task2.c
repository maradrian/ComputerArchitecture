

const int NOC_MASTER = 0;
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <machine/patmos.h>
#include "libcorethread/corethread.h"
#include "libmp/mp.h"

//blink function, period=0 -> ~10Hz, period=255 -> ~1Hz
void blink(int period) {//int
	// The hardware address of the LED
	#define LED ( *( ( volatile _IODEV unsigned * ) 0xF0090000 ) )
	for (;;)
	{
		for (int i=400000+14117*period; i!=0; --i){LED = 1;}
		for (int i=400000+14117*period; i!=0; --i){LED = 0;}
	}
	return;
}

int main() {
   	int worker_id = 1;
	int parameter = 255; 

	for (int i=1; i<9; i++){
		int rand = rand_r((void*)parameter);
		corethread_create(i, &blink, (rand>>22));
	}
	
	int * res;
	corethread_join(worker_id,&res);
	return *res;
}

