library verilog;
use verilog.vl_types.all;
entity controlCounterIter is
    port(
        reset           : in     vl_logic;
        clock           : in     vl_logic;
        in_accumCalcDoneFlag: in     vl_logic;
        in_enableEntireModule: in     vl_logic;
        op_enableAccumCalc: out    vl_logic;
        op_allItersDoneFlag: out    vl_logic;
        op_control_vsram_section: out    vl_logic;
        op_vsram_read_control: out    vl_logic
    );
end controlCounterIter;
