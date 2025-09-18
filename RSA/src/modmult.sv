// This module computes (a * b) % n 
module modmult #(
    parameter int WIDTH
) (
    input logic clk,
    input logic rst,
    input logic go,
    input logic [WIDTH-1:0] a,
    input logic [WIDTH-1:0] b,
    input logic [WIDTH-1:0] n,
    output logic [WIDTH-1:0] result,
    output logic done
);
    typedef enum logic [1:0] {
        START,
        COMPUTE,
        RESTART,
        XXX = 'x
    } state_t;  

    // Registers
    state_t state_r, next_state;
    logic done_r, next_done;
    logic [WIDTH-1:0] a_r, next_a;
    logic [WIDTH-1:0] b_r, next_b;
    logic [WIDTH-1:0] n_r, next_n;
    logic [WIDTH-1:0] result_r, next_result;

    assign result = result_r;
    assign done = done_r;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state_r <= START;
            a_r <= '0;
            b_r <= '0;
            n_r <= '0;
            result_r <= '0;
            done_r <= '0;
        end else begin
            state_r <= next_state;
            a_r <= next_a;
            b_r <= next_b;
            n_r <= next_n;
            result_r <= next_result;
            done_r <= next_done;
        end
    end

    always_comb begin
        // Default assignments
        next_state = state_r;
        next_a = a_r;
        next_b = b_r;
        next_n = n_r;
        next_result = result_r;
        next_done = done_r; 

        case (state_r)
            START: begin
                next_done = 0; // Clear done signal just in case
                if (go) begin
                    next_a = a % n;
                    next_b = b;
                    next_n = n;
                    next_result = 1'b0; // Initialize result to 0
                    next_state = COMPUTE;
                end
            end
            COMPUTE: begin
                if (b_r == 0) begin
                    next_result = result_r; // Final reduction mod n
                    next_done = 1'b1; // Indicate done
                    next_state = RESTART;
                end else begin
                    if (b_r[0] == 1) begin
                        next_result = (result_r + a_r) % n_r; // Add a to result if LSB of b is 1
                    end
                    next_a = (a_r << 1) % n_r; // Double a and reduce mod n
                    next_b = b_r >> 1; // Shift b right by 1
                end
            end
            RESTART: begin
                next_done = 0; // Clear done signal
                next_state = START; // Go back to START state
            end
            
        endcase
    end

endmodule