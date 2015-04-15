library verilog;
use verilog.vl_types.all;
entity addsub_cplx is
    generic(
        width           : integer := 48;
        msb             : vl_notype;
        lsb             : vl_notype
    );
    port(
        in1             : in     vl_logic_vector;
        in2             : in     vl_logic_vector;
        mode            : in     vl_logic;
        op              : out    vl_logic_vector;
        clock           : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
    attribute mti_svvh_generic_type of msb : constant is 3;
    attribute mti_svvh_generic_type of lsb : constant is 3;
end addsub_cplx;
