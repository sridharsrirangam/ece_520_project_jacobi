/* ******************************************************
 * This module is just made up of wires connecting the
 * inputs of this module to the divider module.
 * 
 * Inputs : 1. 2 x 48 bit inputs to be divided
 *          2. 1 48 bit Output of divider
 *
 * Output:  1. 2 x 48 bit inputs to divider
 *          2. 1 48 bit Output of divider
 *
 *
 * ****************************************************/

module divider_wrap ( input [47:0] in_divider, input [47:0] in_dividend,
                      input [47:0] in_outputOfDivider,

                      output wire [47:0] op_dividerIn1, output wire [47:0] op_dividerIn2,
                      output wire [47:0] op_dividerResult
	   );


/********** Module Logic **************/




assign op_dividerIn1    = in_dividend;
assign op_dividerIn2    = in_divider;

assign op_dividerResult = in_outputOfDivider;
	   
	

endmodule

