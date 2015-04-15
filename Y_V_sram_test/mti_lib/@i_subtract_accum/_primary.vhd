library verilog;
use verilog.vl_types.all;
entity I_subtract_accum is
    port(
        I_input         : in     vl_logic_vector(191 downto 0);
        accum_value     : in     vl_logic_vector(47 downto 0);
        in1_sub1        : out    vl_logic_vector(47 downto 0);
        in2_sub1        : out    vl_logic_vector(47 downto 0);
        opt_sub1        : in     vl_logic_vector(47 downto 0);
        result_I_minus_Accum: out    vl_logic_vector(47 downto 0);
        I_value_select  : in     vl_logic_vector(1 downto 0);
        get_I_flag      : in     vl_logic;
        clock           : in     vl_logic;
        enable          : in     vl_logic;
        reset           : in     vl_logic
    );
end I_subtract_accum;
