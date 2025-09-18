// // This module computes m^e % n
module modexp #(
    parameter int WIDTH
)(
    input logic clk,
    input logic rst,
    input logic go,
    input logic [WIDTH-1:0] m,
    input logic [WIDTH-1:0] e,
    input logic [WIDTH-1:0] n,
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
    logic [WIDTH-1:0] m_r, next_m;
    logic [WIDTH-1:0] e_r, next_e;
    logic [WIDTH-1:0] n_r, next_n;
    logic [WIDTH-1:0] result_r, next_result;

    // modmult instance signals
    logic modmult_go, next_modmult_go;
    logic [WIDTH-1:0] modmult_a, next_modmult_a;
    logic [WIDTH-1:0] modmult_b, next_modmult_b;
    logic [WIDTH-1:0] modmult_n, next_modmult_n;
    logic [WIDTH-1:0] modmult_result;
    logic modmult_done;
    logic [WIDTH-1:0] base_r, next_base;

    assign result = result_r;
    assign done = done_r;

    // Instantiate modmult 
    // Instantiate the modmult module
    modmult #(
        WIDTH
    ) DUT (
        .clk(clk),
        .rst(rst),
        .go(modmult_go),
        .a(modmult_a),
        .b(modmult_b),
        .n(modmult_n),
        .result(modmult_result),
        .done(modmult_done)
    );

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            state_r <= START;
            m_r <= '0;
            e_r <= '0;
            n_r <= '0;
            result_r <= '0;
            done_r <= '0;

            modmult_a <= '0;
            modmult_b <= '0;
            modmult_n <= '0;
            modmult_go <= 0;
            base_r <= '0;
        end else begin
            state_r <= next_state;
            m_r <= next_m;
            e_r <= next_e;
            n_r <= next_n;
            result_r <= next_result;
            done_r <= next_done;

            modmult_a <= next_modmult_a;
            modmult_b <= next_modmult_b;
            modmult_n <= next_modmult_n;
            modmult_go <= next_modmult_go;
            base_r <= next_base;
        end
    end

    always_comb begin
        // Default assignments
        next_state = state_r;
        next_m = m_r;
        next_e = e_r;
        next_n = n_r;
        next_result = result_r;
        next_done = done_r; 

        // Default modmult signals
        next_modmult_go = '0;
        next_modmult_a = '0;
        next_modmult_b = '0;
        next_modmult_n = '0;
        next_base = base_r;

        case (state_r)
            START: begin
                next_done = 0;  
                if (go) begin
                    next_m = m;
                    next_e = e;
                    next_n = n;
                    next_result = 1; // Initialize result to 1
                    next_base = m % n;
                    next_state = CHECK;
                end
            end

            CHECK: begin
                if (e_r == 0) begin
                    next_result = result_r;
                    next_done = 1; // Done when exponent is 0
                    next_state = DONE;
                end else begin
                    if (e_r[0] == 1) begin                        
                        next_state = EXP_RES;
                    end 
                    else begin
                        next_state = EXP_BASE;
                    end
                end
            end

            EXP_RES: begin
                // result = (result * base) % n
                next_modmult_a = result_r;
                next_modmult_b = base_r;
                next_modmult_n = n_r;
                next_modmult_go = 1;

                if (modmult_done == 1'b1) begin
                    next_modmult_go = 0;
                    next_result = modmult_result;
                    next_state = EXP_BASE; // Move to EXP_BASE state
                end
            end

            EXP_BASE: begin
                // base = (base * base) % n
                next_modmult_a = base_r;
                next_modmult_b = base_r;
                next_modmult_n = n_r;
                next_modmult_go = 1;

                if (modmult_done == 1'b1) begin
                    next_modmult_go = 0;
                    next_base = modmult_result;
                    next_e = e_r >> 1; // e = e / 2
                    next_state = CHECK; // Go back to CHECK state
                end
            end

            DONE: begin
                next_state = START; // Go to START on new go signal
                next_done = 0; // Clear done signal for next operation     
            end
            

        endcase
    end


endmodule