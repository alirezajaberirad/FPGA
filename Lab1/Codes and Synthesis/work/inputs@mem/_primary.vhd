library verilog;
use verilog.vl_types.all;
entity inputsMem is
    generic(
        width           : integer := 16;
        length          : integer := 64
    );
    port(
        \in\            : in     vl_logic_vector;
        address         : in     vl_logic_vector;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        write           : in     vl_logic;
        read            : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
    attribute mti_svvh_generic_type of length : constant is 1;
end inputsMem;
