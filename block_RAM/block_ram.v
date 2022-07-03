// Inferred Block RAM
`default_nettype none
module block_RAM (
    
    // Inputs
    input               clk,
    input               w_en,
    input               r_en,
    input       [3:0]   w_add,
    input       [3:0]   r_add,
    input       [7:0]   w_data,

    // Output
    output  reg [7:0]   r_data
);

    // Declare memory
    reg [7:0]   mem [15:0];

    // Interface with the memory block
    always @(posedge clk) begin
        
        // write to memory
        if (w_en == 1'b1) begin
            mem[w_add] <= w_data;
        end

        // Read from memory
        if (r_en == 1'b1) begin
            r_data <= mem[r_add];
        end
    end
    
endmodule