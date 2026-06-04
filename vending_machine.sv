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

    typedef enum logic [4:0] {
        S0, S5, S10, S15, S20, S25,
        S30, S35, S40, S45, S50,
        S55, S60, S65, S70, S75,
        S80, S85, S90, S95, S100
    } state_t;

    state_t current_state;
    state_t next_state;

    // Updates current state on each clock edge
    always_ff @(posedge clk) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Determines next state based on inserted coin
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

            S15: begin
                if (nickel)
                    next_state = S20;
                else if (dime)
                    next_state = S25;
                else if (quarter)
                    next_state = S40;
            end

            S20: begin
                if (nickel)
                    next_state = S25;
                else if (dime)
                    next_state = S30;
                else if (quarter)
                    next_state = S45;
            end

            S25: begin
                if (nickel)
                    next_state = S30;
                else if (dime)
                    next_state = S35;
                else if (quarter)
                    next_state = S50;
            end

            S30: begin
                if (nickel)
                    next_state = S35;
                else if (dime)
                    next_state = S40;
                else if (quarter)
                    next_state = S55;
            end

            S35: begin
                if (nickel)
                    next_state = S40;
                else if (dime)
                    next_state = S45;
                else if (quarter)
                    next_state = S60;
            end

            S40: begin
                if (nickel)
                    next_state = S45;
                else if (dime)
                    next_state = S50;
                else if (quarter)
                    next_state = S65;
            end

            S45: begin
                if (nickel)
                    next_state = S50;
                else if (dime)
                    next_state = S55;
                else if (quarter)
                    next_state = S70;
            end

            S50: begin
                if (nickel)
                    next_state = S55;
                else if (dime)
                    next_state = S60;
                else if (quarter)
                    next_state = S75;
            end

            S55: begin
                if (nickel)
                    next_state = S60;
                else if (dime)
                    next_state = S65;
                else if (quarter)
                    next_state = S80;
            end

            S60: begin
                if (nickel)
                    next_state = S65;
                else if (dime)
                    next_state = S70;
                else if (quarter)
                    next_state = S85;
            end

            S65: begin
                if (nickel)
                    next_state = S70;
                else if (dime)
                    next_state = S75;
                else if (quarter)
                    next_state = S90;
            end

            S70: begin
                if (nickel)
                    next_state = S75;
                else if (dime)
                    next_state = S80;
                else if (quarter)
                    next_state = S95;
            end

            S75: begin
                if (nickel)
                    next_state = S80;
                else if (dime)
                    next_state = S85;
                else if (quarter)
                    next_state = S100;
            end

            S80: begin
                if (nickel)
                    next_state = S85;
                else if (dime)
                    next_state = S90;
                else if (quarter)
                    next_state = S100;
            end

            S85: begin
                if (nickel)
                    next_state = S90;
                else if (dime)
                    next_state = S95;
                else if (quarter)
                    next_state = S100;
            end

            S90: begin
                if (nickel)
                    next_state = S95;
                else if (dime || quarter)
                    next_state = S100;
            end

            S95: begin
                if (nickel || dime || quarter)
                    next_state = S100;
            end

            S100: begin
                if (buy)
                    next_state = S0;
            end
        endcase
    end

    // Output logic for display total and dispense signal
    always_comb begin
        dispense = 0;
        total = 0;

        case (current_state)
            S0: total = 0;
            S5: total = 5;
            S10: total = 10;
            S15: total = 15;
            S20: total = 20;
            S25: total = 25;
            S30: total = 30;
            S35: total = 35;
            S40: total = 40;
            S45: total = 45;
            S50: total = 50;
            S55: total = 55;
            S60: total = 60;
            S65: total = 65;
            S70: total = 70;
            S75: total = 75;
            S80: total = 80;
            S85: total = 85;
            S90: total = 90;
            S95: total = 95;
            S100: total = 100;
        endcase

        if (current_state == S100 && buy)
            dispense = 1;
    end

endmodule
