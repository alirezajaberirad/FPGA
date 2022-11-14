`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// This is a sample self-checking testbench
// 
//////////////////////////////////////////////////////////////////////////////////
module myFIR_tb;

parameter   IN_WIDTH = 16;
parameter   OUT_WIDTH = 38;
parameter	DATA_LEN=15000;
reg   [IN_WIDTH-1:0] din;
wire  [OUT_WIDTH-1:0] dout;
wire  output_valid;

reg [OUT_WIDTH-1:0]  expected_data [0:DATA_LEN];
reg [IN_WIDTH-1:0]  input_data [0:DATA_LEN];
reg [OUT_WIDTH-1:0]  temp_out;
reg clk,RST_n,input_valid;
integer i,fp,fpReport,cnt,k;

FIR uut (
    .FIR_input(din), 
    .clk(clk), 
    .rst(RST_n), 
    .FIR_output(dout),
    .input_valid(input_valid),
    .output_valid(output_valid)
    );

initial
    begin  
    $readmemb("inputs.txt", input_data);   
end

initial
    begin
    $readmemb("outputs.txt", expected_data);
end           

initial
begin
	clk = 1'b0;
end

always #10 clk = ~clk;

initial
   begin 
	RST_n = 1'b1;
   din = 16'b0; 
   input_valid=0;  
	cnt=0;
   #40;
   RST_n = 1'b0;
end         

initial
begin
	fp = $fopen("outManualFIRVerilog.txt");
	fpReport = $fopen("Report.txt");
	#40;
	$display("Testing %d Samples...",DATA_LEN);		
	for(i = 0; i < DATA_LEN; i = i + 1)
	begin
	     input_valid=1;
	     din=input_data[i];
	   @(posedge output_valid)
	   begin
	     input_valid=0;
	     $fwrite(fp,"%b\n",dout);
	     temp_out=expected_data[i];
	     if(dout != temp_out[OUT_WIDTH-1:0])
	       begin
	         $display("test failed: %d   input: %x expected: %x output: %x" , i, din, temp_out[OUT_WIDTH-1:0], dout);
	         $fwrite(fpReport,"test failed: %d   input: %x expected: %x output: %x\n" , i, din, temp_out[OUT_WIDTH-1:0], dout);
	       end
	   end 
	end

$fwrite(fpReport,"Test passed.\n");
$fclose(fpReport);	
$fclose(fp);
$display ("Test Passed.");
$finish;
end
endmodule



