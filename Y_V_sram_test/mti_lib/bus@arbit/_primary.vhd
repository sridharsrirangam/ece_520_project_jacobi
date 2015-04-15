library verilog;
use verilog.vl_types.all;
entity busArbit is
    port(
        reset           : in     vl_logic;
        in_yComputeModuleEnable: in     vl_logic;
        in_yWriteModuleEnable: in     vl_logic;
        in_integrateModEnable: in     vl_logic;
        in_controlPathReadAddr1: in     vl_logic_vector(10 downto 0);
        in_controlPathReadAddr2: in     vl_logic_vector(10 downto 0);
        in_controlPathWE: in     vl_logic;
        in_controlPathWriteAddr: in     vl_logic_vector(10 downto 0);
        in_controlPathWriteData: in     vl_logic_vector(255 downto 0);
        in_writePathReadAddr1: in     vl_logic_vector(10 downto 0);
        in_writePathReadAddr2: in     vl_logic_vector(10 downto 0);
        in_writePathWE  : in     vl_logic;
        in_writePathWriteAddr: in     vl_logic_vector(10 downto 0);
        in_writePathWriteData: in     vl_logic_vector(255 downto 0);
        in_computePathReadAddr1: in     vl_logic_vector(10 downto 0);
        in_computePathReadAddr2: in     vl_logic_vector(10 downto 0);
        in_computePathWE: in     vl_logic;
        in_computePathWriteAddr: in     vl_logic_vector(10 downto 0);
        in_computePathWriteData: in     vl_logic_vector(255 downto 0);
        op_yReadAddress1: out    vl_logic_vector(10 downto 0);
        op_yReadAddress2: out    vl_logic_vector(10 downto 0);
        op_yWriteEnable : out    vl_logic;
        op_yWriteAddress: out    vl_logic_vector(10 downto 0);
        op_writeData    : out    vl_logic_vector(255 downto 0)
    );
end busArbit;
