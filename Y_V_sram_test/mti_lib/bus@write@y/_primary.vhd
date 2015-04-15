library verilog;
use verilog.vl_types.all;
entity busWriteY is
    generic(
        s0              : integer := 0;
        s1              : integer := 1;
        s2              : integer := 2;
        s3              : integer := 3
    );
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        inModuleEnable  : in     vl_logic;
        cpDoneFlag      : in     vl_logic;
        dpDoneFlag      : in     vl_logic;
        inDiagAddr      : in     vl_logic_vector(10 downto 0);
        inNonDAddr      : in     vl_logic_vector(10 downto 0);
        inDiagOH        : in     vl_logic_vector(3 downto 0);
        inNonDiagOH     : in     vl_logic_vector(3 downto 0);
        inYreadData1    : in     vl_logic_vector(255 downto 0);
        inYreadData2    : in     vl_logic_vector(255 downto 0);
        inYComputedVal  : in     vl_logic_vector(47 downto 0);
        inYchngData     : in     vl_logic_vector(47 downto 0);
        op_writeData    : out    vl_logic_vector(255 downto 0);
        op_writeAddress : out    vl_logic_vector(10 downto 0);
        op_readStoreAddr: out    vl_logic_vector(10 downto 0);
        op_WEbit        : out    vl_logic;
        op_writeDone    : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of s0 : constant is 1;
    attribute mti_svvh_generic_type of s1 : constant is 1;
    attribute mti_svvh_generic_type of s2 : constant is 1;
    attribute mti_svvh_generic_type of s3 : constant is 1;
end busWriteY;
