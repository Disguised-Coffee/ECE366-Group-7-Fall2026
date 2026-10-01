// Work done by disguised_coffee
//code needed to operate my code
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

endmodule

//Designing the 32-bit CLA with 4-bit RCAs
//Used Lecture 2 Slides 28
//4-bit Full Adder 0
module fourBitCLABlock(A, B, Cin, S, Cout);
	input [3:0] A, B;
	input Cin;
	output [3:0] S;
	output Cout;

  // propagate carry logic
  wire [3:0] P, G;	//Bit level propagate and generate
  wire [4:0] C; // so Cin can be assigned to this netlist
  
  // because we want to optimize, we can assign cin and cout to be a part of C
  assign C[0] = Cin;
  assign Cout  = C[4];

  // Generate P, G, and Full adders
  genvar i;
  generate
    for(i = 0;i < 4; i = i+1) begin
      assign P[i] = A[i] | B[i];
      assign G[i] = A[i] & B[i];

      // carry logic
      assign C[i + 1] = G[i] | P[i] & C[i];

      // RCAs for this block
      one_bit_full_adder_SM fa( 
          .A(A[i]), 
          .B(B[i]), 
          .Cin(C[i]), 
          .S(S[i]), 
          .Cout()  // we DO NOT want to modify any of the carries with this!
      );
    end
  endgenerate

endmodule

// 32-bit carry look ahead
module CLA (A, B, Cin, S , Cout);
  input	[31:0] A, B;
  input	Cin;
  output [31:0] S;
  output Cout;

  wire [8:0] C; // since we want to assign Cin to c[0] we do 8 + 1
  assign C[0] = Cin;
  assign Cout = C[8];

  // we want to create CLA blocks so we can not repeat this 8 times
  genvar j;					

  generate					
    for (j = 0; j < 8; j = j + 1) begin
      // our block
      fourBitCLABlock inst(
        .A(A[(3 + j*4): j*4]),
        .B(B[(3 + j*4): j*4]),
        .Cin(C[j]),
        .S(S[(3 + j*4): j*4]),
        .Cout(C[j + 1])
      );
    end 
  endgenerate

endmodule
