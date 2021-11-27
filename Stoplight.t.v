//==============================================================================
// Stoplight Testbench Module for Lab 4
//==============================================================================
`timescale 1ns/100ps

`include "Stoplight.v"

module StoplightTest;

	// Local Vars
	reg clk = 1;
	reg rst = 0;
	reg car = 0;
	wire [2:0] lp, lw;

	// Light Colors
	localparam GRN = 3'b100;
	localparam YLW = 3'b010;
	localparam RED = 3'b001;

	// VCD Dump
	initial begin
		$dumpfile("StoplightTest.vcd");
		$dumpvars;
	end

	// Stoplight Module
	Stoplight light(
		.clk        (clk),
		.rst        (rst),
		.car_present(car),
		.light_pros (lp),
		.light_wash (lw)
	);

	// Clock
	always begin
		#2.5 clk = ~clk;
	end

	// Main Test Logic
	initial begin
		// Write your set of test cases here
		#1
		rst = 1;
		#5 // t = 6
		rst = 0;
		#1
		if (lp !== RED || lw !== GRN) begin
			$display("Error at time %t", $time);
		end
		#34 // t = 41
		car = 1;
		#1 
		if (lp !== RED || lw !== GRN) begin
			$display("Error at time %t", $time);
		end
		#4 // t = 46
		#1
		if (lp !== RED || lw !== YLW) begin
			$display("Error at time %t", $time);
		end
		#4 // t = 51
		car = 0;
		#1
		if (lp !== GRN || lw !== RED) begin
			$display("Error at time %t", $time);
		end
		#14 // t = 66
		car = 1;
		#1
		if (lp !== GRN || lw !== RED) begin
			$display("Error at time %t", $time);
		end
		#4 // t = 71
		#1
		if (lp !== YLW || lw !== RED) begin
			$display("Error at time %t", $time);
		end
		#4 // t = 76
		#1 
		if (lp !== RED || lw !== GRN) begin
			$display("Error at time %t", $time);
		end
		#9 // t = 86
		car = 0;
		#1 
		if (lp !== RED || lw !== GRN) begin
			$display("Error at time %t", $time);
		end
		#19 // t = 106
		car = 1;
		#1
		if (lp !== RED || lw !== GRN) begin
			$display("Error at time %t", $time);
		end
		#9 // t = 116
		car = 0;
		#1
		if (lp !== GRN || lw !== RED) begin
			$display("Error at time %t", $time);
		end
		#14 // t = 131
		car = 1;
		#1
		if (lp !== GRN || lw !== RED) begin
			$display("Error at time %t", $time);
		end
		#4 // t = 136
		car = 0;
		#1
		if (lp !== YLW || lw !== RED) begin
			$display("Error at time %t", $time);
		end
		#3 // t = 140
		$finish;
	end

endmodule

