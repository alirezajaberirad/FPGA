library verilog;
use verilog.vl_types.all;
entity BaudTickGen is
    generic(
        ClkFrequency    : integer := 50000000;
        Baud            : integer := 115200;
        Oversampling    : integer := 1
    );
    port(
        clk             : in     vl_logic;
        enable          : in     vl_logic;
        tick            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ClkFrequency : constant is 1;
    attribute mti_svvh_generic_type of Baud : constant is 1;
    attribute mti_svvh_generic_type of Oversampling : constant is 1;
end BaudTickGen;
