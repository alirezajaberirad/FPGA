#ifndef __AMPLITUDE_CIRCUTE_H__
#define __AMPLITUDE_CIRCUTE_H__
#include "stdio.h"
#include "stdlib.h"
#include "system.h"
#include "sys/alt_stdio.h"
#include "sys/alt_irq.h"
#include "io.h"
extern void amplitude_circute_set_size(unsigned int);
extern void amplitude_circute_set_num(unsigned int);
extern void amplitude_circute_set_rbuff_addr(volatile unsigned int*);
extern void amplitude_circute_set_lbuff_addr(volatile unsigned int*);
extern void amplitude_circute_set_dest_addr(volatile unsigned long long int*);
extern void amplitude_circute_start();
extern void amplitude_operation(unsigned int, unsigned int, volatile unsigned int*, volatile unsigned int*, volatile unsigned long long int*);
#endif
