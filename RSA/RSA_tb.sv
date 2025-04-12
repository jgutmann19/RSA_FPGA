`timescale 1ns / 1ps

module RSA_tb;

    // Declare testbench signals
    logic clk;
    logic rst;
    logic [64:0] message;
    logic [3:0]  p, q;
    logic [8:0] e; // Public exponent
    logic [64:0] encrypted_message;

    // Instantiate the RSA_top module
    RSA_top uut (
        .clk(clk),
        .rst(rst),
        .message(message),
        .p(p),
        .q(q),
        .e(e), 
        .encrypted_message(encrypted_message)
    );

    // Clock generation: 100 MHz clock (10 ns period)
    initial begin
        clk = 0;
        rst = 1; // Assert reset
        forever #5 clk = ~clk; // Toggle clock every 5 ns
        
    end

    initial begin
        #5 rst = 0; // Deassert reset after 5 ns
        // Initialize inputs
        message = 128'd81799572057445;   // "Hello, I'm Yoni"
        p = 3;  // example prime p
        q = 7;  // example prime q
        e = 5; // example public exponent e

        // Wait for processing
        #50;

        // Display results
        $display("Input Message        : %0s", message);
        $display("p                    : %0d", p);
        $display("q                    : %0d", q);
        $display("Public Exponent (e)  : %0d", e);
        $display("Modulus (n)          : %0d", p * q); // Display modulus n
        $display("Encrypted Message    : %0h", encrypted_message); // Use %0h for better encrypted message display

        // Finish simulation
        #10;
        // $finish;
    end

endmodule
