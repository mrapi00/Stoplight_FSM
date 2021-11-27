//==============================================================================
// Stoplight Module for Lab 4
//
// Note on lights:
// 	Each bit represents the on/off signal for a light.
// 	Bit | Light
// 	------------
// 	0   | Red
// 	1   | Yellow
// 	2   | Green
//==============================================================================

module Stoplight(
	input            clk,         // Clock signal
	input            rst,         // Reset signal for FSM
	input            car_present, // Is there a car on Prospect?
	output reg [2:0] light_pros,  // Prospect Avenue Light
	output reg [2:0] light_wash   // Washington Road Light
);

	// Declare Local Vars Here
	reg [3:0] state;
	reg [3:0] next_state;
	// ...

	// Declare State Names Here
	localparam INIT = 4'd0;
	localparam WCYCLE1 = 4'd1;
	localparam WCYCLE2 = 4'd2;
	localparam WCYCLE3 = 4'd3;
	localparam WCYCLE4 = 4'd4;
	localparam W_to_P = 4'd5;
	localparam PCYCLE1 = 4'd6;
	localparam PCYCLE2 = 4'd7;
	localparam PCYCLE3 = 4'd8;
	localparam PCYCLE4 = 4'd9;
	localparam P_to_W = 4'd10;

	// Light Colors
	localparam RED = 3'b001;
	localparam YLW = 3'b010;
	localparam GRN = 3'b100;

	// Output Combinational Logic
	always @( * ) begin
		light_pros = 3'b000;
		light_wash = 3'b000;

		if (state == INIT) begin
			light_wash = GRN;
			light_pros = RED;
		end
		// Write your output logic here
		else if (state == WCYCLE1 || state == WCYCLE2 || state == WCYCLE3 || state == WCYCLE4) begin
			light_wash = GRN;
			light_pros = RED;
		end

		else if (state == PCYCLE1 || state == PCYCLE2 || state == PCYCLE3 || state == PCYCLE4) begin
			light_wash = RED;
			light_pros = GRN;
		end

		else if (state == W_to_P) begin
			light_wash = YLW;
			light_pros = RED;
		end

		else if (state == P_to_W) begin
			light_wash = RED;
			light_pros = YLW;
		end
	end

	// Next State Combinational Logic
	always @( * ) begin
		// Write your Next State Logic Here
		next_state = state; // avoid implicit latching
		if (state == INIT) begin
			next_state = WCYCLE2;
		end
		else if (state == WCYCLE2) begin
			next_state = WCYCLE3;
		end
		else if (state == WCYCLE3) begin
			next_state = WCYCLE4;
		end
		else if (state == WCYCLE4) begin
			if (car_present) next_state = W_to_P;
			else next_state = WCYCLE4;
		end
		else if (state == W_to_P) begin
			next_state = PCYCLE1;
		end
		else if (state == PCYCLE1) begin
			next_state = PCYCLE2;
		end
		else if (state == PCYCLE2) begin
			next_state = PCYCLE3;
		end
		else if (state == PCYCLE3) begin
			next_state = PCYCLE4;
		end
		else if (state == PCYCLE4) begin
			next_state = P_to_W;
		end
		else if (state == P_to_W) begin
			next_state = WCYCLE1;
		end
		else if (state == WCYCLE1) begin
			next_state = WCYCLE2;
		end
	end

	// State Update Sequential Logic
	always @(posedge clk) begin
		if (rst) begin
			// Update state to reset state
			state <= INIT;
		end
		else begin
			// Update state to next state
			state <= next_state;
		end
	end

endmodule
