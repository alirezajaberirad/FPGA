library verilog;
use verilog.vl_types.all;
entity uart is
    port(
        CLOCK_50        : in     vl_logic;
        KEY             : in     vl_logic_vector(0 downto 0);
        UART_RXD        : in     vl_logic;
        UART_TXD        : out    vl_logic;
        LEDR            : out    vl_logic_vector(0 downto 0)
    );
end uart;
