module T_reg(
        input clk,
        input ld,
        input shf8,
        input [37:0]FIR_output,
        output reg [7:0] Txd_data

    );
    
    reg[15:0] fir_out_reg;
    always@(posedge clk)
        begin
          if(ld)
            fir_out_reg<=FIR_output[26:11];
          if(shf8)
            Txd_data<=fir_out_reg[7:0];
          else
            Txd_data<=fir_out_reg[15:8];
        end
        
    
endmodule