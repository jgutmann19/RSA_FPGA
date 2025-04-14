module encrypt (
    input logic clk,
    input logic rst,
    input logic [7:0] n,
    input logic [8:0] e,
    input logic [64:0] message,
    output logic [32:0] c 
);
    // typedef enum logic [1:0] {
    //     START,
    //     COMPUTE,
    //     RESTART,
    //     XXX = 'x
    // } state_t;

    // logic [127:0] c_r, next_c;
    // logic [127:0] e_r, next_e; // Added to store the exponent
    // state_t state_r, next_state;
    

    // always_ff @(posedge clk or posedge rst) begin 
    //     if (rst) begin
    //         c_r <= 0; // Reset c_r on reset
    //         e_r <= 0; // Reset e_r on reset
    //         state_r <= START; // Start in START state
    //     end else begin
    //         c_r <= next_c;
    //         e_r <= next_e;
    //         state_r <= next_state;
    //     end
        
    // end
    logic [255:0] temp_c; // Register to hold the encrypted message
    // Calculate c = m^e mod n
    always_comb begin
        temp_c = (message ** e); 
        c = temp_c % n; // Assign the result to c
        // Compute c = m^e mod n
        // next_state = state_r;
        // next_c = c_r;
        // next_e = e_r; // Initialize next_e to current e_r

        // case (state_r)
        //     START: begin
        //         next_c = 1; // Initialize c to 1
        //         next_e = e; // Store the initial value of e
        //         next_state = COMPUTE;
        //     end
        //     COMPUTE: begin
        //         next_c = (message ** e_r) % n; // Compute c = m^e mod n
        //         next_state = RESTART; // Move to RESTART state when done
        //     end
        //     RESTART: begin
        //         next_c = 0; // Reset c to 0
        //         next_state = START; // Go back to START state
        //     end

        //     default: next_state = XXX;


        // endcase
        
        // c = c_r;
    end

endmodule