library verilog;
use verilog.vl_types.all;
entity roundRobin is
    port(
        reset           : in     vl_logic;
        clock           : in     vl_logic;
        soft_rst        : in     vl_logic;
        in_updateYCtrlPathDoneFlag: in     vl_logic;
        in_updateYwriteDoneFlag: in     vl_logic;
        op_updateYmoduleEnable: out    vl_logic;
        op_writeYvalEnable: out    vl_logic;
        op_integrateModEnable: out    vl_logic
    );
end roundRobin;
