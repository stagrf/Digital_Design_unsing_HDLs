module LS161a(
    input [3:0] D,        // Parallel Input
    input CLK,            // Clock
    input CLR_n,          // Active Low Asynchronous Reset
    input LOAD_n,         // Enable Parallel Input
    input ENP,            // Count Enable Parallel
    input ENT,            // Count Enable Trickle
    output reg [3:0] Q,   // Parallel Output 	
    output RCO            // Ripple Carry Output (Terminal Count)
); 
    reg RCO_reg = 1'b0;
    always @(posedge CLK or negedge CLR_n) begin
        if (!CLR_n) begin
            Q <= 4'b0000; // Asynchronous reset
        end else if (LOAD_n == 0 && CLR_n == 1) begin
            Q <= D;       // Load parallel data
        end else if (ENP && ENT) begin
            Q <= Q + 1;
            if( Q == 4'b1111) begin
                Q <= 4'b0000;
                RCO_reg <= 1'b1;
            end else begin
                RCO_reg <= 1'b0;
            end
        end
    end
    assign RCO = RCO_reg;
endmodule
