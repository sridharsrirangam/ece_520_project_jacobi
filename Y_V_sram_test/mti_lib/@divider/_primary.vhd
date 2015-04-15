library verilog;
use verilog.vl_types.all;
entity Divider is
    port(
        clock           : in     vl_logic;
        in_diag         : in     vl_logic_vector(47 downto 0);
        in_accum        : in     vl_logic_vector(47 downto 0);
        opt_div         : out    vl_logic_vector(47 downto 0)
    );
end Divider;
