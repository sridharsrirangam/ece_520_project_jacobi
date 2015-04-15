library verilog;
use verilog.vl_types.all;
entity accumulator is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        yv_mult         : in     vl_logic_vector(47 downto 0);
        sel_add_even_odd: in     vl_logic;
        in1_adder1      : out    vl_logic_vector(47 downto 0);
        in2_adder1      : out    vl_logic_vector(47 downto 0);
        in1_adder2      : out    vl_logic_vector(47 downto 0);
        in2_adder2      : out    vl_logic_vector(47 downto 0);
        opt_adder1      : in     vl_logic_vector(47 downto 0);
        opt_adder2      : in     vl_logic_vector(47 downto 0);
        adder1_mode     : out    vl_logic;
        adder2_mode     : out    vl_logic;
        accum_out       : out    vl_logic_vector(47 downto 0);
        feedback_check1 : out    vl_logic;
        feedback_check2 : out    vl_logic;
        enable          : in     vl_logic;
        zero_on_V       : in     vl_logic
    );
end accumulator;
