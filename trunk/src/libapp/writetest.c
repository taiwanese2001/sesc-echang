#ifdef USE_SESC
   #include "sescapi.h"
#else
   #define MAX_NUM_THREADS 32
   #include <pthread.h>
#endif

#define THREADS 2

#include <stdio.h>
#include <stdlib.h>

/*
#define SIM_CHECKPOINT 2
#define SIM_START_RABBIT 0
#define SIM_STOP_RABBIT 1

#define TM_SIMOP(x) asm __volatile__ ("andi $0, $0, %0\n\t"::"i"(x): "memory")
*/

/*
 * Calling TM_SIMOP(SIM_CHECKPOINT) will take a chekcpoint.
 * Calling TM_SIMOP(SIM_STOP_RABBIT) will end rabbit mode.
 * Calling TM_SIMOP(SIM_START_RABBIT) will start rabbit mode.
 * */

volatile int myInt = 1;
#ifdef USE_SESC
sbarrier_t barr;
#endif

void *readInt(void *numberOfLoops)
{
   int i=0;
   int localInt = 0;
	//printf("readIntThreadid=%d\n", *((int*)threadid));
   
   for (i=0; i<*((int*)numberOfLoops); i++)
   {
      localInt = myInt;
#ifdef USE_SESC
      sesc_barrier(&barr, THREADS);
#endif
   }
#ifdef USE_SESC
   sesc_exit(0);
#else
   pthread_exit(NULL);
#endif
}

void *incInt(void *numberOfLoops)
{
   int i=0;
   for (i=0; i<*((int*)numberOfLoops); i++)
   {
      myInt = myInt + 1;
#ifdef USE_SESC
      sesc_barrier(&barr, THREADS);
#endif
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
   sesc_barrier_init(&barr);
#else
   pthread_t threads[MAX_NUM_THREADS];
#endif
   char *tempString = NULL;
   int t = 0;
   int threadIndexMax = 0;
   int numberOfLoops = 0;
   int numberOfReads = 0;
   int processorCount = 0;
   int localInt = 0;

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
            numberOfReads = atoi(tempString+2);
         }
      }
   }

   if (!processorCount || !numberOfReads)
   {
      printf("Usage: readtest -p[number of processors] -n[number of reads]\n");
#ifdef USE_SESC
      sesc_exit(1);
#else
      pthread_exit(NULL);
#endif
   }

   threadIndexMax = processorCount - 2;
   threadIndexMax = threadIndexMax / 2;

   // calculate the number of Loops
   //numberOfLoops = numberOfReads / (processorCount-2);
   processorCount = 2;
   numberOfLoops = numberOfReads / processorCount;
   printf("numberOfLoops=%d\n", numberOfLoops);

   // spawn on processor 1
   sesc_spawn((void (*)(void*)) *incInt, &numberOfLoops, SESC_FLAG_NOMIGRATE|SESC_FLAG_MAP|1);
   // spawn on processor 2
   sesc_spawn((void (*)(void*)) *readInt, &numberOfLoops, SESC_FLAG_NOMIGRATE|SESC_FLAG_MAP|2);

#ifdef USE_SESC
   sesc_wait(); // wait for threads to finish
	sesc_exit(0);
#else
   for (t=0; t<processorCount-2; t++)
   {
      pthread_join(threads[t], NULL);
      pthread_exit(NULL);
   }
#endif
}

