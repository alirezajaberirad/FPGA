module dp(
        input clk,
        input rst,
        input RxD,
        input ldR,
        input ldT,
        input morl,
        input shf8,
        input input_valid,
        output output_valid,
        input TxD_start,

        output TxD_busy,
        output TxD,
        output RxD_data_ready
    );

    parameter IN_WIDTH=16;
    parameter OUT_WIDTH=38;
    parameter LENGTH=64;


    wire [7:0]RxD_data,TxD_data;
    wire [15:0]FIR_input;
    wire [37:0]FIR_output;


        FIR #(IN_WIDTH, OUT_WIDTH, LENGTH) inst1 (
            clk,
            rst,
            FIR_input,
            input_valid,
            FIR_output,
            output_valid
        );

    async_receiver inst2 (
            clk,
            RxD,
            RxD_data_ready,
            RxD_data
        );

    async_transmitter inst3 (
            clk,
            TxD_start,
            TxD_data,
            TxD,
            TxD_busy
       );

    R_reg inst4 (
            clk,
            ldR,
            morl,
            RxD_data,
            FIR_input
       );

    T_reg inst5 (
            clk,
            ldT,
            shf8,
            FIR_output,
            TxD_data
    );



endmodule
