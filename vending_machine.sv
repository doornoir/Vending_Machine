/*****************************************************************************
* Project: Vending Machine FSM
* Authors: Nour Alzahraa Alqattan, Alan Wong, Ayush
*
* Description:
* Finite State Machine for a vending machine that accepts
* nickels, dimes, and quarters. The machine tracks the
* amount inserted and dispenses an item when 100 cents
* has been reached and the buy button is pressed.
*****************************************************************************/

module vending(
    input logic clk,
    input logic reset,
    input logic nickel,
    input logic dime,
    input logic quarter,
    input logic buy,
    output logic dispense,
    output logic [7:0] total
);

    // FSM states represent the current amount of money inserted
    typedef enum logic [4:0] {
        S0, S5, S10, S15, S20, S25,
        S30, S35, S40, S45, S50,
        S55, S60, S65, S70, S75,
        S80, S85, S90, S95, S100
    } state_t;

    // Current state and next state variables
    state_t current_state;
    state_t next_state;

    /*************************************************************
    * State Register
    * Updates current state on the rising edge of the clock.
    * Reset returns machine to the starting state.
    *************************************************************/
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    /*************************************************************
    * Next State Logic
    * Determines where the FSM should move next based on
    * inserted coin values.
    *************************************************************/
    always_comb begin

        // Stay in the current state unless an input changes it
        next_state = current_state;

        case (current_state)

            // Current total = 0 cents
            S0: begin
                if (nickel)
                    next_state = S5;
                else if (dime)
                    next_state = S10;
                else if (quarter)
                    next_state = S25;
            end

            // Current total = 5 cents
            S5: begin
                if (nickel)
                    next_state = S10;
                else if (dime)
                    next_state = S15;
                else if (quarter)
                    next_state = S30;
            end

            // Current total = 10 cents
            S10: begin
                if (nickel)
                    next_state = S15;
                else if (dime)
                    next_state = S20;
                else if (quarter)
                    next_state = S35;
            end

            // Continue pattern for remaining states...
