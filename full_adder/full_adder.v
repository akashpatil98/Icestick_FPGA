// Full adder with LEDs and buttons
module full_adder(
    //Inputs
    input [2:0]     pmod,

    //Outputs
    output [1:0]    led
);

    //Sum
    assign led[0] = ~pmod[0] ^ ~pmod[1] ^ ~pmod[2];

    //Carry
    assign led[1] = (~pmod[0] & ~pmod[1]) || (~pmod[1] & ~pmod[2]) || (~pmod[2] & ~pmod[0]);

endmodule