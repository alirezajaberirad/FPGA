module cu(
        input clk,
        input rst,
        input receiver_Dr,
        input output_valid,
        input TxD_busy,
        output ldR,
        output ldT,
        output morl,
        output shf8,
        output input_valid,
        output TxD_start

    );
    
    // receive_ctrl

    reg [1:0]ps,ns;
    
    always@(posedge clk,posedge rst) begin
        if(rst) ps <= 2'b00;else ps <= ns;
    end    
    
    always@(receiver_Dr, ps) begin
        ns = 2'b00;
        case(ps)
        2'b00: if(~receiver_Dr) ns = 2'b00; else ns = 2'b01;
        2'b01: if(~receiver_Dr) ns = 2'b01; else ns = 2'b10;
        2'b10: ns = 2'b00;
        default: ns = 2'b00;
        endcase
    end
    
    assign  ldR = ((ps == 2'b00 & receiver_Dr) | (ps == 2'b01))?1'b1:1'b0;
    assign  morl = (ps == 2'b00 & receiver_Dr)?1'b1:1'b0;
    assign input_valid = (ps == 2'b10)?1'b1:1'b0;
    
    ///////////////////////////////////////////////////
    // transmit_ctrl
    
    reg[2:0]Ps,Ns;
    
    always@(posedge clk, posedge rst) begin
        if(rst) Ps <= 2'b00;else Ps <= Ns;
    end   
    
    always@(output_valid, TxD_busy, Ps) begin
        Ns = 2'b00;
        case(Ps)
        3'b000: if(output_valid) Ns = 3'b001;else Ns = 3'b000;
        3'b001: Ns = 3'b010;
        3'b010: Ns = 3'b011;
        3'b011: if(~TxD_busy) Ns = 3'b100; else Ns = 3'b011;
        3'b100: Ns = 3'b000;
        default: Ns = 3'b000;
        endcase
    end
    assign ldT = (Ps == 3'b000 & output_valid)?1'b1:1'b0;// | (Ps == 3'b001) | (Ps == 3'b010))?1'b1:1'b0;
    //assign TxD_start = (Ps == 3'b001)?1'b1:1'b0;
    assign shf8 = (Ps == 3'b010)?1'b1:1'b0;
    assign TxD_start = ( (Ps == 3'b011 & (~TxD_busy))|(Ps == 3'b001) )?1'b1:1'b0;
    
    
        
endmodule