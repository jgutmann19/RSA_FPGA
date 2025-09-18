// This module computes e^-1 mod phi using the Extended Euclidean Algorithm
module modexp #(
    parameter int WIDTH
)(
    input logic clk,
    input logic rst,
    input logic go,
    input logic [WIDTH-1:0] e,
    input logic [WIDTH-1:0] phi,
    output logic [WIDTH-1:0] result,
    output logic done
);
    typedef enum logic [2:0] {
        START,
        CHECK,
        EXP_RES,
        EXP_BASE,
        DONE,
        XXX = 'x
    } state_t;

    // Registers
    state_t state_r, next_state;
    logic done_r, next_done;
    logic [WIDTH-1:0] e_r, next_e;
    logic [WIDTH-1:0] phi_r, next_phi;
    logic [WIDTH-1:0] result_r, next_result;

    // internal signals
    logic [WIDTH-1:0] t_r, next_t;
    logic [WIDTH-1:0] r_r, next_r;
    logic [WIDTH-1:0] new_t_r, next_new_t;
    logic [WIDTH-1:0] new_r_r, next_new_r;

    assign result = result_r;
    assign done = done_r;

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state_r <= START;
            result_r <= '0;
            done_r <= '0;
            e_r <= '0;
            phi_r <= '0;

            t_r <= '0;
            r_r <= '0;
            new_t_r <= '0;
            new_r_r <= '0;
        end else begin
            state_r <= next_state;
            result_r <= next_result;
            done_r <= next_done;
            e_r <= next_e;
            phi_r <= next_phi;

            t_r <= next_t;
            r_r <= next_r;
            new_t_r <= next_new_t;
            new_r_r <= next_new_r;
        end
    end

    always_comb begin
        // Default assignments
        next_state = state_r;
        next_result = result_r;
        next_done = done_r; 
        next_e = e_r;
        next_phi = phi_r;
        
        // Default internal signals
        next_t = t_r;
        next_r = r_r;
        next_new_t = new_t_r;
        next_new_r = new_r_r;

        case (state_r)
            
            

        endcase
    end


endmodule