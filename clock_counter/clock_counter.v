// Counter using clock and button reset
`default_nettype none
module clock_counter(
    // Inputs
    input pmod_0,
    input clk,

    // Outputs
    output reg [3:0] led
);
    wire rst;
    wire one_hz;
    reg [23:0] divider;

    // Reset is the inverse of the first button
    assign rst = ~pmod_0;

    // Count up on the 1 Hz divided clock signal or reset on push button
    always @ (posedge one_hz or posedge rst)
    begin
        if (rst == 1'b1)
        begin
            led <= 4'b0;
        end
        else
        begin
            led <= led + 1'b1;
        end
    end

    // Clock divider for 12 Mhz clock with reset. Output is 1 Hz signal. 
    always @ (posedge clk or posedge rst)
    begin
        if (rst == 1'b1)
        begin
            divider <= 24'b0;
            one_hz <= 1'b0;
        end
        else if (divider == 24'd12000000)
        begin
            one_hz <= 1'b1;
            divider <= 24'b0;
        end
        else
        begin
            divider <= divider + 1'b1;
            one_hz <= 1'b0;
        end
    end

endmodule