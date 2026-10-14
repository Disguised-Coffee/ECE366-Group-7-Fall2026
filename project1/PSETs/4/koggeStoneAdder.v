/*

  Kogge Stone

  pain


*/

//our own XOR gate, cuz debjit said "AND and OR only"
// but we can use NOT, right?
module _XOR_WHY (
  input a
  input B
  output out
);
  assign _XOR_WHY = (a & ~B) | (~a & b) ;
endmodule


// post computation
module _postCompute (
  input G, 
  input P, 
  output sum
);
  // to be filled
endmodule

module _blackBox (
  input G, 
  input P, 
  output outG, 
  output outP
);
  // to be filled
endmodule

module _grayBox (
  input G, 
  input P, 
  output outG, 
);
// to be filled
endmodule

// ts just a register
module _buffer (
  input G, 
  input P, 
  output reg outP, 
  output reg outG
);
  
  // just for old time's sake
  always @(posedge clk) begin
    outP <= P;
    outG <= G;
  end
endmodule

// pure pain and agony of extra credit
// Kogge - Stone Adder

module koggeStoneAdder (
  input [15:0] A, B;
  input Cin;
  output [15:0] S;
  output Cout;
);

  wire [15:0] line1_p, line2_p, line3_p, line4_p, 
              line1_g, line2_g, line3_g, 
              P, G;

  wire [16:0] line4_g; // funny one with C out and Cin
  assign lineWithThatCarry[0] = Cin;
  assign Cout = lineWithThatCarry[16]; //17th element, ofc.

  genvar i;
  
  generate
    for (i = 0; i < 16 ; i = i+1) begin
      // generate propigation stuff
      assign P[i] = A[i] ^ B[i]; // can be made with AND and OR
      assign G[i] = A[i] & B[i];

      _postCompute rectangle(.G(lineWithThatCarry[]) .sum(S[i]));
      assign S[i+1] = lineWithThatCarry[];

    end  

    // crazy part: pieces
    for (i = 0; i < 4 ; i = i + 1) begin
      // more pattern stuff
    end
  endgenerate
  
endmodule