library verilog;
use verilog.vl_types.all;
entity divider_wrap is
    port(
        in_divider      : in     vl_logic_vector(47 downto 0);
        in_dividend     : in     vl_logic_vector(47 downto 0);
        in_outputOfDivider: in     vl_logic_vector(47 downto 0);
        op_dividerIn1   : out    vl_logic_vector(47 downto 0);
        op_dividerIn2   : out    vl_logic_vector(47 downto 0);
        op_dividerResult: out    vl_logic_vector(47 downto 0)
    );
end divider_wrap;
