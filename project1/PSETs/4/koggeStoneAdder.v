/*

  Kogge Stone

  pain


*/

//our own XOR gate, cuz debjit said "AND and OR only"
// but we can use NOT, right?
module _XOR_WHY (
  input a,
  input b,
  output out
);
  assign _XOR_WHY = (a & ~b) | (~a & b) ;
endmodule


// post computation
module _postCompute (
  input G, 
  input P, 
  output sum
);
  _XOR_WHY result(.a(G), .b(P), .out(sum));
endmodule

module _blackBox (
  input G, 
  input P, 
  input Gprev,
  input Pprev,
  output outG, 
  output outP
);
  assign outP = P & Pprev;
  assign outG = G | (P & Gprev);
endmodule

module _grayBox (
  input G, 
  input P, 
  input Gprev,
  output outG
);
  assign outG = G | (P & Gprev);
endmodule

// ts just a register
module _buffer (
  input G, 
  input P, 
  output reg outP, 
  output reg outG
);
  
  // just for old time's sake
  always @(*) begin
    outP <= P;
    outG <= G;
  end
endmodule

// pure pain and agony of extra credit
// Kogge - Stone Adder

module koggeStoneAdder (
  input [15:0] A, B,
  input Cin,
  output [15:0] S,
  output Cout
);

  wire [15:0] line1_p, line2_p, line3_p, line4_p, 
              line1_g, line2_g, line3_g, 
              P, G;

  wire [16:0] line4_g; // funny one with C out and Cin
  assign line4_g[0] = Cin;
  assign Cout = line4_g[16]; //17th element, ofc.

  genvar i;
  
  // pre-computation
  generate
    for (i = 0; i < 16 ; i = i+1) begin
      // generate propigation stuff
      assign P[i] = A[i] ^ B[i]; // can be made with AND and OR
      assign G[i] = A[i] & B[i];
    end  
  endgenerate

  // ideally, looking for a pattern to exploit would be nice
  // but this is structure, not C++ code

  // yes, I know this is super inefficient to do this way. - dan

  // line one
  generate
    for (i = 0; i < 16 ; i = i+1 ) begin
      case (i)
        0 : begin
          _buffer buffer_thing(.G(G[i]), .P(P[i]), .outP(line1_p[i]), .outG(line1_g[i]));
        end
        1 : begin
          _grayBox gray(.G(G[i]), .P(P[i]), .Gprev(G[i - 1]), .Pprev(P[i - 1]), .outG(line1_g[i]));
        end
        default: begin
          _blackBox blk(.G(G[i]), .P(P[i]), .Gprev(G[i - 1]), .Pprev(P[i - 1]), .outP(line1_p[i]), .outG(line1_g[i]));
        end
      endcase
    end
  endgenerate 

  // line two
  generate
    for (i = 0; i < 16 ; i = i+1 ) begin
      case (i)
        0 : begin
          assign line2_g[i] = line1_g[i];
          assign line2_p[i] = line1_p[i];
        end
        1 : begin
          _buffer buffer_thing(.G(line1_g[i]), .P(line1_p[i]), .outP(line2_g[i]), .outG(line2_p[i]));
        end
        2, 3 : begin
          _grayBox gray(.G(line1_g[i]), .P(line1_p[i]), .Gprev(line1_g[i - 2]), .Pprev(line1_p[i - 2]), .outG(line2_g[i]));
        end
        default:  
          _blackBox blk(.G(line1_g[i]), .P(line1_p[i]), .Gprev(line1_g[i - 1]), .Pprev(line1_p[i - 1]), .outP(line2_p[i]), .outG(line2_g[i]));
      endcase
    end
  endgenerate 

  // line 3
  generate
    for (i = 0; i < 16 ; i = i+1 ) begin
      case (i)
        0,1 : begin
          assign line3_g[i] = line2_g[i];
          assign line3_p[i] = line2_p[i];
        end
        2,3 : begin
          _buffer buffer_thing(.G(line2_g[i]), .P(line2_p[i]), .outP(line3_p[i]), .outG(line3_p[i]));
        end
        4,5,6,7 : begin
          _grayBox gray(.G(line2_g[i]), .P(line2_p[i]), .Gprev(line2_g[i - 4]), .Pprev(line2_p[i - 4]), .outG(line3_g[i]));
        end
        default: 
          _blackBox blk(.G(line2_g[i]), .P(line2_p[i]), .Gprev(line2_g[i - 4]), .Pprev(line2_p[i - 4]), .outP(line3_p[i]), .outG(line3_g[i]));
      endcase
    end
  endgenerate 

  // line 4
  generate
    for (i = 0; i < 16 ; i = i+1 ) begin
      case (i)
        0,1,2,3 : begin
          assign line4_g[i] = line3_g[i];
          assign line4_p[i] = line3_p[i];
        end
        4,5,6,7 : begin
          _buffer buf(.G(line3_g[i]), .P(line3_p[i]), .outP(line4_p[i]), .outG(line4_g[i]));
        end
        default: 
          _grayBox gray(.G(line3_g[i]), .P(line3_p[i]), .Gprev(line3_g[i - 8]), .Pprev(line3_p[i - 8]), .outG(line4_g[i + 1]));
      endcase
    end
  endgenerate 

  generate
    // post propigate for sum
    for (i = 0; i < 16 ; i = i+1) begin
      _postCompute BLYAT()
    end  
  endgenerate

  
endmodule