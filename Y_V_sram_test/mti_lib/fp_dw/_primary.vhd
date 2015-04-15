library verilog;
use verilog.vl_types.all;
entity fp_dw is
    port(
        in1_adder1      : in     vl_logic_vector(47 downto 0);
        in2_adder1      : in     vl_logic_vector(47 downto 0);
        opt_adder1      : out    vl_logic_vector(47 downto 0);
        adder1_mode     : in     vl_logic;
        clock           : in     vl_logic
    );
end fp_dw;
