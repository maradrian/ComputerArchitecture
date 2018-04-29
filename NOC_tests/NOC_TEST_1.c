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
	#define LED ( *( ( volatile _SPM unsigned * ) 0xF0090000 ) )
	volatile _SPM int *addr_data_out  = (volatile _SPM int *)  0xe8000010;
	volatile _SPM int *addr_data_out1  = (volatile _SPM int *) 0xe8010020;
	volatile _SPM int *addr_data_out2  = (volatile _SPM int *) 0xe8020030;
	volatile _SPM int *addr_data_out3  = (volatile _SPM int *) 0xe8030040;
	
	int cpuid = get_cpuid();

	if(cpuid == 1){
	  int i = 1;
	  while (i < 100002){		
	    while(*addr_data_out1 < i)
	      ;
	    *addr_data_out2 = i + 1;
	    i = i + 4;	
	  }
	}
	
	if(cpuid == 2){
	   int i = 2;
	   while(i < 100003){
	     while(*addr_data_out2 < i)
	       ;
	     
	     *addr_data_out3 = i + 1;
	     i = i + 4;
	   }
	}	
	
	if(cpuid == 3){
	   int i = 3;
	   while(i < 100004){
	      while(*addr_data_out3 < i)
		;
	      *addr_data_out = i + 1;
	      i = i + 4;
	   }
	}
	
	return;
}

int main() {
   	int worker_id = 1;
	int parameter = 255; 
	printf("Hello world %d %d\n", get_cpucnt(), get_cpuid());
	volatile _SPM int *addr_data  = (volatile _SPM int *) 0xe8000010;
	volatile _SPM int *addr_data1  = (volatile _SPM int *) 0xe8010020;
	volatile _SPM int *addr_data2  = (volatile _SPM int *) 0xe8020030;	
	volatile _SPM int *addr_data3  = (volatile _SPM int *) 0xe8030040;
	printf("%d\n", *addr_data);
	
	#define LED ( *( ( volatile _SPM unsigned * ) 0xF0090000 ) )
	for (int i=400000+14117*255; i!=0; --i){LED = 1;}
	for (int i=400000+14117*255; i!=0; --i){LED = 0;}
	for (int i=1; i<=3; i++){
		corethread_create(i, &blink, parameter);
	}
	
	int i = 0;
	while(i < 100004){	
	  *addr_data1 = i + 1;
	  i = i + 4;
	  while(*addr_data < i)
	    ;
	  printf("%d\n", *addr_data);
	  	
	}	
	
	printf("The end\n");
	int * res;
	corethread_join(worker_id,&res);
	
	
	
	//printf("%d\n %d\n %d\n %d\n", *addr_data, *addr_data1, *addr_data2, *addr_data3);
	

	return *res;
}




