library verilog;
use verilog.vl_types.all;
entity top is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        writeDoneFlag   : out    vl_logic;
        top_chgTxt_row  : in     vl_logic_vector(15 downto 0);
        top_chgTxt_col  : in     vl_logic_vector(15 downto 0);
        top_chgTxt_real : in     vl_logic_vector(23 downto 0);
        top_chgTxt_img  : in     vl_logic_vector(23 downto 0);
        top_opYval      : out    vl_logic_vector(47 downto 0)
    );
end top;
