library verilog;
use verilog.vl_types.all;
entity control_I_accum is
    port(
        clock           : in     vl_logic;
        get_I_flag      : in     vl_logic;
        I_column_info   : in     vl_logic_vector(9 downto 0);
        I_sram_addressline_1: out    vl_logic_vector(7 downto 0);
        I_value_select  : out    vl_logic_vector(1 downto 0)
    );
end control_I_accum;
