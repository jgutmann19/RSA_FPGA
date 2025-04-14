module decrypt (
    input  logic clk,
    input  logic rst,
    input  logic [32:0] c, // Ciphertext
    input  logic [4:0] d, // Private exponent
    input  logic [7:0] n, // Modulus
    output logic [127:0] m  // Decrypted message
);

    // typedef enum logic [1:0] {
    //     START,
    //     COMPUTE,
    //     RESTART,
    //     XXX = 'x
    // } state_t;
    
    // logic [127:0] m_r, next_m; 
    // logic [127:0] d_r, next_d; // Added to store the exponent
    // state_t state_r, next_state;


    // always_ff @(posedge clk or posedge rst) begin 
    //     if (rst) begin
    //         m_r <= 128'd0; // Reset m_r on reset
    //         d_r <= 128'd0; // Reset d_r on reset
    //         state_r <= START; // Start in START state
    //     end else begin
    //         m_r <= next_m;
    //         d_r <= next_d;
    //         state_r <= next_state;
    //     end
        
    // end
    logic [255:0] temp_m;

    always_comb begin
        temp_m = (c ** d);
        m = temp_m % n;
        // next_state = state_r;
        // next_m = m_r;
        // next_d = d_r; // Initialize next_d to current d_r
        
        // case (state_r)
        //     START: begin
        //         next_m = 128'd1; // Initialize m to 1
        //         next_d = d; // Store the initial value of d
        //         next_state = COMPUTE;
        //     end

        //     COMPUTE: begin
        //         if (d_r > 0) begin
        //             next_m = (m_r * c) % n; // Compute m = c^d mod n
        //             next_d = d_r - 1; // Decrement d
        //         end else begin
        //             next_state = RESTART; // Move to RESTART state when done
        //         end
        //     end

        //     RESTART: begin
        //         next_m = 128'd0; // Reset m to 0
        //         next_state = START; // Go back to START state
        //     end

        //     default: next_state = XXX;
        // endcase

        // m = m_r;
    end

endmodule
