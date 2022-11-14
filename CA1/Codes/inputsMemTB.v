module inputsMemTB;
  
  reg clk,rst,read,write;
  reg[15:0] in;
  reg[6:0] address;
  
  wire[15:0] out;
  
  inputsMem IM(
            .in(in),
            .address(address),
            .clk(clk),
            .rst(rst),
            .write(write),
            .read(read),
            .out(out)
            );
            
  always #5 clk=~clk;
  
  initial
  begin
    clk=0;
    rst=1;
    #40
    rst=0;
    write=1;
    read=0;
    address=0;
    in=4;
    #20
    write=0;
    read=1;
    address=3;
    #10
    address=1;
    #10
    $stop;
  end    
  
endmodule
