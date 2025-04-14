module RSA_top (
    input logic clk,
    input logic rst,
    input logic [64:0] message,
    input logic [3:0] p,
    input logic [3:0] q,
    input logic [8:0] e, 

    output logic [64:0] encrypted_message
);

    logic [7:0] n; // Modulus
    assign n = p * q; // Calculate n

    logic [127:0] phi; 
    assign phi = (p - 1) * (q - 1); // Calculate phi(n)

    logic [64:0] message_temp; // Temporary variable for message

    logic [127:0] d; // Private exponent

    d_calc d_calc_inst (
        .e(e),
        .phi(phi),
        .d(d) // d is calculated here
    );

    encrypt encrypt_inst (
        .clk(clk),
        .rst(rst),
        .n(n),
        .e(e),
        .message(message),
        .c(message_temp)
    );

    decrypt decrypt_inst (
        .clk(clk),
        .rst(rst),
        .c(message_temp),
        .d(d), // Assuming d is the same as e for simplicity
        .n(n),
        .m(encrypted_message) // Decrypted message
    );


endmodule