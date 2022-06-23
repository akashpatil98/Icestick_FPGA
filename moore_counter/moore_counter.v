// Moore FSM implementation of Counter
`default_nettype none
module moore_counter (
    
    // Inputs
    input clk,
    input rst_sig,
    input go_sig,

    // Outputs
    output reg done_sig,
    output reg [3:0] led
);

    // States
    localparam STATE_IDLE       = 2'd0;
    localparam STATE_COUNTING   = 2'd1;
    localparam STATE_DONE       = 2'd2;

    // Max count for counter and clock divider
    localparam MAX_CLK_COUNT = 24'd1500000;
    localparam MAX_LED_COUNT = 4'hf;

    // Internal signals
    wire rst;
    wire go;

    // Internal storage elements
    reg         div_clk;
    reg [1:0]   state;
    reg [23:0]  clk_count;

    // Invert active low buttons
    assign rst = ~rst_sig;
    assign go = ~go_sig;

    // Clock divider
    always @ (posedge clk or posedge rst) begin
        if (rst == 1'b1)
        begin
            clk_count <= 24'd0;
        end
        else if (clk_count == MAX_CLK_COUNT)
        begin
            clk_count <= 24'd0;
            div_clk <= ~div_clk;
        end
        else
        begin
            clk_count <= clk_count + 1'b1;
        end
    end

    // State transition logic
    always @ (posedge div_clk or posedge rst) begin
        if (rst == 1'b1)
        begin
            state <= STATE_IDLE;
        end
        else
        begin
            case (state)

                // Wait for go button
                STATE_IDLE: begin
                    if (go == 1'b1)
                    begin
                        state <= STATE_COUNTING;
                    end
                end

                // GO from counting to done if counting reached max
                STATE_COUNTING: begin
                    //led <= led + 1'b1;
                    if (led == MAX_LED_COUNT)
                    begin
                        state <= STATE_DONE;
                    end
                end

                // Spend one clock cycle in done state
                STATE_DONE: begin
                    state <= STATE_IDLE;
                end

                // Go to IDLE state if state is unknown
                default: state <= STATE_IDLE;
            endcase
        end
    end

    // Handle the LED counter
    always @ (posedge div_clk or posedge rst)
    begin
        if (rst == 1'b1)
        begin
            led <= 4'b0;
        end

        else
        begin
            if (state == STATE_COUNTING)
                led <= led + 1'b1;
            else
                led <= 4'd0;
        end
    end

    // Handle done LED
    always @ (*) begin
        if (state == STATE_DONE)
        begin
            done_sig = 1'b1;
        end
        else
            done_sig = 1'b0;
    end

endmodule
