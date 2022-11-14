library verilog;
use verilog.vl_types.all;
entity multiplier is
    generic(
        inWidth         : vl_notype;
        outWidth        : vl_notype
    );
    port(
        in0             : in     vl_logic_vector;
        in1             : in     vl_logic_vector;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of inWidth : constant is 5;
    attribute mti_svvh_generic_type of outWidth : constant is 5;
end multiplier;
