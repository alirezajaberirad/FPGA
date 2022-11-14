library verilog;
use verilog.vl_types.all;
entity ctrlUnit is
    generic(
        init            : integer := 0;
        getInput        : integer := 1;
        multiply        : integer := 2;
        add             : integer := 3;
        accumulate      : integer := 4;
        outputReady     : integer := 5
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        input_valid     : in     vl_logic;
        write           : out    vl_logic;
        rstC            : out    vl_logic;
        rstR            : out    vl_logic;
        cntEn           : out    vl_logic;
        ldRes           : out    vl_logic;
        ldMul           : out    vl_logic;
        read            : out    vl_logic;
        cout            : in     vl_logic;
        output_valid    : out    vl_logic;
        rstM            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of init : constant is 1;
    attribute mti_svvh_generic_type of getInput : constant is 1;
    attribute mti_svvh_generic_type of multiply : constant is 1;
    attribute mti_svvh_generic_type of add : constant is 1;
    attribute mti_svvh_generic_type of accumulate : constant is 1;
    attribute mti_svvh_generic_type of outputReady : constant is 1;
end ctrlUnit;
