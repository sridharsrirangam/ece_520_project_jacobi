library verilog;
use verilog.vl_types.all;
entity integrate is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic;
        y_feed_mult     : out    vl_logic_vector(47 downto 0);
        v_feed_mult     : out    vl_logic_vector(47 downto 0);
        sram_1_addressline_1: out    vl_logic_vector(8 downto 0);
        sram_1_addressline_2: out    vl_logic_vector(8 downto 0);
        sram_2_addressline_1: out    vl_logic_vector(8 downto 0);
        sram_2_addressline_2: out    vl_logic_vector(8 downto 0);
        sram_3_addressline_1: out    vl_logic_vector(8 downto 0);
        sram_3_addressline_2: out    vl_logic_vector(8 downto 0);
        sram_4_addressline_1: out    vl_logic_vector(8 downto 0);
        sram_4_addressline_2: out    vl_logic_vector(8 downto 0);
        sram_1_readline_1: in     vl_logic_vector(47 downto 0);
        sram_1_readline_2: in     vl_logic_vector(47 downto 0);
        sram_2_readline_1: in     vl_logic_vector(47 downto 0);
        sram_2_readline_2: in     vl_logic_vector(47 downto 0);
        sram_3_readline_1: in     vl_logic_vector(47 downto 0);
        sram_3_readline_2: in     vl_logic_vector(47 downto 0);
        sram_4_readline_1: in     vl_logic_vector(47 downto 0);
        sram_4_readline_2: in     vl_logic_vector(47 downto 0);
        Y_addressline_1 : out    vl_logic_vector(10 downto 0);
        ReadAddress2    : out    vl_logic_vector(10 downto 0);
        Yin             : in     vl_logic_vector(255 downto 0);
        I_input         : in     vl_logic_vector(191 downto 0);
        in1_sub1        : out    vl_logic_vector(47 downto 0);
        in2_sub1        : out    vl_logic_vector(47 downto 0);
        opt_sub1        : in     vl_logic_vector(47 downto 0);
        I_sram_addressline_1: out    vl_logic_vector(7 downto 0);
        op_dividerIn1   : out    vl_logic_vector(47 downto 0);
        op_dividerIn2   : out    vl_logic_vector(47 downto 0);
        in_outputOfDivider: in     vl_logic_vector(47 downto 0);
        sram_1_writeAddressline: out    vl_logic_vector(8 downto 0);
        sram_2_writeAddressline: out    vl_logic_vector(8 downto 0);
        sram_3_writeAddressline: out    vl_logic_vector(8 downto 0);
        sram_4_writeAddressline: out    vl_logic_vector(8 downto 0);
        sram_1_writeEnable: out    vl_logic;
        sram_2_writeEnable: out    vl_logic;
        sram_3_writeEnable: out    vl_logic;
        sram_4_writeEnable: out    vl_logic;
        sram_1_writeData: out    vl_logic_vector(47 downto 0);
        sram_2_writeData: out    vl_logic_vector(47 downto 0);
        sram_3_writeData: out    vl_logic_vector(47 downto 0);
        sram_4_writeData: out    vl_logic_vector(47 downto 0);
        control_vsram_section: in     vl_logic;
        vsram_read_control: in     vl_logic;
        iter_done       : out    vl_logic;
        accum_feed      : in     vl_logic_vector(47 downto 0);
        adder1_mode     : out    vl_logic;
        adder2_mode     : out    vl_logic;
        in1_adder1      : out    vl_logic_vector(47 downto 0);
        in2_adder1      : out    vl_logic_vector(47 downto 0);
        opt_adder1      : in     vl_logic_vector(47 downto 0);
        in1_adder2      : out    vl_logic_vector(47 downto 0);
        in2_adder2      : out    vl_logic_vector(47 downto 0);
        opt_adder2      : in     vl_logic_vector(47 downto 0)
    );
end integrate;