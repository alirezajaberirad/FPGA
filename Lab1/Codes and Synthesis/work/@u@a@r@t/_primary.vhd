library verilog;
use verilog.vl_types.all;
entity UART is
    port(
        CLOCK_50        : in     vl_logic;
        KEY             : in     vl_logic;
        UART_RXD        : in     vl_logic;
        UART_TXD        : out    vl_logic;
        LEDR0           : out    vl_logic
    );
end UART;
