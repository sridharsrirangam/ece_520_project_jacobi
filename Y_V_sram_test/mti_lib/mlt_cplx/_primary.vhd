library verilog;
use verilog.vl_types.all;
entity mlt_cplx is
    generic(
        width           : integer := 48;
        msb             : vl_notype;
        lsb             : vl_notype
    );
    port(
        in1             : in     vl_logic_vector(47 downto 0);
        in2             : in     vl_logic_vector(47 downto 0);
        op              : out    vl_logic_vector(47 downto 0);
        clock           : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
    attribute mti_svvh_generic_type of msb : constant is 3;
    attribute mti_svvh_generic_type of lsb : constant is 3;
end mlt_cplx;
