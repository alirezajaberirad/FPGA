library verilog;
use verilog.vl_types.all;
entity FIR is
    generic(
        IN_WIDTH        : integer := 16;
        OUT_WIDTH       : integer := 38;
        LENGTH          : integer := 64
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        FIR_input       : in     vl_logic_vector;
        input_valid     : in     vl_logic;
        FIR_output      : out    vl_logic_vector;
        output_valid    : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IN_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of OUT_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of LENGTH : constant is 1;
end FIR;
