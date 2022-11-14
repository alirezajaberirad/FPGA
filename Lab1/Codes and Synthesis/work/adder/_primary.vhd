library verilog;
use verilog.vl_types.all;
entity adder is
    generic(
        width           : vl_notype
    );
    port(
        in0             : in     vl_logic_vector;
        in1             : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 5;
end adder;
