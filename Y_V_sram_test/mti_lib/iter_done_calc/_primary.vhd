library verilog;
use verilog.vl_types.all;
entity iter_done_calc is
    port(
        dividor_done    : in     vl_logic;
        Y_eof_reg       : in     vl_logic;
        iter_done       : out    vl_logic;
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        enable          : in     vl_logic
    );
end iter_done_calc;
