// Defines timescale for simulation
`timescale 1ns/10ps

// Define our testbench
module block_ram_tb();

    // Internal signals
    wire [7:0]  r_data;

    // Storage elements (set some initial values to 0)
    reg clk = 0;
    reg w_en = 0;
    reg r_en = 0;
    reg [3:0] w_addr;
    reg [3:0] r_addr;
    reg [7:0] w_data;
    integer i;

    // Simulation time: 10000 * 1 ns = 10 uS
    localparam DURATION = 10000;

    //Generate clk signal (~12 Mhz)
    always begin
        #41.67
        clk = ~clk;
    end

    // Instantiate UUT
    block_RAM #(.INIT_FILE("mem_init.txt")) uut (
        .clk(clk),
        .w_en(w_en),
        .r_en(r_en),
        .w_addr(w_addr),
        .r_addr(r_addr),
        .w_data(w_data),
        .r_data(r_data)
    );

    // Run test: write to location and read value back
    initial begin
        
        // Test 1: Read data
        for (i = 0; i < 16; i = i+1) begin
            #(2 * 41.67)
            r_addr = i;
            r_en = 1;
            #(2 * 41.67)
            r_addr = 0;
            r_en = 0;
        end

        // Test 2: Write to addr 0x0f and read it back
        #(2 * 41.67)
        w_addr = 'h0f;
        w_data = 'hA5;
        w_en = 1;
        #(2 * 41.67)
        w_addr = 0;
        w_data = 0;
        w_en = 0;
        r_addr = 'h0f;
        r_en = 1;
        #(2 * 41.67)
        r_addr = 0;
        r_en = 0;
    end

    // Run simulation
    initial begin
        
        // Create simlation output file
        $dumpfile("block_ram_tb.vcd");
        $dumpvars(0, block_ram_tb);

        // Wait for a given amount of time for simulation to complete
        #(DURATION)

        // Notify end of simulation
        $display ("Finished!");
        $finish;
    end
endmodule