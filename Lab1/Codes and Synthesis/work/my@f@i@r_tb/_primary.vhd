library verilog;
use verilog.vl_types.all;
entity myFIR_tb is
    generic(
        IN_WIDTH        : integer := 16;
        OUT_WIDTH       : integer := 38;
        DATA_LEN        : integer := 15000
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IN_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of OUT_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of DATA_LEN : constant is 1;
end myFIR_tb;
