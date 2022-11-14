module inputsMem #(parameter width=16,length=64)(
            in,
            address,
            clk,
            rst,
            write,
            read,
            out
            );

  input[width-1:0] in;
  input[$clog2(length):0] address;
  input clk,rst,write,read;
  output reg[width-1:0] out;
  integer i;
  
  reg[width-1:0] memory [0:length-1];
  
  always @(posedge clk,posedge rst)
    begin
      if(rst)
        for(i=0;i<length;i=i+1)
          memory[i]<=0;
      else if(write)
        begin
          for(i=1;i<length;i=i+1)
            memory[i]<=memory[i-1];
          memory[0]<=in;
        end
      else if(read)
        out=memory[address];
    end 

endmodule

