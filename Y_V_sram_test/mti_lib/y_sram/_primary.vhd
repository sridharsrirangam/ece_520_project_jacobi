library verilog;
use verilog.vl_types.all;
entity y_sram is
    port(
        clock           : in     vl_logic;
        WE              : in     vl_logic;
        WriteAddress    : in     vl_logic_vector(10 downto 0);
        ReadAddress1    : in     vl_logic_vector(10 downto 0);
        ReadAddress2    : in     vl_logic_vector(10 downto 0);
        WriteBus        : in     vl_logic_vector(255 downto 0);
        ReadBus1        : out    vl_logic_vector(255 downto 0);
        ReadBus2        : out    vl_logic_vector(255 downto 0)
    );
end y_sram;
