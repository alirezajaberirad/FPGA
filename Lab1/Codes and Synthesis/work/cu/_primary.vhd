library verilog;
use verilog.vl_types.all;
entity cu is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        receiver_Dr     : in     vl_logic;
        output_valid    : in     vl_logic;
        TxD_busy        : in     vl_logic;
        ldR             : out    vl_logic;
        ldT             : out    vl_logic;
        morl            : out    vl_logic;
        shf8            : out    vl_logic;
        input_valid     : out    vl_logic;
        TxD_start       : out    vl_logic
    );
end cu;
