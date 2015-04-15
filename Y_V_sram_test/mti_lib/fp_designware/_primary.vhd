library verilog;
use verilog.vl_types.all;
entity fp_designware is
    port(
        clock           : in     vl_logic;
        y_feed_mult     : in     vl_logic_vector(47 downto 0);
        v_feed_mult     : in     vl_logic_vector(47 downto 0);
        accum_feed      : out    vl_logic_vector(47 downto 0);
        in1_adder1      : in     vl_logic_vector(47 downto 0);
        in2_adder1      : in     vl_logic_vector(47 downto 0);
        in1_adder2      : in     vl_logic_vector(47 downto 0);
        in2_adder2      : in     vl_logic_vector(47 downto 0);
        opt_adder1      : out    vl_logic_vector(47 downto 0);
        opt_adder2      : out    vl_logic_vector(47 downto 0);
        adder1_mode     : in     vl_logic;
        adder2_mode     : in     vl_logic;
        in1_sub1        : in     vl_logic_vector(47 downto 0);
        in2_sub1        : in     vl_logic_vector(47 downto 0);
        opt_sub1        : in     vl_logic_vector(47 downto 0);
        op_dividerIn1   : in     vl_logic_vector(47 downto 0);
        op_dividerIn2   : in     vl_logic_vector(47 downto 0);
        in_outputOfDivider: out    vl_logic_vector(47 downto 0);
        in1_adder_adeesh: in     vl_logic_vector(47 downto 0);
        in2_adder_adeesh: in     vl_logic_vector(47 downto 0);
        opt_adder_adeesh: out    vl_logic_vector(47 downto 0);
        adder_mode_adeesh: in     vl_logic
    );
end fp_designware;
