module ALU ( 
  input [2:0] Op_code,
  input [31:0] A, B,
  output reg [31:0] Y
);

  always @(Op_code or A or B) begin
    case (Op_code)
      3'b000: begin
        Y <= A;
      end
      3'b001: begin
        Y <= A + B;
      end
      3'b010: begin
        Y <= A - B;
      end
      3'b011: begin
        Y <= A & B;
      end
      3'b100: begin
        Y <= A | B;
      end
      3'b101: begin
        Y <= A + 1;
      end
      3'b110: begin
        Y <= A - 1;
      end
      3'b111: begin
        Y <= B;
      end
      default: begin
        Y = 32'bxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx;
      end
  endcase
  end

endmodule
