module d_calc (
    input logic [127:0] e,
    input logic [127:0] phi,
    output logic [127:0] d
);
    logic [127:0] t, new_t; // Temporary variable for calculation
    logic [127:0] r, new_r; // Temporary variable for calculation
    logic [127:0] q;
    logic [127:0] temp; // Temporary variables for calculation

    always_comb begin
        t = '0;
        new_t = 128'd1;
        r = phi;
        new_r = '0;

        while (new_r != 0) begin
            // Calculate quotient
            q = r / new_r;
            temp = new_t;
            new_t = t - q * new_t; // Update new_t
            t = temp; // Store old t

            // Update t and r
            temp = new_r;
            new_r = r - q * new_r; // Update new_r
            r = temp; // Store old r

        end

        // Calculate d
        if (r > 1);
        if (t < 0) begin
            t = t + phi; // Ensure t is positive
        end
        d = t; // Assign d
    end
endmodule