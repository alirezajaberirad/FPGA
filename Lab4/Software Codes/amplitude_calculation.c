#include "amplitude_circute.h"
volatile unsigned int* acc_base_addr = (unsigned int*)ACCELERATOR_0_BASE;
void amplitude_operation(unsigned int size, unsigned int num, volatile unsigned int* rbuff_addr, volatile unsigned int* lbuff_addr, volatile unsigned long long int* dest_addr)
{
	amplitude_circute_set_size(size);
	// also for your debugging make int amplitude_circute_get_size(); (optional)
	amplitude_circute_set_num(num);
	// also for your debugging make int amplitude_circute_get_num(); (optional)
	amplitude_circute_set_rbuff_addr(rbuff_addr);
	// also for your debugging make int amplitude_circute_get_lbuff_addr(); (optional)
	amplitude_circute_set_lbuff_addr(lbuff_addr);
	// also for your debugging make int amplitude_circute_get_rbuff_addr(); (optional)
	amplitude_circute_set_dest_addr(dest_addr);
	// also for your debugging make int amplitude_circute_get_dest_addr(); (optional)
	amplitude_circute_start();

	unsigned int reg0;

	//wait untill done bit sets to zero
	reg0=IORD(acc_base_addr, 0);
	while((reg0 & 0x80000000) == 0x80000000)
		reg0=IORD(acc_base_addr, 0);

	//setting start bit to zero
	reg0=IORD(acc_base_addr, 0);
	reg0=reg0 & 0xfffffffe;
	IOWR(acc_base_addr, 0, reg0);

	//wait untill done bit is issued
	reg0=IORD(acc_base_addr, 0);
	while((reg0 & 0x80000000) != 0x80000000)
		reg0=IORD(acc_base_addr, 0);

	return;
}

void amplitude_circute_set_size(unsigned int size){
	unsigned int reg0=0;
	reg0=reg0 | (size << 12);
	IOWR(acc_base_addr, 0, reg0);//rewrite new reg0:including size
	return;
}

void amplitude_circute_set_num(unsigned int num){
	unsigned int reg0;
	reg0=IORD(acc_base_addr, 0);
	reg0=reg0 & 0xfffff000; //clear num portion and start bit
	reg0=reg0 | (num << 1);
	IOWR(acc_base_addr, 0, reg0);//rewrite new reg0:including num,size
	return;
}

void amplitude_circute_set_rbuff_addr(volatile unsigned int* rbuff_addr){
	unsigned int reg1;
	reg1=(unsigned int) rbuff_addr;
	//reg1 = (unsigned int) &rbuff_addr[0];
	IOWR(acc_base_addr, 1, reg1);
	return;
}

void amplitude_circute_set_lbuff_addr(volatile unsigned int* lbuff_addr){
	unsigned int reg2;
	reg2=(unsigned int) lbuff_addr;
	IOWR(acc_base_addr, 2, reg2);
	return;
}

void amplitude_circute_set_dest_addr(volatile unsigned long long int* dest_addr){
	unsigned int reg3;
	reg3=(unsigned int) dest_addr;
	IOWR(acc_base_addr, 3, reg3);
	return;
}

void amplitude_circute_start(){
	unsigned int reg0;
	reg0=IORD(acc_base_addr, 0);
	reg0=reg0 | 0x00000001;
	IOWR(acc_base_addr, 0, reg0);//rewrite new reg0:including num,size,start
	return;
}
