library verilog;
use verilog.vl_types.all;
entity getYMatAddress is
    port(
        readEnable      : in     vl_logic;
        gYMA_row        : in     vl_logic_vector(15 downto 0);
        gYMA_readData   : in     vl_logic_vector(255 downto 0);
        gYMA_row_addr1  : out    vl_logic_vector(10 downto 0)
    );
end getYMatAddress;
