library verilog;
use verilog.vl_types.all;
entity y_to_fifo is
    port(
        Yin             : in     vl_logic_vector(255 downto 0);
        v_value_1       : in     vl_logic_vector(47 downto 0);
        v_value_2       : in     vl_logic_vector(47 downto 0);
        v_value_3       : in     vl_logic_vector(47 downto 0);
        v_value_4       : in     vl_logic_vector(47 downto 0);
        y_1_col_info    : out    vl_logic_vector(15 downto 0);
        y_2_col_info    : out    vl_logic_vector(15 downto 0);
        y_3_col_info    : out    vl_logic_vector(15 downto 0);
        y_4_col_info    : out    vl_logic_vector(15 downto 0);
        y_feed_mult     : out    vl_logic_vector(47 downto 0);
        v_feed_mult     : out    vl_logic_vector(47 downto 0);
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic;
        switch_from_fifo1_fifo2: in     vl_logic;
        y_diagonal      : out    vl_logic_vector(47 downto 0);
        Y_eof_reg       : out    vl_logic;
        zero_on_V       : out    vl_logic
    );
end y_to_fifo;
