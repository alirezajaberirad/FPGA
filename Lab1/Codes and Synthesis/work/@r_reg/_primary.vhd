library verilog;
use verilog.vl_types.all;
entity R_reg is
    port(
        clk             : in     vl_logic;
        ld              : in     vl_logic;
        morl            : in     vl_logic;
        Rxd_data        : in     vl_logic_vector(7 downto 0);
        FIR_input       : out    vl_logic_vector(15 downto 0)
    );
end R_reg;
