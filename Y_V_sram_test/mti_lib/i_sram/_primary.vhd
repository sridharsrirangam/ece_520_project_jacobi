library verilog;
use verilog.vl_types.all;
entity i_sram is
    port(
        clock           : in     vl_logic;
        WE              : in     vl_logic;
        WriteAddress    : in     vl_logic_vector(7 downto 0);
        ReadAddress1    : in     vl_logic_vector(7 downto 0);
        ReadAddress2    : in     vl_logic_vector(7 downto 0);
        WriteBus        : in     vl_logic_vector(191 downto 0);
        ReadBus1        : out    vl_logic_vector(191 downto 0);
        ReadBus2        : out    vl_logic_vector(191 downto 0)
    );
end i_sram;
