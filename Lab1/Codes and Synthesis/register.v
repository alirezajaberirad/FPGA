module register #(parameter width)(
           clk,
           rst,
           ld,
           in,
           out
           );
  
  input clk,rst,ld;
  input [width-1:0] in;
  output reg [width-1:0] out;
  
  always @(posedge clk,posedge rst)
    begin
      if(rst)
        out=0;
      else if(ld)
        out=in;
    end
    
endmodule

