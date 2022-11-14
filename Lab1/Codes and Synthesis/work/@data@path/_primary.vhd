library verilog;
use verilog.vl_types.all;
entity DataPath is
    generic(
        IN_WIDTH        : integer := 16;
        OUT_WIDTH       : integer := 38;
        LENGTH          : integer := 64
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        RxD             : in     vl_logic;
        ldR             : in     vl_logic;
        ldT             : in     vl_logic;
        morl            : in     vl_logic;
        shf8            : in     vl_logic;
        input_valid     : in     vl_logic;
        output_valid    : in     vl_logic;
        TxD_start       : in     vl_logic;
        TxD_busy        : out    vl_logic;
        TxD             : out    vl_logic;
        RxD_data_ready  : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IN_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of OUT_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of LENGTH : constant is 1;
end DataPath;
