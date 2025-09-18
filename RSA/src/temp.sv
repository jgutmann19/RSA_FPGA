if (e_r == 0) begin
    next_result = result_r;
    next_done = 1; // Done when exponent is 0
    next_state = DONE;
end else begin
    if (e_r[0] == 1) begin                        
        next_modmult_a = result_r;
        next_modmult_b = base_r;
        next_modmult_n = n_r;
        next_modmult_go = 1;

        if (modmult_done == 1'b1) begin
            next_modmult_go = 0;
            next_result = modmult_result;
        end
    end 
    // m = (m * m) % n
    next_modmult_a = base_r;
    next_modmult_b = base_r;
    next_modmult_n = n_r;
    next_modmult_go = 1;

    if (modmult_done == 1'b1) begin
        next_modmult_go = 0;
        next_base = modmult_result;
        next_e = e_r >> 1; // e = e / 2
        next_state = COMPUTE; // Stay in COMPUTE state
    end
end

RESTART: begin
    next_state = START;
    next_done = 0; // Clear done signal for next operation     
end