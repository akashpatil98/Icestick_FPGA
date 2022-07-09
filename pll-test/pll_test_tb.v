`timescale 1ns/10ps
module pll_test_tb ();

    // Internal signals
    wire clk;

    // Storage elements
    reg ref_clk = 0;

    // Simulation time: 10000 * 1 ns = 10us
    localparam DURATION = 10000;

    // Generate ref_clk signal (~12 MHz)
    always begin
        #41.67
        ref_clk = ~ref_clk;
    end

    // Instantiate UUT
    pll_test pll (
        .ref_clk(ref_clk),
        .clk(clk)
    );

    // Run simulation
    initial begin
        
        // Create simulation output file
        $dumpfile("pll_test_tb.vcd");
        $dumpvars(0, pll_test_tb);

        // Wait for simulation to end
        #(DURATION)

        // Notify the end of simulation
        $display("Finished!");
        $finish;
    end

endmodule