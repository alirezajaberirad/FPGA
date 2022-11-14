module async_transmitter(
        input clk,
        input TxD_start,
        input [7:0] TxD_data,
        output TxD,
        output TxD_busy
       );

       // Assert TxD_start for (at least) one clock cycle to start transmission of TxD_data
       // TxD_data is latched so that it doesn't have to stay valid while it is being sent
       parameter ClkFrequency = 50000000;
       parameter Baud = 115200;
       parameter Oversampling = 1;

       wire TxDTick;
       BaudTickGen #(ClkFrequency, Baud) tickgen(.clk(clk), .enable(TxD_busy), .tick(TxDTick));

       reg [3:0] TxD_state = 0;
       wire TxD_ready = (TxD_state==0);
       assign TxD_busy = ~TxD_ready;

       reg [7:0] TxD_shift = 0;
       
		 always @(posedge clk)
		 begin
         if(TxD_ready & TxD_start)
             TxD_shift <= TxD_data;
         else
         if((TxD_state>4'b0001) & TxDTick)
             TxD_shift <= (TxD_shift >> 1);

	      case(TxD_state)
             4'b0000: if(TxD_start) TxD_state <= 4'b0001;
             4'b0001: if(TxDTick) TxD_state <= 4'b0010;  // start bit
             4'b0010: if(TxDTick) TxD_state <= 4'b0011;  // bit 0
             4'b0011: if(TxDTick) TxD_state <= 4'b0100;  // bit 1
             4'b0100: if(TxDTick) TxD_state <= 4'b0101;  // bit 2
             4'b0101: if(TxDTick) TxD_state <= 4'b0110;  // bit 3
             4'b0110: if(TxDTick) TxD_state <= 4'b0111;  // bit 4
             4'b0111: if(TxDTick) TxD_state <= 4'b1000;  // bit 5
             4'b1000: if(TxDTick) TxD_state <= 4'b1001;  // bit 6
             4'b1001: if(TxDTick) TxD_state <= 4'b1010;  // bit 7
             4'b1010: if(TxDTick) TxD_state <= 4'b0000;  // stop1
             default: if(TxDTick) TxD_state <= 4'b0000;
         endcase  
       end

       assign TxD = (TxD_state == 4'b0000) | ((TxD_state > 4'b0001) & TxD_shift[0]) | (TxD_state == 4'b1010);
endmodule
