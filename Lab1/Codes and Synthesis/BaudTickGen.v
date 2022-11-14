module BaudTickGen#(parameter ClkFrequency = 50000000, Baud = 115200, Oversampling = 1)(
    input clk, enable,
    output tick 
);
localparam AccWidth = $clog2(ClkFrequency/Baud)+8; 
reg [AccWidth:0] Acc = 0;
localparam ShiftLimiter = $clog2(Baud*Oversampling >> (31-AccWidth));
localparam Inc = ((Baud*Oversampling << (AccWidth-ShiftLimiter))+(ClkFrequency>>(ShiftLimiter+1)))/(ClkFrequency>>ShiftLimiter);

always @(posedge clk) 
  if(enable) 
    Acc <= Acc[AccWidth-1:0] + Inc[AccWidth:0];
  else 
    Acc <= Inc[AccWidth:0];
    
assign tick = Acc[AccWidth];

endmodule
