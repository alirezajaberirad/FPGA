module async_receiver(
    input clk,
    input RxD,
    output reg RxD_data_ready = 0,
    output reg [7:0] RxD_data = 0  // data received, valid only (for one clock cycle) when RxD_data_ready is asserted
);

parameter ClkFrequency = 50000000;
parameter Baud = 115200;
parameter Oversampling = 4;	// needs to be a power of 2



//wire RxD_idle;
////////////////////////////////

reg [3:0] RxD_state = 0;
reg [1:0] RxD_sync = 2'b11;
reg [1:0] Filter_cnt = 2'b11;
reg RxD_bit = 1'b1;

//reg RxD_data_ready = 0;

/*`ifdef SIMULATION
wire RxD_bit = RxD;
wire sampleNow = 1'b1;
`else*/
wire OversamplingTick;

BaudTickGen #(ClkFrequency, Baud, Oversampling) tickgen(.clk(clk), .enable(1'b1), .tick(OversamplingTick));

always @(posedge clk)
  if(OversamplingTick)
    RxD_sync <= {RxD_sync[0], RxD};

always @(posedge clk)
  if(OversamplingTick)
    begin
      if(RxD_sync[1]==1'b1 && Filter_cnt!=2'b11) Filter_cnt <= Filter_cnt + 1'd1;
      else
        if(RxD_sync[1]==1'b0 && Filter_cnt!=2'b00) Filter_cnt <= Filter_cnt - 1'd1;
          if(Filter_cnt==2'b11) RxD_bit <= 1'b1;
          else
            if(Filter_cnt==2'b00) RxD_bit <= 1'b0;
    end
// and decide when is the good time to sample the RxD line
function integer log2(input integer v); begin log2=0; while(v>>log2) log2=log2+1; end endfunction
localparam l2o = log2(Oversampling);
reg [l2o-2:0] OversamplingCnt = 0;

always @(posedge clk)
  if(OversamplingTick) OversamplingCnt <= (RxD_state==0) ? 1'd0 : OversamplingCnt + 1'd1;

wire sampleNow = OversamplingTick && (OversamplingCnt==Oversampling/2-1);
//`endif
// now we can accumulate the RxD bits in a shift-register
always @(posedge clk) begin
//if(Rx_done) Rx_ready =0;
  case(RxD_state)
    4'b0000: if(~RxD_bit)
      begin
        RxD_state <= `ifdef SIMULATION 4'b1000 `else 4'b0001 `endif; // start bit found?
//Rx_done<=1'b0;
      end
    4'b0001: if(sampleNow) RxD_state <= 4'b1000;
    4'b1000: if(sampleNow) RxD_state <= 4'b1001;
   	4'b1001: if(sampleNow) RxD_state <= 4'b1010;
    4'b1010: if(sampleNow) RxD_state <= 4'b1011;
    4'b1011: if(sampleNow) RxD_state <= 4'b1100;
    4'b1100: if(sampleNow) RxD_state <= 4'b1101;
    4'b1101: if(sampleNow) RxD_state <= 4'b1110;
    4'b1110: if(sampleNow) RxD_state <= 4'b1111;
    4'b1111: if(sampleNow) RxD_state <= 4'b0010;
    4'b0010: if(sampleNow) // stop bit
      begin
        RxD_state <= 4'b0000;
        RxD_data_ready <= 1'b1;
      end
    default: RxD_state <= 4'b0000;
  endcase
end

always @(posedge clk)
  if(sampleNow && RxD_state[3]) RxD_data <= {RxD_bit, RxD_data[7:1]};
/*`ifdef SIMULATION
assign RxD_idle = 0;
`else*/
reg [l2o+1:0] GapCnt = 0;

always @(posedge clk)
  if (RxD_state!=0) GapCnt<=0;
  else if(OversamplingTick & ~GapCnt[log2(Oversampling)+1]) GapCnt <= GapCnt + 1'h1;

//assign RxD_idle = GapCnt[l2o+1];
//`endif
endmodule
