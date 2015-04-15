library verilog;
use verilog.vl_types.all;
entity yv_control is
    port(
        y_1_col_info    : in     vl_logic_vector(15 downto 0);
        y_2_col_info    : in     vl_logic_vector(15 downto 0);
        y_3_col_info    : in     vl_logic_vector(15 downto 0);
        y_4_col_info    : in     vl_logic_vector(15 downto 0);
        sram_1_addressline_1: out    vl_logic_vector(8 downto 0);
        sram_1_addressline_2: out    vl_logic_vector(8 downto 0);
        sram_2_addressline_1: out    vl_logic_vector(8 downto 0);
        sram_2_addressline_2: out    vl_logic_vector(8 downto 0);
        sram_3_addressline_1: out    vl_logic_vector(8 downto 0);
        sram_3_addressline_2: out    vl_logic_vector(8 downto 0);
        sram_4_addressline_1: out    vl_logic_vector(8 downto 0);
        sram_4_addressline_2: out    vl_logic_vector(8 downto 0);
        Y_addressline_1 : out    vl_logic_vector(10 downto 0);
        v_ram_no_1      : out    vl_logic_vector(2 downto 0);
        v_ram_no_2      : out    vl_logic_vector(2 downto 0);
        v_ram_no_3      : out    vl_logic_vector(2 downto 0);
        v_ram_no_4      : out    vl_logic_vector(2 downto 0);
        switch_from_fifo1_fifo2: out    vl_logic;
        sel_v1_v3       : out    vl_logic_vector(1 downto 0);
        sel_v2_v4       : out    vl_logic_vector(1 downto 0);
        reset           : in     vl_logic;
        enable          : in     vl_logic;
        clock           : in     vl_logic;
        vsram_read_control: in     vl_logic
    );
end yv_control;
