// pset 3: 16-bit prefix adder

// The black square in Figure 3
// Merges a high group (i) with the group right below it (j)
// Only 2-input AND/OR gates, as the assignment requires
module prefix_cell (Gi, Pi, Gj, Pj, Go, Po);
  input  Gi, Pi, Gj, Pj;
  output Go, Po;

  wire t;
  and a1(t,  Pi, Gj);   // P(i) & G(j)
  or  o1(Go, Gi, t);    // G(i) | (P(i) & G(j))
  and a2(Po, Pi, Pj);   // P(i) & P(j)
endmodule

// One level of the prefix network (one row of black squares)
// SPAN = size of the groups coming in: 1, 2, 4, 8 for levels 1 to 4
// Position j either merges with the top of the block below it
// (black square) or just passes its value straight down 
module prefix_level #(parameter SPAN = 1) (Gin, Pin, Gout, Pout);
  input  [15:0] Gin, Pin;
  output [15:0] Gout, Pout;

  genvar j;
  generate
    for (j = 0; j < 16; j = j + 1) begin : pos
      if ((j / SPAN) % 2 == 1) begin : merge
        // merge with the highest position of the block below
        prefix_cell c (
          .Gi(Gin[j]), .Pi(Pin[j]),
          .Gj(Gin[(j / SPAN) * SPAN - 1]),
          .Pj(Pin[(j / SPAN) * SPAN - 1]),
          .Go(Gout[j]), .Po(Pout[j])
        );
      end else begin : bypass
        assign Gout[j] = Gin[j];
        assign Pout[j] = Pin[j];
      end
    end
  endgenerate
endmodule

// 16-bit parallel prefix adder 
module PPA (A, B, Cin, S, Cout);
  input  [15:0] A, B;
  input         Cin;
  output [15:0] S;
  output        Cout;

  // Verilog has no index "-1", so position 0 is the "-1" column (Cin)

  wire [15:0] G0, P0;   // after pre-computation
  wire [15:0] G1, P1;   // after level 1 (groups of 2)
  wire [15:0] G2, P2;   // after level 2 (groups of 4)
  wire [15:0] G3, P3;   // after level 3 (groups of 8)
  wire [15:0] G4, P4;   // after level 4 (groups of 16): G4[j] = carry INTO bit j

  // pre-computation
  assign G0[0] = Cin;     // the "-1" column: G = Cin
  assign P0[0] = 1'b0;    //                  P = 0

  genvar i;
  generate
    for (i = 1; i < 16; i = i + 1) begin : pre
      assign G0[i] = A[i-1] & B[i-1];
      assign P0[i] = A[i-1] | B[i-1];
    end
  endgenerate

  // prefix network
  prefix_level #(.SPAN(1)) L1 (.Gin(G0), .Pin(P0), .Gout(G1), .Pout(P1));
  prefix_level #(.SPAN(2)) L2 (.Gin(G1), .Pin(P1), .Gout(G2), .Pout(P2));
  prefix_level #(.SPAN(4)) L3 (.Gin(G2), .Pin(P2), .Gout(G3), .Pout(P3));
  prefix_level #(.SPAN(8)) L4 (.Gin(G3), .Pin(P3), .Gout(G4), .Pout(P4));

  // post-computation
  // S[i] = (carry into bit i) ^ A[i] ^ B[i]
  generate
    for (i = 0; i < 16; i = i + 1) begin : post
      assign S[i] = G4[i] ^ (A[i] ^ B[i]);
    end
  endgenerate

  // Carry out of bit 15 = G(15) | (P(15) & carry into bit 15)
  assign Cout = (A[15] & B[15]) | ((A[15] | B[15]) & G4[15]);

endmodule
