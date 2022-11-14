library verilog;
use verilog.vl_types.all;
entity async_transmitter is
    generic(
        ClkFrequency    : integer := 50000000;
        Baud            : integer := 115200;
        Oversampling    : integer := 1
    );
    port(
        clk             : in     vl_logic;
        TxD_start       : in     vl_logic;
        TxD_data        : in     vl_logic_vector(7 downto 0);
        TxD             : out    vl_logic;
        TxD_busy        : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ClkFrequency : constant is 1;
    attribute mti_svvh_generic_type of Baud : constant is 1;
    attribute mti_svvh_generic_type of Oversampling : constant is 1;
end async_transmitter;
