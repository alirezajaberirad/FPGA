module uart(
       input CLOCK_50,
       input[0:0] KEY,
       input UART_RXD,
       output UART_TXD,
       output[0:0] LEDR
    );
    
    wire RxD_data_ready, ldR, ldT, morl, shf8, input_valid, output_valid,TxD_start;
    wire clk;
    
    dp DP (
         clk,
         KEY,
         UART_RXD,
         ldR,
         ldT,
         morl,
         shf8,
         input_valid,
         output_valid,
         TxD_start,
        
         LEDR,
         UART_TXD,
         RxD_data_ready
    );
    
    cu CU (
         clk,
         KEY,
         RxD_data_ready,
         output_valid,
         LEDR,
         ldR,
         ldT,
         morl,
         shf8,
         input_valid,
         TxD_start

    );
    
	 pll pl(
	.areset(KEY),
	.inclk0(CLOCK_50),
	.c0(clk));
        
endmodule