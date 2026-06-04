/*****************************************************************************
* Project: Vending Machine FSM
* Authors: Nour, Alan, Ayush
* Course: ECE 272
*
* Description:
* Implements a finite state machine for a vending machine.
* Tracks money inserted and dispenses an item when enough
* money has been entered.
* - trying extra credit to make it a seven segment display
*****************************************************************************/

module vending(
    input logic clk,
    input logic reset,
    input logic nickel,
    input logic dime,
    input logic quarter,
    input logic buy,
    output logic dispense
);

    // States represent the current amount inserted
    typedef enum logic [2:0] {
        S0,
        S5,
        S10,
        S15,
        S20,
        S25
    } state_t;

    // Current and next state variables
    state_t current_state;
    state_t next_state;

    // State register updates on rising clock edge
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

	 
	 // Combinational logic determines the next state
	always_comb begin
		 next_state = current_state;

		 case (current_state)

			  S0: begin
					if (nickel)
						 next_state = S5;
					else if (dime)
						 next_state = S10;
					else if (quarter)
						 next_state = S25;
			  end
			  
			  S5: begin
            if (nickel)
                next_state = S10;
            else if (dime)
                next_state = S15;
            else if (quarter)
                next_state = S25;
        end
		  
			  S10: begin
				 if (nickel)
					  next_state = S15;
				 else if (dime)
					  next_state = S20;
				 else if (quarter)
					  next_state = S25;
			end

		 endcase
		 
		 // Controls vending output
			always_comb begin
				 dispense = 0;

				 if (current_state == S25 && buy)
					  dispense = 1;
			end
	end
endmodule
