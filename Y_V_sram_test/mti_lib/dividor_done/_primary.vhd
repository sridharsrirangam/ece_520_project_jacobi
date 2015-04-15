library verilog;
use verilog.vl_types.all;
entity dividor_done is
    port(
        clock           : in     vl_logic;
        enable          : in     vl_logic;
        reset           : in     vl_logic;
        accum_done      : in     vl_logic;
        dividor_done    : out    vl_logic
    );
end dividor_done;
