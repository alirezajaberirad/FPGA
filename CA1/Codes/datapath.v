module datapath #(parameter inWidth, outWidth, length) 
              (
              FIR_input,
		          clk,
		          rstM,
		          write,
		          read,
		          rstR,
		          ldRes,
		          ldMul,
		          cntEn,
		          cout,
		          rstC,
		          FIR_output
		          );

  input[inWidth-1:0] FIR_input;
  input clk,rstM,write,read,rstR,ldMul,ldRes,cntEn,rstC;
  output[outWidth-1:0] FIR_output;
  output cout;
  
  wire[outWidth-1:0] add,regOut,mul,mulRegOut;
  wire[inWidth-1:0] x,b;
  wire[$clog2(length) : 0] address;
  
  assign FIR_output=regOut;
  
  register #(.width(outWidth)) 
      regis(
           .clk(clk),
           .rst(rstR),
           .ld(ldRes),
           .in(add),
           .out(regOut)
           );
           
  adder #(.width(outWidth))
      ad(
         .in0(mulRegOut),
         .in1(regOut),
         .out(add)
         );
         
  register #(.width(outWidth))
      mulReg(
             .clk(clk),
             .rst(rstR),
             .ld(ldMul),
             .in(mul),
             .out(mulRegOut)
             );
  
  multiplier #(.inWidth(inWidth),.outWidth(outWidth))
      mult(
           .in0(x),
           .in1(b),
           .out(mul)
           ); 
           
  inputsMem #(.width(inWidth), .length(length))
      inMem(
            .in(FIR_input),
            .address(address),
            .clk(clk),
            .rst(rstM),
            .write(write),
            .read(read),
            .out(x)
            );    
            
  coeffsMem #(.width(inWidth), .length(length))
      coMem(
            .clk(clk),
            .address(address),
            .out(b)
            );   
            
  counter #(.length(length))
      cnt(
          .clk(clk),
          .rst(rstC),
          .cntEn(cntEn),
          .cout(cout),
          .address(address)
          );     
  
endmodule

