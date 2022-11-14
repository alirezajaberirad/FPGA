module R_reg(
        input clk,
        input ld,
        input morl,
        input [7:0] Rxd_data,
        output reg[15:0] FIR_input

    );
    
    
    always@(posedge clk)
        begin
          if(ld)
            if(morl == 1)
               FIR_input[15:8] <= Rxd_data;
            else if(morl == 0) 
               FIR_input[7:0] <= Rxd_data;
        end
        
    
endmodule            