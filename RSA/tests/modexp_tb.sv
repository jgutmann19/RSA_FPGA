`timescale 1ns / 1ps

module modexp_tb #(
    parameter int WIDTH = 16
);

    // Testbench signals
    logic clk;
    logic rst;
    logic go;
    logic [WIDTH-1:0] m;
    logic [WIDTH-1:0] e;
    logic [WIDTH-1:0] n;
    logic [WIDTH-1:0] result;
    logic done;

    // Instantiate the modmult module
    modexp #(
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
        m = 9;
        e = 3;
        n = 55;

        #10;

        go = 1; // Start the operation
        #10 go = 0; // Clear go signal after 10 ns
        
        @(posedge done);
        #10; // Wait a bit after done is asserted
        $display("Test Case 1:");
        $display("m      : %0d", m);
        $display("e      : %0d", e);
        $display("n      : %0d", n);
        $display("Result : %0d", result);
        $stop;

    end
endmodule