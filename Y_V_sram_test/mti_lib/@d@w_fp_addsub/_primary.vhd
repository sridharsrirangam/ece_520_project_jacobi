library verilog;
use verilog.vl_types.all;
entity DW_fp_addsub is
    generic(
        sig_width       : integer := 23;
        exp_width       : integer := 8;
        ieee_compliance : integer := 0
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        rnd             : in     vl_logic_vector(2 downto 0);
        op              : in     vl_logic;
        z               : out    vl_logic_vector;
        status          : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of sig_width : constant is 1;
    attribute mti_svvh_generic_type of exp_width : constant is 1;
    attribute mti_svvh_generic_type of ieee_compliance : constant is 1;
end DW_fp_addsub;
