`timescale 1ns/1ns
module test;

  reg CLOCK_50 = 1'b0;
  reg KEY = 1'b0;
  reg UART_RXD = 1;
  wire UART_TXD;
  wire LEDR0;
  
  uart DUT (CLOCK_50, KEY, UART_RXD, UART_TXD, LEDR0);

  initial begin
    #50 KEY = 1'b1;
    #50 KEY = 1'b0;
    
    #2200000;
    $stop;
  end

  always#8600 UART_RXD = ~UART_RXD;

  always begin
    #10 CLOCK_50 = ~CLOCK_50;
  end
  
endmodule