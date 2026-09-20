/*
  PSET 1

  // first few are behavioral models (uses a procedural block or such)

  btw, space by 2
*/

// P. 1A
// 
// uses behavioral modeling
//  
module one_bit_full_adder_BM (
    A, B, Cin, S, Cout
);
  input A, B, Cin;
  output S, Cout;

  // this is the precursor to my PTSD.
  assign S = (A ^ B ^ Cin);
  assign Cout = (A & B) | (B & Cin) | (Cin & A);

endmodule

// P. 1B
// 
// uses structural modeling
module one_bit_full_adder_SM (
    A, B, Cin, S, Cout
);
  input A, B, Cin;
  output S, Cout;

  // wires with a width of one (lovely)
  wire x_out, a_out1, a_out2, a_out3;

  // this is the precursor to my PTSD.
  xor u0(x_out, A, B);
  xor u1(S, x_out, Cin);

  and c1(a_out1, Cin, A);
  and c2(a_out2, Cin, B);
  and c3(a_out3, A, B);
  or c4(Cout, a_out1, a_out2, a_out3);

endmodule

// 
// P 1C, and P 1D
// Ripple Carry Adder/Subtractor
// 
module four_bit_RCA_RCS (
    A, B, Cin, S, Cout, Sub
);
  // yes, we are 4 bits wide!
  input [3:0] A,B;
  input Cin, Sub;
  output[3:0] S;
  output Cout; 

  // for inbetween each FA
  wire cout1, cout2, cout3;

  // then 4 different instantiations...
  one_bit_full_adder_BM fa0(.A(A[0]), .B(Sub ? ~B[0] : B[0]), .Cin(Cin|Sub), .S(S[0]), .Cout(cout1));
  one_bit_full_adder_BM fa1(.A(A[1]), .B(Sub ? ~B[1] : B[1]), .Cin(cout1), .S(S[1]), .Cout(cout2));
  one_bit_full_adder_BM fa2(.A(A[2]), .B(Sub ? ~B[2] : B[2]), .Cin(cout2), .S(S[2]), .Cout(cout3));
  one_bit_full_adder_BM fa3(.A(A[3]), .B(Sub ? ~B[3] : B[3]), .Cin(cout3), .S(S[3]), .Cout(Cout));

endmodule 
