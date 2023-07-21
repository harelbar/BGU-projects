#include <stdio.h>
#include <pthread.h>	
#include <sys/types.h>	
#include <sys/ipc.h>	
#include <sys/msg.h>	
#include <string.h>
#include <unistd.h>	
#include <stdlib.h>
#include <errno.h>	
#include <time.h>
#include <sys/wait.h>	
#include <signal.h>	
#include "header.h"
//===============================================================================================================//
int main() {
	time_t t;
	setbuf(stdout, NULL);
	signal(SIGINT, simulation_termination);
	srand((unsigned) time(&t));
	qid[ACK_INDEX] = my_msgget(keys[ACK_INDEX]);
	qid[HD_QID] = my_msgget(keys[HD_QID]);
	memset(memory, INVALID, N);
	if(pthread_mutexattr_init(&attr)) {
		printf("Failed to initialize an attribute with error: %s\n", strerror(errno));
		simulation_termination(EXIT_FAILURE);
	}
	if(pthread_mutexattr_settype(&attr, PTHREAD_MUTEX_ERRORCHECK)) {
		printf("Failed to set attribute ERRORCHECK with error: %s\n", strerror(errno));
		simulation_termination(EXIT_FAILURE);
	}
	
	if(pthread_mutex_init(&simulation_mutex, &attr)) {
		printf("Failed to initialize the simulation mutex with error: %s\n", strerror(errno));
		simulation_termination(EXIT_FAILURE);
	}

	pid[p++] = getpid();				//here i used fork to create new processes and call the function
	if((pid[p++] = my_fork()) == 0) {		//that simulates them. when the simulation is terminated,
		process(1);				//upon function return, the processes shu
		_exit(EXIT_SUCCESS);
	}
	
	if((pid[p++] = my_fork()) == 0) {
		process(2);
		_exit(EXIT_SUCCESS);
	}
	
	if((pid[p++] = my_fork()) == 0) {
		MMU();
		_exit(EXIT_SUCCESS);
	}
	
	if((pid[p++] = my_fork()) == 0) {
		HD();
		_exit(EXIT_SUCCESS);
	}
	
	my_sleep(SIM_TIME, 0);
	
	simulation_termination(EXIT_SUCCESS);
}
//===============================================================================================================//
int Set_Mutex(int mutex_type, pthread_mutex_t* mutex) {
	int err;
	if(mutex_type==LOCK){
		err=pthread_mutex_lock(mutex);
		if(err==0){
			return 1;
		}
	}else if(mutex_type==UNLOCK){
		if(pthread_mutex_unlock(mutex)==0){
			return 1;
		}
	}
	simulation = 0;							//an error accured, finish simulation
	my_sleep(0,50000);						//wait for processes to exit their tasks
	if(err==EINVAL)
		printf("probleem with mutex %p\n its EINVALs", mutex );
	if(err==EDEADLK)
		printf("probleem with mutex %p\n its EDEADLK", mutex );
	if(err==EBUSY)
		printf("probleem with mutex %p\n its EBUSY", mutex );
	if(err==EDEADLK)
		printf("probleem with mutex %p\n its EDEADLK", mutex );

	printf("set mutex error failed with error: %s\n", strerror(errno));
	kill(pid[0], SIGINT);
	return 1;
//===============================================================================================================//
}
void process(int pindx) {
	int operation;
	long mmu_qid;
	float probobility;
	my_msg write_message, read_message, recive_message;
	
	sprintf(write_message.text, W);
	sprintf(read_message.text, R);
	sprintf(recive_message.text, " ");
	write_message.type = RWtype(pindx);
	read_message.type = RWtype(pindx);
	recive_message.type = Atype(pindx);
	mmu_qid=qid[ACK_INDEX];
	while(simulation) {
		probobility=rand()%1001;
		probobility=probobility/1000;	
		operation=probobility>WR_RATE?0:1;				//calculate write probability
		my_sleep(0, INTER_MEM_ACCS_T);
		if(operation==0) my_msgsnd(mmu_qid, &write_message);		// write
		else my_msgsnd(mmu_qid, &read_message);				//read
		my_msgrcv(mmu_qid, &recive_message, IPC_WAIT);			// wait for ACK
	}
}
//===============================================================================================================//
void MMU() {
	pthread_t pthread[2];
	int error = 0,i = 0,hm,MMU_qid = qid[ACK_INDEX];	
	int k, rand_indx, counter_used, pages = 0,used_arr[N],used_index,first_time=1,empty=1, p = 0;
	int unused_index=0,dif,tm;
	char txt,memory_copy[N];	
	float hit_probobility;
	int HD_qid,unuesd_index,uesd_index,used_pointer=0;
	HD_qid = qid[HD_QID];
	EvData evicter_args;
	evicter_args.used_pages=&pages;
	evicter_args.arr=used_arr;
	my_msg ACK_message[2],recive_message[2],send, HD_ACK;
	recive_message[0].type = P1_MMU_TYP;
	recive_message[1].type = P2_MMU_TYP;
	sprintf(recive_message[0].text, " ");
	sprintf(recive_message[1].text, " ");
	ACK_message[0].type = P1_ACK_TYP;
	ACK_message[1].type = P2_ACK_TYP;
	sprintf(ACK_message[0].text,A);
	sprintf(ACK_message[1].text,A);	
	HD_ACK.type = HD_ACK_TYPE;
	sprintf(HD_ACK.text, " ");
	send.type = HD_SEND_TYPE;
	sprintf(send.text,R);
	
	my_pthread_create(&pthread[0], Printer, NULL);
	my_pthread_create(&pthread[1], Evicter, (void*)&evicter_args);
	while(simulation) {
	
		if(empty==1){
			hm=0;
		}else{
			hit_probobility=rand()%1001;
			hit_probobility=hit_probobility/1000;	
			hm=hit_probobility<HIT_RATE?0:1;
		}
		
		i ^= 1;							//xor to switch between processes
		error = my_msgrcv(MMU_qid, &recive_message[i], IPC_NOWAIT);
		if(error != 0) {
			if (error == ENOMSG){ continue;}		//no messages waiting
			else {break;}			
		}		
		txt = recive_message[i].text[0];	
		if (hm==0) {						//  memory  empty or miss
			if (pages == N) {		
				Set_Mutex(LOCK, &s_mutex);		
				pthread_cond_signal(&cond);
				pthread_cond_wait(&cond, &s_mutex);
				Set_Mutex(UNLOCK, &s_mutex);
				if(!simulation) continue;
			}						//if recived from evicter or memory wasnt full, write
			empty=0;	
			my_msgsnd(HD_qid, &send);			//wait for HD ACK		
			my_msgrcv(HD_qid, &HD_ACK, IPC_WAIT);
			if(!simulation) continue;
			Set_Mutex(LOCK,&MemoryMutex);
			memcpy(memory_copy,memory,N);			//copy the memory to pick an invalid cell
			Set_Mutex(UNLOCK,&MemoryMutex);	
			unuesd_index=random_pick(memory_copy);		//randomally pick an invalid cell
			Set_Mutex(LOCK, &MemoryMutex);			
			memory[unuesd_index] = CLEAN;			//mark as clean	
			Set_Mutex(UNLOCK, &MemoryMutex);			
			Set_Mutex(LOCK, &used_pages_mutex);			
			pages++;					//we have another page in memory
			Set_Mutex(UNLOCK, &used_pages_mutex);
			Set_Mutex(LOCK,&arr_mutex);			//creating an array in which by order, from laft to right
			used_arr[used_pointer]=unuesd_index;		//the cells holds the values of the memory cell 
			Set_Mutex(UNLOCK,&arr_mutex);			//fetchd from the memory by order. the pointer is 
									//cyclicly incremated and he cant point to a cell
			used_pointer=used_pointer+1;			//already holds a value, because
			used_pointer=used_pointer%N;	
		}else{ //its a hit
			if (txt==W[0]) {
				my_sleep(0,MEM_WR_T);
				Set_Mutex(LOCK, &used_pages_mutex);			
				tm=pages;					
				Set_Mutex(UNLOCK, &used_pages_mutex);
				dif=used_pointer-tm;			//the index of the first used cell
				if (dif<0)				//if negative add N so we stay in the array bounderies
					dif+=N;
				rand_indx=(dif+rand()%tm)%N;		//pick randomally among the used indexes
				Set_Mutex(LOCK,&arr_mutex);			
				k=used_arr[rand_indx];			//chossing the index 
				Set_Mutex(UNLOCK,&arr_mutex);
				Set_Mutex(LOCK,&MemoryMutex);			
				memory[k]=DIRTY;	
				Set_Mutex(UNLOCK,&MemoryMutex);			
			}						//after write or if read return ACK
		}
		my_msgsnd(MMU_qid,&ACK_message[i]);
	}
	pthread_join(pthread[0],NULL);
	pthread_join(pthread[1],NULL);
}
//===============================================================================================================//
int random_pick(char* memory_copy){					//randomally pick one of the invalid cells
	int i=rand()%N;
	char pick;
	while(1){
		pick=memory_copy[i];
		if(pick==INVALID)
			return i;
		i++;
		i=i%N;
	}
}
//===============================================================================================================//
void* Evicter(void* evicter_args) {
	my_msg recive_message, ACK_message;
	EvData *args = evicter_args;
	int remove_index=0,k;
	int *used_pages_number = args->used_pages;
	int *used_array= args->arr;
	char page, full = 0,total_used;
	ACK_message.type = HD_ACK_TYPE;
	sprintf(ACK_message.text," ");
	recive_message.type = HD_SEND_TYPE;
	sprintf(recive_message.text,W);	
		
	while(simulation) {		
		Set_Mutex(LOCK, &s_mutex);		
		pthread_cond_wait(&cond, &s_mutex);	
		Set_Mutex(UNLOCK, &s_mutex);		
		Set_Mutex(LOCK, &pages_mutex);				//wait for the MMU to wake me up		
		total_used=*used_pages_number;					
		Set_Mutex(UNLOCK, &pages_mutex);
		if(!simulation) continue;
		while(total_used >= USED_SLOTS_TH && simulation) {	//untill we reach the threshold
			if(total_used == N)				//if memory is full
				full=1;		
			Set_Mutex(LOCK,&arr_mutex);			
			k=used_array[remove_index];			//FIFO
			Set_Mutex(UNLOCK,&arr_mutex);
			Set_Mutex(LOCK, &MemoryMutex);
			page = memory[k];				//load a page from memory
			Set_Mutex(UNLOCK,&MemoryMutex);
			if(page == DIRTY) {				//if dirty, "write"to HD
				my_msgsnd(qid[HD_QID], &recive_message);			
				my_msgrcv(qid[HD_QID], &ACK_message, IPC_WAIT);	
				if(!simulation) continue;
			}	
			Set_Mutex(LOCK, &MemoryMutex);
			memory[k]=INVALID;			//set the removed one as INVALID
			Set_Mutex(UNLOCK,&MemoryMutex);
			total_used--;	
			Set_Mutex(LOCK, &pages_mutex);			
			*used_pages_number=*used_pages_number-1;	//decrease the amount of used pages in memory				
			Set_Mutex(UNLOCK, &pages_mutex);
			remove_index=remove_index+1;			//to evict from memory in FIFO, we use a cyclic counter
			remove_index=remove_index%N;
			if(total_used<=N && full) {	
				Set_Mutex(LOCK, &s_mutex);	
				pthread_cond_signal(&cond);		//if full, MMU waits for signal	
				Set_Mutex(UNLOCK, &s_mutex);
				full=0;
			}
			Set_Mutex(LOCK,&used_pages_mutex);
			total_used=*used_pages_number;			//check the up-to-date number of pages to clean	
			Set_Mutex(UNLOCK,&used_pages_mutex);	
		}
	}
	return NULL;
}
//===============================================================================================================//
void HD() {
	int error = 0,HD_qid = qid[HD_QID];
	my_msg ACK_message,recive_message;
	ACK_message.type = HD_ACK_TYPE;
	sprintf(ACK_message.text,A);
	recive_message.type = HD_SEND_TYPE;
	sprintf(recive_message.text," ");
	while(simulation) {
		error = my_msgrcv(HD_qid, &recive_message, IPC_NOWAIT);	
		if(error != 0) {
			if (error == ENOMSG) continue;			//no requests
			else break;
		}
		my_sleep(0, HD_ACCS_T);				
		my_msgsnd(HD_qid, &ACK_message);	
	}
}
//===============================================================================================================//
void* Printer() {
	int i;
	char memory_copy[N];
	while(simulation) {
		Set_Mutex(LOCK,&MemoryMutex);
		memcpy(memory_copy,memory,N);				//copy the memory ti minimize the CS
		Set_Mutex(UNLOCK,&MemoryMutex);	
		printf("\n");	
		for (i = 0; i < N; i++)
			printf("%d|%c\n", i, memory_copy[i]);
		printf("\n");
		my_sleep(0,TIME_BETWEEN_SNAPSHOTS);
	}
	return NULL;
	}
//===============================================================================================================//
void simulation_termination(int exit_err) {
	int i, status,err;

	simulation=0;							//let all the current still runung tasts knos 
	my_sleep(0, 5000);						//the simulation is terminating so they won't 
									//acuire any mutexex
	if(pid[0] == getpid()) {					
		for(i = 1; i < p; i++){ kill(pid[i], SIGINT);	}	
		my_sleep(0, 500000);
		for(i = 0; i < NUMBER_OF_QUEUES; i++) {
			if(msgctl(qid[i],IPC_RMID,0))
				printf("\nerror while closing message queue number %d\n",qid[i]);	
		}
	}
	if(pthread_mutex_destroy(&simulation_mutex)!=0){
		printf("simulation_mutex destroy failed with error: %s\n", strerror(errno));	
		exit(EXIT_FAILURE);
	}
	if(pthread_mutex_destroy(&MemoryMutex)!=0)	{
		printf("MemoryMutex destroy failed with error: %s\n", strerror(errno));
		exit(EXIT_FAILURE);
	}
	if(pthread_mutexattr_destroy(&attr)!=0){
		printf("attr destroy failed with error: %s\n", strerror(errno));
		exit(EXIT_FAILURE);
	}
	if(pthread_mutex_destroy(&arr_mutex)!=0)	{
		printf("arr_mutex destroy failed with error: %s\n", strerror(errno));
		exit(EXIT_FAILURE);
	}
	if(pthread_mutex_destroy(&used_pages_mutex)!=0)	{
		printf("used_pages_mutex destroy failed with error: %s\n", strerror(errno));
		exit(EXIT_FAILURE);
	}
	if(pthread_mutex_destroy(&pages_mutex)!=0)	{
		printf("pages_mutex destroy failed with error: %s\n", strerror(errno));
		exit(EXIT_FAILURE);
	}
	pthread_mutex_destroy(&s_mutex);					//only the main process can terminate
	if(pid[0] != getpid())			
		_exit(EXIT_SUCCESS);
	else{
		for(i = 1; i < p; i++)			
			waitpid(pid[i], &status, 0);
	}
	exit_err = exit_err ? EXIT_FAILURE : EXIT_SUCCESS;
	if(!exit_err)
		printf("Successfully finished sim\n\n");
		
	exit(exit_err);					
}

//===============================================================================================================//
void my_msgsnd(int queue_id, my_msg *msg) {
	if (msgsnd(queue_id, (void *)msg, MSG_SIZE, 0) == -1) {
		printf("sending a message failed with error: %s\n", strerror(errno));	
		kill(pid[0], SIGINT);
	}
}
//===============================================================================================================//
int my_msgrcv(int queue_id, my_msg *msg, const int msgflg) {
	int error = 0;
	if (msgrcv(queue_id, msg, MSG_SIZE, msg->type, msgflg) == -1&& (error = errno) != ENOMSG && errno != EINTR) {		
		printf("error on my_msgrcv() with error: %s\n", strerror(errno));
		kill(pid[0], SIGINT);
	}
	return error;
}

//===============================================================================================================//
int my_msgget(key_t key) {
	int queue_id = msgget(key, 0666 | IPC_CREAT);
	if (queue_id == -1) {	
		printf("creating a queue failed with error: %s\n", strerror(errno));
		simulation_termination(EXIT_FAILURE);
	}
	return queue_id;
}
//===============================================================================================================//
pid_t my_fork() {
	pid_t pid = fork();
	if (pid >= 0) 
		return pid;
	simulation_termination(EXIT_FAILURE);
	return -1;
}
//===============================================================================================================//
void my_pthread_create(pthread_t *pthread, void *(*routine)(void *), void *arg) {
	if (pthread_create(pthread, NULL, routine, arg)) {
		printf("my_pthread_create failed with error: %s\n", strerror(errno));
		kill(pid[0], SIGINT);
	}
}
//===============================================================================================================//
void my_sleep(int sec, int nsec) {
	struct timespec remaining, request = {sec, nsec};
	if (nanosleep(&request, &remaining) && errno != EINTR) {
		printf("nnanosleep failed with error: %s\n", strerror(errno));
		kill(pid[0], SIGINT);
	}
}
//===============================================================================================================//







