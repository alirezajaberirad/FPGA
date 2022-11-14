module counter #(parameter length)(
          clk,
          rst,
          cntEn,
          cout,
          address
          ); 
         
  input clk,rst,cntEn;
  output cout;
  output[$clog2(length):0] address;
  
  reg[$clog2(length):0] cntReg;
  
  assign address=cntReg;
  assign cout=(address>=length-1) ? 1 : 0;
  
  always@(posedge clk,posedge rst)
    begin
      if(rst)
        cntReg=0;
      else if(cntEn)
        cntReg=cntReg+1;
    end          

endmodule
