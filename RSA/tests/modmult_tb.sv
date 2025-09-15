`timescale 1ns / 1ps

module modmult_tb #(
    parameter int WIDTH = 16
);

    // Testbench signals
    logic clk;
    logic rst;
    logic go;
    logic [WIDTH-1:0] a;
    logic [WIDTH-1:0] b;
    logic [WIDTH-1:0] n;
    logic [WIDTH-1:0] result;
    logic done;

    // Instantiate the modmult module
    modmult #(
        WIDTH
    ) DUT (.*);

    // Clock generation: 100 MHz clock (10 ns period)
    initial begin
        clk = 0;
        rst = 1; // Assert reset
        forever #5 clk = ~clk; // Toggle clock every 5 ns
    end

    initial begin
        #20 rst = 0; // Deassert reset after 5 ns
        

        // Test case 1
        a = 16'd13;
        b = 16'd11;
        n = 16'd17; // A large prime modulus

        #10;

        go = 1; // Start the operation
        #10 go = 0; // Clear go signal after 10 ns
        
        @(posedge done);
        $display("Test Case 1:");
        $display("a      : %0d", a);
        $display("b      : %0d", b);
        $display("n      : %0d", n);
        $display("Result : %0d", result);
        $finish;

    end
endmodule