#ifndef mainheader
#define HIT_RATE			0.5
#define WR_RATE				0.5
#define N				5	
#define USED_SLOTS_TH			3
#define SIM_TIME			1
#define TIME_BETWEEN_SNAPSHOTS		100000000
#define MEM_WR_T			1000
#define HD_ACCS_T			100000
#define INTER_MEM_ACCS_T		10000

#define LOCK				0
#define UNLOCK				1
#define MSG_SIZE			10
#define NUMBER_OF_QUEUES		2
#define R				"R"		
#define W				"W"		
#define A				"A"		
#define HD_SEND_TYPE			1		
#define HD_ACK_TYPE			2		
#define P1_MMU_TYP			1
#define P2_MMU_TYP			2
#define P1_ACK_TYP			3
#define P2_ACK_TYP			4
#define RWtype(in)			(in==1 ? P1_MMU_TYP : P2_MMU_TYP)				
#define Atype(in)			(in==1 ? P1_ACK_TYP : P2_ACK_TYP)
#define ACK_INDEX			0		
#define HD_QID				1		
#define NUMBER_OF_PROCSESSES		5		
#define IPC_WAIT			0		
#define INVALID				'-'		
#define CLEAN				'0'		
#define DIRTY				'1'		
typedef struct my_msg {
	long type;
	char text[MSG_SIZE];
} my_msg;
typedef struct EvData {
	int* used_pages;
	int* arr;
} EvData;

pid_t my_fork(void);
void simulation_termination(int exit_err);
void HD();
void* Printer();
void* Evicter(void* evicter_args);
void my_sleep(int sec, int nsec);
void my_pthread_create(pthread_t *pthread, void *(*routine)(void *), void *arg);
void process(int proc_num);
int my_msgget(const key_t key);
void my_msgsnd(const int queue_id, struct my_msg *msg);
int my_msgrcv(const int queue_id, struct my_msg *msg, const int msgflg);
void MMU();
int set_mutex(int mutex_type, pthread_mutex_t* mutex);

int random_pick(char* memory_copy);

pthread_mutexattr_t attr;		
pthread_mutex_t simulation_mutex;
pthread_mutex_t s_mutex= PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t pages_mutex= PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t MemoryMutex= PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t used_pages_mutex= PTHREAD_MUTEX_INITIALIZER;
pthread_mutex_t arr_mutex= PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;	// declaration of thread condition variable
pid_t pid[NUMBER_OF_PROCSESSES];
int simulation = 1;			
int qid[NUMBER_OF_QUEUES];	
int p = 0;
char memory[N];					// invalid='-',clean= 0, dirty=1

key_t keys[NUMBER_OF_QUEUES] = {111, 222};

#endif



