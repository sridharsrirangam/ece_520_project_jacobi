library verilog;
use verilog.vl_types.all;
entity V_from_Y is
    port(
        v_ram_no_1      : in     vl_logic_vector(2 downto 0);
        v_ram_no_2      : in     vl_logic_vector(2 downto 0);
        v_ram_no_3      : in     vl_logic_vector(2 downto 0);
        v_ram_no_4      : in     vl_logic_vector(2 downto 0);
        sel_v1_v3       : in     vl_logic_vector(1 downto 0);
        sel_v2_v4       : in     vl_logic_vector(1 downto 0);
        v_value_1       : out    vl_logic_vector(47 downto 0);
        v_value_2       : out    vl_logic_vector(47 downto 0);
        v_value_3       : out    vl_logic_vector(47 downto 0);
        v_value_4       : out    vl_logic_vector(47 downto 0);
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic;
        sram_1_readline_1: in     vl_logic_vector(47 downto 0);
        sram_1_readline_2: in     vl_logic_vector(47 downto 0);
        sram_2_readline_1: in     vl_logic_vector(47 downto 0);
        sram_2_readline_2: in     vl_logic_vector(47 downto 0);
        sram_3_readline_1: in     vl_logic_vector(47 downto 0);
        sram_3_readline_2: in     vl_logic_vector(47 downto 0);
        sram_4_readline_1: in     vl_logic_vector(47 downto 0);
        sram_4_readline_2: in     vl_logic_vector(47 downto 0)
    );
end V_from_Y;
