library verilog;
use verilog.vl_types.all;
entity updateY_control is
    generic(
        s0              : integer := 0;
        s1              : integer := 1;
        s2              : integer := 2;
        s3              : integer := 3;
        s4              : integer := 4;
        s5              : integer := 5;
        s6              : integer := 6;
        s7              : integer := 7
    );
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        exModDone       : in     vl_logic;
        chng_row        : in     vl_logic_vector(15 downto 0);
        chng_col        : in     vl_logic_vector(15 downto 0);
        chng_real       : in     vl_logic_vector(23 downto 0);
        chng_img        : in     vl_logic_vector(23 downto 0);
        dpModDoneFlag   : in     vl_logic;
        ymem_data1      : in     vl_logic_vector(255 downto 0);
        ymem_data2      : in     vl_logic_vector(255 downto 0);
        filt_EN         : in     vl_logic;
        yMemDataReadyNextCycle: in     vl_logic;
        yAddrIn1        : in     vl_logic_vector(10 downto 0);
        yAddrIn2        : in     vl_logic_vector(10 downto 0);
        op_y_row        : out    vl_logic_vector(15 downto 0);
        op_yVal1        : out    vl_logic_vector(47 downto 0);
        op_yVal2        : out    vl_logic_vector(47 downto 0);
        op_EX_EN        : out    vl_logic;
        op_DataEN       : out    vl_logic;
        op_yAddrDiag    : out    vl_logic_vector(10 downto 0);
        op_yAddrNonDiag : out    vl_logic_vector(10 downto 0);
        op_oneHotDiag   : out    vl_logic_vector(3 downto 0);
        op_oneHotNonDiag: out    vl_logic_vector(3 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of s0 : constant is 1;
    attribute mti_svvh_generic_type of s1 : constant is 1;
    attribute mti_svvh_generic_type of s2 : constant is 1;
    attribute mti_svvh_generic_type of s3 : constant is 1;
    attribute mti_svvh_generic_type of s4 : constant is 1;
    attribute mti_svvh_generic_type of s5 : constant is 1;
    attribute mti_svvh_generic_type of s6 : constant is 1;
    attribute mti_svvh_generic_type of s7 : constant is 1;
end updateY_control;
