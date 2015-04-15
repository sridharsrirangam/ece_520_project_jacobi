library verilog;
use verilog.vl_types.all;
entity DW_fp_mult_inst is
    generic(
        sig_width       : integer := 17;
        exp_width       : integer := 6;
        ieee_compliance : integer := 1
    );
    port(
        inst_a          : in     vl_logic_vector;
        inst_b          : in     vl_logic_vector;
        z_inst          : out    vl_logic_vector;
        clock           : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of sig_width : constant is 1;
    attribute mti_svvh_generic_type of exp_width : constant is 1;
    attribute mti_svvh_generic_type of ieee_compliance : constant is 1;
end DW_fp_mult_inst;
