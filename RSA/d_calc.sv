module d_calc (
    input logic [8:0] e,
    input logic [127:0] phi,
    output logic [127:0] d
);
    // typedef enum logic [1:0] {
    //     START,
    //     COMPUTE,
    //     RESTART,
    //     XXX = 'x
    // } state_t;

    
    
    // // Registers
    // state_t state_r, next_state;

    // logic [127:0] t_r, next_t;
    // logic [127:0] new_t_r, next_new_t;
    // logic [127:0] r_r, next_r;
    // logic [127:0] new_r_r, next_new_r;
    // logic [127:0] temp_r, next_temp;

    // Wires
    // logic [127:0] q;


    // always_ff @(posedge clk or posedge rst) begin
    //     if (rst) begin
    //         state_r <= IDLE;
    //         t_r <= '0;
    //         new_t_r <= '0;
    //         r_r <= '0;
    //         new_r <= '0;
    //         temp_r <= '0;
    //     end else begin
    //         state_r <= next_state;
    //     end
    // end

    always_comb begin
        // d = e^-1 mod phi
        d = 1 / ($exp(1) % phi); // Placeholder for the actual calculation

        // t = '0;
        // new_t = 128'd1;
        // r = phi;
        // new_r = '0;

        // while (new_r != 0) begin
        //     // Calculate quotient
        //     q = r / new_r;
        //     temp = new_t;
        //     new_t = t - q * new_t; // Update new_t
        //     t = temp; // Store old t

        //     // Update t and r
        //     temp = new_r;
        //     new_r = r - q * new_r; // Update new_r
        //     r = temp; // Store old r

        // end

        // // Calculate d
        // if (r > 1);
        // if (t < 0) begin
        //     t = t + phi; // Ensure t is positive
        // end
        // d = t; // Assign d
        // case (state_r) 
        //     START: begin
        //         next_t = 0;
        //         next_new_t = 1;
        //         next_r = phi;
        //         next_new_r = 0;

        //         next_state = COMPUTE;
        //     end

        //     COMPUTE: begin
        //         if (new_r_r != 0) begin
        //             q = r_r / new_r_r;
        //             // next_temp = ;
        //         end else begin
        //             next_state = RESTART;
        //         end
        //     end

        //     RESTART: begin

        //     end

        // endcase
    end
endmodule