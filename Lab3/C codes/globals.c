#include "globals.h"

/* global variables */
volatile int buf_index_record, buf_index_play;		// audio variables
volatile int echo_en;
volatile short make_echo_flag;

volatile unsigned char byte1, byte2, byte3;			// PS/2 variables

volatile char* command; //Record or Play or Echo command will be stored in this variable

volatile int timeout;										// used to synchronize with the timer

volatile float calculation_time;

volatile unsigned char bottons_stat;//status of the mouse bottons
int mouse_x;//horizontal location of the mouse in the screen
int mouse_y;//vertical location of the mouse in the screen
int screen_max_x=319;
int screen_max_y=239;

double coeffs[64];

unsigned int l_buf[BUF_SIZE];					// audio buffer
unsigned int r_buf[BUF_SIZE];					// audio buffer

unsigned int l_buf_echo[BUF_SIZE];
unsigned int r_buf_echo[BUF_SIZE];

volatile short make_echo_flag;

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

const int B[64] = {
          -131,        -331,        -546,        -691,        -609,        -305,
           139,         473,         512,         181,        -318,        -669,
          -578,         -45,         629,         959,         638,        -237,
         -1117,       -1347,        -594,         800,        1943,        1882,
           308,       -2064,       -3678,       -2925,         902,        7010,
         13295,       17269,       17269,       13295,        7010,         902,
         -2925,       -3678,       -2064,         308,        1882,        1943,
           800,        -594,       -1347,       -1117,        -237,         638,
           959,         629,         -45,        -578,        -669,        -318,
           181,         512,         473,         139,        -305,        -609,
          -691,        -546,        -331,        -131
};
