#include "globals.h"

/* global variables */
volatile int buf_index_record, buf_index_play;		// audio variables
volatile int echo_en;

volatile unsigned char byte1, byte2, byte3;			// PS/2 variables

volatile char* command; //Record or Play or Echo command will be stored in this variable

volatile int timeout;										// used to synchronize with the timer

volatile unsigned char bottons_stat;//status of the mouse bottons
int mouse_x;//horizontal location of the mouse in the screen
int mouse_y;//vertical location of the mouse in the screen
int screen_max_x=319;
int screen_max_y=239;

short cursor_shape[16][8] = {
  { 0, -1, -1, -1, -1, -1, -1, -1},
  { 0,  0, -1, -1, -1, -1, -1, -1},
  { 0,  1,  0, -1, -1, -1, -1, -1},
  { 0,  1,  1,  0, -1, -1, -1, -1},
  { 0,  1,  1,  1,  0, -1, -1, -1},
  { 0,  1,  1,  1,  1,  0, -1, -1},
  { 0,  1,  1,  1,  1,  1,  0, -1},
  { 0,  1,  1,  1,  1,  0,  0,  0},
  { 0,  1,  1,  1,  0, -1, -1, -1},
  { 0,  0,  0,  1,  0, -1, -1, -1},
  { 0, -1,  0,  1,  0, -1, -1, -1},
  {-1, -1, -1,  0,  1,  0, -1, -1},
  {-1, -1, -1,  0,  1,  0, -1, -1},
  {-1, -1, -1, -1,  0,  1,  0, -1},
  {-1, -1, -1, -1,  0,  1,  0, -1},
  {-1, -1, -1, -1, -1,  0, -1, -1}
};


struct alt_up_dev up_dev;									/* struct to hold pointers to open devices */
