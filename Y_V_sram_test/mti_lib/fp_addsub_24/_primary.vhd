library verilog;
use verilog.vl_types.all;
entity fp_addsub_24 is
    generic(
        sig_width       : integer := 17;
        exp_width       : integer := 6;
        ieee_compliance : integer := 1
    );
    port(
        in1             : in     vl_logic_vector;
        in2             : in     vl_logic_vector;
        mode            : in     vl_logic;
        opt             : out    vl_logic_vector(23 downto 0);
        clock           : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of sig_width : constant is 1;
    attribute mti_svvh_generic_type of exp_width : constant is 1;
    attribute mti_svvh_generic_type of ieee_compliance : constant is 1;
end fp_addsub_24;
