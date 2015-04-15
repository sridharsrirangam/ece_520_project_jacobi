library verilog;
use verilog.vl_types.all;
entity yAddrDecodr is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        yAD_enable      : in     vl_logic;
        yAD_readRowNum  : in     vl_logic_vector(15 downto 0);
        yAD_readRowData : in     vl_logic_vector(255 downto 0);
        yAD_outAddr1    : out    vl_logic_vector(10 downto 0);
        yAD_outAddr2    : out    vl_logic_vector(10 downto 0);
        yAD_dataOutNextCycle: out    vl_logic
    );
end yAddrDecodr;
