library verilog;
use verilog.vl_types.all;
entity accum_control is
    port(
        feedback_check1 : in     vl_logic;
        feedback_check2 : in     vl_logic;
        accum_done      : out    vl_logic;
        get_I_flag      : out    vl_logic;
        sel_add_even_odd: out    vl_logic;
        row_count       : out    vl_logic_vector(9 downto 0);
        row_count_I     : out    vl_logic_vector(9 downto 0);
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic
    );
end accum_control;
