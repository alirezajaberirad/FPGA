module ctrlUnit(
	            clk,
	            rst,
	            input_valid,
	            write,
	            rstC,
	            rstR,
	            cntEn,
	            ldRes,
	            ldMul,
	            read,
	            cout,
	            output_valid,
	            rstM
	            );
  
  input clk,rst,input_valid,cout;
  output reg write, rstC, rstR, rstM, cntEn, ldMul, ldRes, read, output_valid;
  reg[2:0] ps,ns;
  parameter init=0,getInput=1,multiply=2,add=3,accumulate=4,outputReady=5;
  
  always@(posedge clk)
  begin
    rstM=0;
    if(rst)begin
      rstM=1;
      ps=init;
    end
    else
      ps=ns;
  end
      
  always@(ps,input_valid,cout)
  begin
    ns=2'b00;
    case(ps)
      init: ns= input_valid ? getInput : init;
      getInput: ns=multiply;
      multiply: ns=add;
      add: ns=accumulate;
      accumulate: ns= cout ? outputReady : multiply;
      outputReady: ns= init;
    endcase
  end
  
  always@(ps)
  begin
    rstC=0; rstR=0; write=0; cntEn=0; ldMul=0; ldRes=0; read=0; output_valid=0;
    case(ps)
      init:begin rstC=1; rstR=1; end
      getInput: write=1;
      multiply: read=1;
      add: ldMul=1;
      accumulate:begin ldRes=1; cntEn=1; end
      outputReady: output_valid=1;
    endcase
  end
  
endmodule

