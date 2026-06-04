/*****************************************************************************
* Project: Vending Machine FSM
* Authors: Nour Alzahraa Alqattan, Alan Wong, Ayush
*
* Description:
* Finite State Machine for a vending machine that accepts
* nickels, dimes, and quarters. The machine tracks the
* amount inserted and dispenses an item when 100 cents
* has been reached.
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

    // States represent amount inserted
    typedef enum logic [4:0] {
        S0, S5, S10, S15, S20, S25,
        S30, S35, S40, S45, S50,
        S55, S60, S65, S70, S75,
        S80, S85, S90, S95, S100
    } state_t;

    state_t current_state;
    state_t next_state;

    // State register
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Next-state logic
    always_comb begin

        next_state = current_state;

        case(current_state)

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
                    next_state = S30;
            end

            S10: begin
                if (nickel)
                    next_state = S15;
                else if (dime)
                    next_state = S20;
                else if (quarter)
                    next_state = S35;
            end

            // Remaining states follow same pattern
            // S15 -> S100

        endcase
    end

    // Output logic
    always_comb begin

        dispense = 0;
        total = 0;

        case(current_state)
            S0: total = 0;
            S5: total = 5;
            S10: total = 10;
        endcase

        if(current_state == S100 && buy)
            dispense = 1;
    end

endmodule
