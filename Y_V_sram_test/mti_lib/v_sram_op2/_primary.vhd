library verilog;
use verilog.vl_types.all;
entity v_sram_op2 is
    port(
        clock           : in     vl_logic;
        WE              : in     vl_logic;
        WriteAddress1   : in     vl_logic_vector(8 downto 0);
        WriteAddress2   : in     vl_logic_vector(8 downto 0);
        ReadAddress1    : in     vl_logic_vector(8 downto 0);
        ReadAddress2    : in     vl_logic_vector(8 downto 0);
        WriteBus1       : in     vl_logic_vector(47 downto 0);
        WriteBus2       : in     vl_logic_vector(47 downto 0);
        ReadBus1        : out    vl_logic_vector(47 downto 0);
        ReadBus2        : out    vl_logic_vector(47 downto 0)
    );
end v_sram_op2;
