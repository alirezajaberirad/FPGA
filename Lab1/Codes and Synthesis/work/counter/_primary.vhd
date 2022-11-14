library verilog;
use verilog.vl_types.all;
entity counter is
    generic(
        length          : vl_notype
    );
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        cntEn           : in     vl_logic;
        cout            : out    vl_logic;
        address         : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of length : constant is 5;
end counter;
