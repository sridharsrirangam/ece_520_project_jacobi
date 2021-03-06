library verilog;
use verilog.vl_types.all;
entity myDesign is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        writeDoneFlag   : out    vl_logic;
        mydes_chgTxt_row: in     vl_logic_vector(15 downto 0);
        mydes_chgTxt_col: in     vl_logic_vector(15 downto 0);
        mydes_chgTxt_real: in     vl_logic_vector(23 downto 0);
        mydes_chgTxt_img: in     vl_logic_vector(23 downto 0);
        mydes_ySRAM_rowRead1: in     vl_logic_vector(255 downto 0);
        mydes_ySRAM_rowRead2: in     vl_logic_vector(255 downto 0);
        mydes_opYval    : out    vl_logic_vector(47 downto 0);
        mydes_ydataWrite: out    vl_logic_vector(255 downto 0);
        mydes_op_yReadAddress1: out    vl_logic_vector(10 downto 0);
        mydes_op_yReadAddress2: out    vl_logic_vector(10 downto 0);
        mydes_op_yWriteAddress: out    vl_logic_vector(10 downto 0);
        mydes_op_yWriteEnable: out    vl_logic;
        mydes_op_fpIn1  : out    vl_logic_vector(47 downto 0);
        mydes_op_fpIn2  : out    vl_logic_vector(47 downto 0);
        mydes_op_fpMode : out    vl_logic;
        mydes_in_fpOut  : in     vl_logic_vector(47 downto 0);
        mydes_y_feed_mult: out    vl_logic_vector(47 downto 0);
        mydes_v_feed_mult: out    vl_logic_vector(47 downto 0);
        mydes_accum_feed: in     vl_logic_vector(47 downto 0);
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
        sram1_WriteAddress1: out    vl_logic_vector(8 downto 0);
        sram2_WriteAddress1: out    vl_logic_vector(8 downto 0);
        sram3_WriteAddress1: out    vl_logic_vector(8 downto 0);
        sram4_WriteAddress1: out    vl_logic_vector(8 downto 0);
        WE_1            : out    vl_logic;
        WE_2            : out    vl_logic;
        WE_3            : out    vl_logic;
        WE_4            : out    vl_logic;
        sram1_WriteBus1 : in     vl_logic_vector(47 downto 0);
        sram2_WriteBus1 : in     vl_logic_vector(47 downto 0);
        sram3_WriteBus1 : in     vl_logic_vector(47 downto 0);
        sram4_WriteBus1 : in     vl_logic_vector(47 downto 0);
        mydes_inImemData: in     vl_logic_vector(191 downto 0);
        mydes_inImemAddr: out    vl_logic_vector(7 downto 0);
        mydes_in1_sub1  : out    vl_logic_vector(47 downto 0);
        mydes_in2_sub1  : out    vl_logic_vector(47 downto 0);
        mydes_opt_sub1  : in     vl_logic_vector(47 downto 0);
        mydes_in1_adder1: out    vl_logic_vector(47 downto 0);
        mydes_in2_adder1: out    vl_logic_vector(47 downto 0);
        mydes_opt_adder1: in     vl_logic_vector(47 downto 0);
        mydes_adder1_mode: out    vl_logic;
        mydes_in1_adder2: out    vl_logic_vector(47 downto 0);
        mydes_in2_adder2: out    vl_logic_vector(47 downto 0);
        mydes_opt_adder2: in     vl_logic_vector(47 downto 0);
        mydes_adder2_mode: out    vl_logic;
        mydes_op_dividerIn1: out    vl_logic_vector(47 downto 0);
        mydes_op_dividerIn2: out    vl_logic_vector(47 downto 0);
        mydes_in_outputOfDivider: in     vl_logic_vector(47 downto 0)
    );
end myDesign;
