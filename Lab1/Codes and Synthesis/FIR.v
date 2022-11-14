module FIR#(parameter IN_WIDTH=16,OUT_WIDTH=38,LENGTH=64)(
            clk,
            rst,
            FIR_input,
            input_valid,
            FIR_output,
            output_valid
            );
            
	input clk, rst, input_valid;
	output output_valid;
	input [IN_WIDTH -1:0] FIR_input;
	output [OUT_WIDTH -1:0] FIR_output;

  wire rstM,write,read,rstR,ldRes,ldMul,cntEn,cout,rstC;
  
	datapath #(.length(LENGTH), .inWidth(IN_WIDTH), .outWidth(OUT_WIDTH))dp(
		          .FIR_input(FIR_input),
		          .clk(clk),
		          .rstM(rstM),
		          .write(write),
		          .read(read),
		          .rstR(rstR),
		          .ldRes(ldRes),
		          .ldMul(ldMul),
		          .cntEn(cntEn),
		          .cout(cout),
		          .rstC(rstC),
		          .FIR_output(FIR_output)
		          );
		          
	ctrlUnit cu(
	            .clk(clk),
	            .rst(rst),
	            .input_valid(input_valid),
	            .write(write),
	            .rstC(rstC),
	            .rstR(rstR),
	            .cntEn(cntEn),
	            .ldRes(ldRes),
	            .ldMul(ldMul),
	            .read(read),
	            .cout(cout),
	            .output_valid(output_valid),
	            .rstM(rstM)
	            );

endmodule


