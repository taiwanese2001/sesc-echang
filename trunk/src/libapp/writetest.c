#define USE_SESC

#ifdef USE_SESC
   #include "sescapi.h"
#else
   #define MAX_NUM_THREADS 32
   #include <pthread.h>
#endif

#include <stdio.h>
#include <stdlib.h>

//#define SIM_CHECKPOINT 2
//#define SIM_START_RABBIT 0
//#define SIM_STOP_RABBIT 1

//#define TM_SIMOP(x) asm __volatile__ ("andi $0, $0, %0\n\t"::"i"(x): "memory")

/*
 * Calling TM_SIMOP(SIM_CHECKPOINT) will take a chekcpoint.
 * Calling TM_SIMOP(SIM_STOP_RABBIT) will end rabbit mode.
 * Calling TM_SIMOP(SIM_START_RABBIT) will start rabbit mode.
 * */

volatile int myInt = 1;

void *writeInt(void *numberOfLoops)
{
   int i=0;
   
   for (i=0; i<*((int*)numberOfLoops); i++)
   {
      myInt = myInt + 1;
   }
#ifdef USE_SESC
   sesc_exit(0);
#else
    pthread_exit(NULL);
#endif
}

int main(int argc, char** argv)
{
#ifdef USE_SESC
	sesc_init();
#else
   pthread_t threads[MAX_NUM_THREADS];
#endif
   char *tempString = NULL;
   int t = 0;
   int threadIndexMax = 0;
   int numberOfLoops = 0;
   int processorCount = 0;

   // process arguments
   for (t=0; t<argc; t++)
   {
      tempString = argv[t];
      if (tempString[0]=='-')
      {
         if (tempString[1]=='p')
         {
            processorCount = atoi(tempString+2);
         }
         else if (tempString[1]=='n')
         {
            numberOfLoops = atoi(tempString+2);
         }
      }
   }

   if (!processorCount || !numberOfLoops)
   {
      printf("Usage: writetest -p[number of processors] -n[number of loops]\n");
#ifdef USE_SESC
      sesc_exit(1);
#else
      pthread_exit(NULL);
#endif
   }

   for(t=0;t<processorCount-1;t++)
   {
       printf("Creating thread %d\n", t);
#ifdef USE_SESC
	    sesc_spawn((void (*)(void*)) *writeInt, &numberOfLoops, 0);
#else
       pthread_create(&threads[t], NULL, writeInt, &numberOfLoops);
#endif
    }

#ifdef USE_SESC
   sesc_wait(); // wait for thread to finish
   sesc_exit(0);
#else
   for (t=0; t<processorCount-1; t++)
   {
      pthread_join(threads[t], NULL);
      pthread_exit(NULL);
   }
#endif
}

