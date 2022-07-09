module pwm #(
    
    //Parameters
    parameter WIDTH = 12
)(
    // Inputs
    input clk,          // Clock
    input wstrb,        // Write strobe
    input sel,          // Select (read/write ignored if low)
    input [31:0] wdata, // Data to be written to the driver

    // Outputs
    output [3:0] led    // Output on led
);

    // Internal storage elements
    reg pwm_led = 1'b0;
    reg [WIDTH-1:0] pwm_count = 0;
    reg [WIDTH-1:0] count = 0;

    // Only control the first LED
    assign led[0] = pwm_led;

    // Update PWM duty cycle
    always @(posedge clk) begin

        // If sel is high, record duty cycle count on strobe
        if(sel && wstrb) begin
            pwm_count <= wdata[WIDTH-1:0];
            count <= 0;

        // Otherwise, continuously count and flash LED as necessary
        end else begin
            count <= count + 1;
            if (count < pwm_count) begin
                pwm_led <= 1'b1;
            end else begin
                pwm_led <= 1'b0;
            end
        end   
    end
endmodule