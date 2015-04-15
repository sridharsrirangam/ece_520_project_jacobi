library verilog;
use verilog.vl_types.all;
entity tb2 is
    generic(
        CLKPERIOD       : integer := 50
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of CLKPERIOD : constant is 1;
end tb2;
