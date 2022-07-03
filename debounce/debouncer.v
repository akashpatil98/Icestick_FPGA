// Debouncer for external push-button switches
`default_nettype none
module debouncer (

    // Inputs
    input rst,
    input clk,
    input button,
    
    // Output
    output reg out
);

    // Registers
    reg [15:0] sreg;

    always @(posedge clk or posedge rst) begin
        if (rst == 1'b1) begin
            sreg <= 0;
            out <= 0;
        end else begin
            sreg <= {button, sreg[14:0]};
        end
        if (sreg == 16'hFFFF) begin
            out <= 1'b1;
        end else if (sreg == 16'h0000) begin
            out <= 1'b0;
        end
    end

endmodule