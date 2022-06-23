// Module: Custom logic with LEDs
module and_gate (
    // Inputs
    input [1:0]     pmod,

    // Output
    output [2:0]    led
);

wire not_pmod_0;

assign not_pmod_0 = ~pmod[0];
assign led[1:0] =  {2{not_pmod_0}};
assign led[2] = ~pmod[0] & ~pmod[1];

endmodule