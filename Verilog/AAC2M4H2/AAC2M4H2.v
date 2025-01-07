module FIFO8x9(
  input clk, rst,        // Clock and Reset signals
  input RdPtrClr, WrPtrClr, // Clear signals for read and write pointers
  input RdInc, WrInc,    // Increment signals for read and write pointers
  input [7:0] DataIn,    // Data input for writing
  output reg [7:0] DataOut, // Data output for reading
  input rden, wren       // Read and Write enables
);
integer i;
  // Signal declarations
  reg [7:0] fifo_array[7:0];  // FIFO array (8 locations, each 9 bits wide)
  reg [7:0] wrptr, rdptr;     // Write and read pointers

  // FIFO Read Process
  always @ (posedge clk or posedge rst) begin
    if (rst) begin
      rdptr <= {8{1'b0}};  // Reset read pointer to 0
      DataOut <= {8{1'b0}}; // Clear DataOut on reset
    end else begin
      if (RdPtrClr) begin
        rdptr <= {8{1'b0}};  // Clear read pointer if requested
      end
      if (RdInc) begin
        rdptr <= rdptr + 1;  // Increment read pointer
      end
      if (rden) begin
        DataOut <= fifo_array[rdptr];  // Output data from FIFO on read enable
      end
    end
  end

  // FIFO Write Process
  always @ (posedge clk or posedge rst) begin
    if (rst) begin
      wrptr <= {8{1'b0}};  // Reset write pointer to 0
    end else begin
      if (WrPtrClr) begin
        wrptr <={8{1'b0}};  // Clear write pointer if requested
      end
      if (WrInc) begin
        wrptr <= wrptr + 1;  // Increment write pointer
      end
      if (wren) begin
        fifo_array[wrptr] <= DataIn;  // Write data to FIFO array on write enable
      end
    end
  end

  always @ (posedge clk or posedge rst) begin
    if (rst) begin
      DataOut <= {8{1'b0}};
      for (i = 0; i < 8; i = i + 1) begin 
        fifo_array[i] <={8{1'b0}}; 
      end
      wrptr <= {8{1'b0}}; 
      rdptr <={8{1'b0}};
    end
  end

endmodule
