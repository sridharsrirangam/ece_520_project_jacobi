library verilog;
use verilog.vl_types.all;
entity vSRAMwrite is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic;
        in_colNum_info  : in     vl_logic_vector(9 downto 0);
        in_dataWriteVal : in     vl_logic_vector(47 downto 0);
        dividor_done    : in     vl_logic;
        control_vsram_section: in     vl_logic;
        writeVsramDoneFlag: out    vl_logic;
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
        sram_4_writeData: out    vl_logic_vector(47 downto 0)
    );
end vSRAMwrite;
