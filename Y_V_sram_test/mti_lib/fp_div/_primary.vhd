library verilog;
use verilog.vl_types.all;
entity fp_div is
    generic(
        sig_width       : integer := 17;
        exp_width       : integer := 6;
        ieee_compliance : integer := 0
    );
    port(
        clock           : in     vl_logic;
        inst_a          : in     vl_logic_vector;
        inst_b          : in     vl_logic_vector;
        inst_rnd        : in     vl_logic_vector(2 downto 0);
        z_inst          : out    vl_logic_vector;
        status_inst     : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of sig_width : constant is 1;
    attribute mti_svvh_generic_type of exp_width : constant is 1;
    attribute mti_svvh_generic_type of ieee_compliance : constant is 1;
end fp_div;
