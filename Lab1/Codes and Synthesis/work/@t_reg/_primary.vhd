library verilog;
use verilog.vl_types.all;
entity T_reg is
    port(
        clk             : in     vl_logic;
        ld              : in     vl_logic;
        shf8            : in     vl_logic;
        FIR_output      : in     vl_logic_vector(37 downto 0);
        Txd_data        : out    vl_logic_vector(7 downto 0)
    );
end T_reg;
