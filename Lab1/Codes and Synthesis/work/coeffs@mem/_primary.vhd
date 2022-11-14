library verilog;
use verilog.vl_types.all;
entity coeffsMem is
    generic(
        width           : integer := 16;
        length          : integer := 64
    );
    port(
        clk             : in     vl_logic;
        address         : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
    attribute mti_svvh_generic_type of length : constant is 1;
end coeffsMem;
