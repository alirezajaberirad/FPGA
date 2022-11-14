module adder #(parameter width)(
         in0,
         in1,
         out
         );

  input signed[width-1:0] in0,in1;
  output signed[width-1:0] out;
  
  assign out=in0+in1;
  
endmodule
