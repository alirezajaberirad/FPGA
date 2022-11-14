module multiplier #(parameter inWidth, outWidth)(
           in0,
           in1,
           out
           ); 
    input signed[inWidth-1:0] in0,in1;
    output signed[outWidth-1:0] out;
         
    wire[outWidth-2*inWidth-1:0] signExtend;
    wire signed[2*inWidth-1:0] result;
    assign result=in0*in1;
    assign signExtend=(result[2*inWidth-1]) ? -1 : 0;
    assign out={signExtend,result};
           
endmodule
