library verilog;
use verilog.vl_types.all;
entity datapath is
    generic(
        inWidth         : vl_notype;
        outWidth        : vl_notype;
        length          : vl_notype
    );
    port(
        FIR_input       : in     vl_logic_vector;
        clk             : in     vl_logic;
        rstM            : in     vl_logic;
        write           : in     vl_logic;
        read            : in     vl_logic;
        rstR            : in     vl_logic;
        ldRes           : in     vl_logic;
        ldMul           : in     vl_logic;
        cntEn           : in     vl_logic;
        cout            : out    vl_logic;
        rstC            : in     vl_logic;
        FIR_output      : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of inWidth : constant is 5;
    attribute mti_svvh_generic_type of outWidth : constant is 5;
    attribute mti_svvh_generic_type of length : constant is 5;
end datapath;
