library verilog;
use verilog.vl_types.all;
entity updateY_datapath is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        executeEnableBit: in     vl_logic;
        yInVal1         : in     vl_logic_vector(47 downto 0);
        yInVal2         : in     vl_logic_vector(47 downto 0);
        op_yWriteVal    : out    vl_logic_vector(47 downto 0);
        op_DoneFlag     : out    vl_logic;
        op_ExDoneFlag   : out    vl_logic;
        op_CPDoneFlag   : out    vl_logic;
        op_fpIn1        : out    vl_logic_vector(47 downto 0);
        op_fpIn2        : out    vl_logic_vector(47 downto 0);
        op_fpMode       : out    vl_logic;
        in_fpOut        : in     vl_logic_vector(47 downto 0)
    );
end updateY_datapath;
