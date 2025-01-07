module FSM(
  input In1,
  input RST,
  input CLK, 
  output reg Out1
);
  localparam A  = 2'b00,
            B = 2'b01,
            C  = 2'b10;
  reg [1:0] state, next_state;
  reg out_reg;
  
  always @(posedge CLK or posedge RST) begin
    if (RST) begin 
        state <= A;
        Out1 <= 1'b0;
    end else begin
        state <= next_state;
        Out1 <= out_reg;
    end
  end

  always @ (state) begin
    case (state) 
      A: begin
        if(In1) begin
          next_state <= B;
          out_reg <= 1'b0;
        end else begin 
          next_state <= A;
          out_reg <= 1'b0;
        end
      end
      B: begin
        if(In1) begin
          next_state <= B;
          out_reg <= 1'b0;
        end else begin 
          next_state <= C;
          out_reg <= 1'b1;
        end
      end
      C: begin
        if(In1) begin
          next_state <= A;
          out_reg <= 1'b0;
        end else begin 
          next_state <= C;
          out_reg <= 1'b1;
        end
      end
      default:begin
        next_state <= A;
        out_reg <= 1'b0;
      end
    endcase
  end
endmodule