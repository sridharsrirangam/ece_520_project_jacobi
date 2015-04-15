library verilog;
use verilog.vl_types.all;
entity counterMod is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        countEN         : in     vl_logic;
        op_done         : out    vl_logic
    );
end counterMod;
