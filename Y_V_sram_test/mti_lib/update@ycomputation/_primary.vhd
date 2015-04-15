library verilog;
use verilog.vl_types.all;
entity updateYcomputation is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        computationEnable: in     vl_logic;
        uYc_chgTxt_row  : in     vl_logic_vector(15 downto 0);
        uYc_chgTxt_col  : in     vl_logic_vector(15 downto 0);
        uYc_chgTxt_real : in     vl_logic_vector(23 downto 0);
        uYc_chgTxt_img  : in     vl_logic_vector(23 downto 0);
        uYc_ySRAM_rowRead1: in     vl_logic_vector(255 downto 0);
        uYc_ySRAM_rowRead2: in     vl_logic_vector(255 downto 0);
        uYc_yMatAddrOut1: out    vl_logic_vector(10 downto 0);
        uYc_yMatAddrOut2: out    vl_logic_vector(10 downto 0);
        uYc_dataPathDoneFlag: out    vl_logic;
        uYc_filtYopDone : out    vl_logic;
        uYc_opYval      : out    vl_logic_vector(47 downto 0);
        uYc_writeDiagAddr: out    vl_logic_vector(10 downto 0);
        uYc_writeNonDiagAddr: out    vl_logic_vector(10 downto 0);
        uYc_writeDiagOneHot: out    vl_logic_vector(3 downto 0);
        uYc_writeNonDiagOneHot: out    vl_logic_vector(3 downto 0);
        uYC_op_fpIn1    : out    vl_logic_vector(47 downto 0);
        uYC_op_fpIn2    : out    vl_logic_vector(47 downto 0);
        uYC_op_fpMode   : out    vl_logic;
        uYC_in_fpOut    : in     vl_logic_vector(47 downto 0)
    );
end updateYcomputation;
