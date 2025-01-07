module RAM128x32 
#(
  parameter Data_width = 32,  //# of bits in word
            Addr_width = 7  // # of address bits
  )
  (  //ports
    input wire clk,
    input wire we,
    input wire [(Addr_width-1):0] address, 
    input wire [(Data_width-1):0] d,
    output wire [(Data_width-1):0] q
  );
  
  reg [Addr_width-1:0] memory [Data_width-1:0];
  reg [Data_width-1:0] q_reg;
  always @ (posedge clk) begin
    if (we == 1'b1) begin
      memory[address] <= d;
      q_reg <= {Data_width{1'bx}};
    end else begin
      q_reg <= memory[address];
    end
  end
  
  assign q = q_reg;

endmodule
