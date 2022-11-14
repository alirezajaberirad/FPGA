module coeffsMem #(parameter width, length)(
            clk,
            address,
            out
            );
            
  input clk;
  input[$clog2(length):0] address;
  output reg[width-1:0] out;
  
  reg[width-1:0] memory [0:length-1];
  integer j;
  
  always@(posedge clk)
    begin
      out=memory[address];
    end
  
  initial
	begin
		$readmemb("coeffs.txt",memory);
	end
            
  
endmodule
