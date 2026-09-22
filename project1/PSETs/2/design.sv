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

  and c1(a_out1, Cin, A);
  and c2(a_out2, Cin, B);
  and c3(a_out3, A, B);
  or c4(Cout, a_out1, a_out2, a_out3);

endmodule



//Designing the 32-bit CLA with 4-bit RCAs
//Used Lecture 2 Slides 28

//4-bit Full Adder 0
module fourBitCLABlock0(A, B, Cin, S, Cout);
	input [3:0] A, B;
	input Cin;
	output [3:0] S;
	output Cout;
	wire C1,C2,C3;


one_bit_full_adder_SM FA0( .A(A[0]), .B(B[0]), .Cin(Cin), .S(S[0]), .Cout(C1) );
one_bit_full_adder_SM FA1( .A(A[1]), .B(B[1]), .Cin(C1), .S(S[1]), .Cout(C2) );
one_bit_full_adder_SM FA2( .A(A[2]), .B(B[2]), .Cin(C2), .S(S[2]), .Cout(C3) );
one_bit_full_adder_SM FA3( .A(A[3]), .B(B[3]), .Cin(C3), .S(S[3]), .Cout(Cout) );

endmodule

//4-bit Full Adder 1
module fourBitCLABlock1(A, B, Cin, S, Cout);
	input [7:4] A, B;
	input Cin;
	output [7:4] S;
	output Cout;
	wire C4,C5,C6;


one_bit_full_adder_SM FA4( .A(A[4]), .B(B[4]), .Cin(Cin), .S(S[4]), .Cout(C4) );
one_bit_full_adder_SM FA5( .A(A[5]), .B(B[5]), .Cin(C4), .S(S[5]), .Cout(C5) );
one_bit_full_adder_SM FA6( .A(A[6]), .B(B[6]), .Cin(C5), .S(S[6]), .Cout(C6) );
one_bit_full_adder_SM FA7( .A(A[7]), .B(B[7]), .Cin(C6), .S(S[7]), .Cout(Cout) );

endmodule

//4-bit Full Adder 2
module fourBitCLABlock2(A, B, Cin, S, Cout);
	input [11:8] A, B;
	input Cin;
	output [11:8] S;
	output Cout;
	wire C8,C9,C10;


one_bit_full_adder_SM FA8( .A(A[8]), .B(B[8]), .Cin(Cin), .S(S[8]), .Cout(C8) );
one_bit_full_adder_SM FA9( .A(A[9]), .B(B[9]), .Cin(C8), .S(S[9]), .Cout(C9) );
one_bit_full_adder_SM FA10( .A(A[10]), .B(B[10]), .Cin(C9), .S(S[10]), .Cout(C10) );
one_bit_full_adder_SM FA11( .A(A[11]), .B(B[11]), .Cin(C10), .S(S[11]), .Cout(Cout) );

endmodule

//4-bit Full Adder 3
module fourBitCLABlock3(A, B, Cin, S, Cout);
	input [15:12] A, B;
	input Cin;
	output [15:12] S;
	output Cout;
	wire C12,C13,C14;


one_bit_full_adder_SM FA12( .A(A[12]), .B(B[12]), .Cin(Cin), .S(S[12]), .Cout(C12) );
one_bit_full_adder_SM FA13( .A(A[13]), .B(B[13]), .Cin(C12), .S(S[13]), .Cout(C13) );
one_bit_full_adder_SM FA14( .A(A[14]), .B(B[14]), .Cin(C13), .S(S[14]), .Cout(C14) );
one_bit_full_adder_SM FA15( .A(A[15]), .B(B[15]), .Cin(C14), .S(S[15]), .Cout(Cout) );

endmodule

//4-bit Full Adder 4
module fourBitCLABlock4(A, B, Cin, S, Cout);
	input [19:16] A, B;
	input Cin;
	output [19:16] S;
	output Cout;
	wire C16,C17,C18;


one_bit_full_adder_SM FA16( .A(A[16]), .B(B[16]), .Cin(Cin), .S(S[16]), .Cout(C16) );
one_bit_full_adder_SM FA17( .A(A[17]), .B(B[17]), .Cin(C16), .S(S[17]), .Cout(C17) );
one_bit_full_adder_SM FA18( .A(A[18]), .B(B[18]), .Cin(C17), .S(S[18]), .Cout(C18) );
one_bit_full_adder_SM FA19( .A(A[19]), .B(B[19]), .Cin(C18), .S(S[19]), .Cout(Cout) );

endmodule

//4-bit Full Adder 5
module fourBitCLABlock5(A, B, Cin, S, Cout);
	input [23:20] A, B;
	input Cin;
	output [23:20] S;
	output Cout;
	wire C20,C21,C22;


one_bit_full_adder_SM FA20( .A(A[20]), .B(B[20]), .Cin(Cin), .S(S[20]), .Cout(C20) );
one_bit_full_adder_SM FA21( .A(A[21]), .B(B[21]), .Cin(C20), .S(S[21]), .Cout(C21) );
one_bit_full_adder_SM FA22( .A(A[22]), .B(B[22]), .Cin(C21), .S(S[22]), .Cout(C22) );
one_bit_full_adder_SM FA23( .A(A[23]), .B(B[23]), .Cin(C22), .S(S[23]), .Cout(Cout) );

endmodule

//4-bit Full Adder 6
module fourBitCLABlock6(A, B, Cin, S, Cout);
	input [27:24] A, B;
	input Cin;
	output [27:24] S;
	output Cout;
	wire C24,C25,C26;


one_bit_full_adder_SM FA24( .A(A[24]), .B(B[24]), .Cin(Cin), .S(S[24]), .Cout(C24) );
one_bit_full_adder_SM FA25( .A(A[25]), .B(B[25]), .Cin(C24), .S(S[25]), .Cout(C25) );
one_bit_full_adder_SM FA26( .A(A[26]), .B(B[26]), .Cin(C25), .S(S[26]), .Cout(C26) );
one_bit_full_adder_SM FA27( .A(A[27]), .B(B[27]), .Cin(C26), .S(S[27]), .Cout(Cout) );

endmodule

//4-bit Full Adder 7
module fourBitCLABlock7(A, B, Cin, S, Cout);
	input [31:28] A, B;
	input Cin;
	output [31:28] S;
	output Cout;
	wire C28,C29,C30;


one_bit_full_adder_SM FA29( .A(A[28]), .B(B[28]), .Cin(Cin), .S(S[28]), .Cout(C28) );
one_bit_full_adder_SM FA30( .A(A[29]), .B(B[29]), .Cin(C28), .S(S[29]), .Cout(C29) );
one_bit_full_adder_SM FA31( .A(A[30]), .B(B[30]), .Cin(C29), .S(S[30]), .Cout(C30) );
one_bit_full_adder_SM FA32( .A(A[31]), .B(B[31]), .Cin(C30), .S(S[31]), .Cout(Cout) );


endmodule



//This is a function that would generate P[i],G[i]
module CLA (A, B, Cin, S , Cout);
  input	[31:0] A, B;
  input	Cin;
  output [31:0] S;
  output Cout;

  wire [31:0] P, G;	//Bit level propagate and generate
  wire [7:0] P_B, G_B;	//block level propagate and generate
  wire [8:0] C;		//block carry

// This would create all of the P[i] and G[i] for the 32-bit CLA with 4-bit RCAs
genvar i;					//Declares a variable for the the loop

generate					// Begin generate block
	for (i = 0; i < 32; i = i + 1) begin
		xor (P[i], A[i], B[i]);		// Carry propagate
		and (G[i], A[i], B[i]);		// Carry Generate
	end 
endgenerate					// End generate block


//All Blocks codes mirror the logic gates that are presented in slide 28
//Block 0: bits 0-3

//Block propagate

and(P_B[0], P[0], P[1], P[2], P[3]);	

// Block Generate
wire w1,w2 ,w3;
and(w1, P[3], G[2]);			// P3 * G2
and(w2, P[3], P[2], G[1]);		// P3 * P2 * G1
and(w3, P[3], P[2], P[1], G[0]);	// P3 * P2 * P1 * G0

or(G_B[0], G[3], w1 ,w2 ,w3);


//Block 1: bits 7-4

//Block propagate

and(P_B[1], P[4], P[5], P[6], P[7]);

// Block Generate
wire w1_1,w2_1 ,w3_1;
and(w1_1, P[7], G[6]);
and(w2_1, P[7], P[6], G[5]);
and(w3_1, P[7], P[6], P[5], G[4]);

or(G_B[1], G[7], w1_1 ,w2_1 ,w3_1);


//Block 2: bits 11-8

//Block propagate

and(P_B[2], P[8], P[9], P[10], P[11]);

// Block Generate
wire w1_2,w2_2 ,w3_2;
and(w1_2, P[11], G[10]);
and(w2_2, P[11], P[10], G[9]);
and(w3_2, P[11], P[10], P[9], G[8]);

or(G_B[2], G[11], w1_2 ,w2_2 ,w3_2);


//Block 3: bits 15-12

//Block propagate

and(P_B[3], P[12], P[13], P[14], P[15]);

// Block Generate
wire w1_3,w2_3 ,w3_3;
and(w1_3, P[15], G[14]);
and(w2_3, P[15], P[14], G[13]);
and(w3_3, P[15], P[14], P[13], G[12]);

or(G_B[3], G[15], w1_3 ,w2_3 ,w3_3);


//Block 4: bits 19-16

//Block propagate

and(P_B[4], P[16], P[17], P[18], P[19]);

// Block Generate
wire w1_4,w2_4 ,w3_4;
and(w1_4, P[19], G[18]);
and(w2_4, P[19], P[18], G[17]);
and(w3_4, P[19], P[18], P[17], G[16]);

or(G_B[4], G[19], w1_4 ,w2_4 ,w3_4);


//Block 5: bits 23-20

//Block propagate

and(P_B[5], P[20], P[21], P[22], P[23]);

// Block Generate
wire w1_5,w2_5 ,w3_5;
and(w1_5, P[23], G[22]);
and(w2_5, P[23], P[22], G[21]);
and(w3_5, P[23], P[22], P[21], G[20]);

or(G_B[5], G[23], w1_5 ,w2_5 ,w3_5);


//Block 6: bits 27-24

//Block propagate

and(P_B[6], P[24], P[25], P[26], P[27]);

// Block Generate
wire w1_6,w2_6 ,w3_6;
and(w1_6, P[27], G[26]);
and(w2_6, P[27], P[26], G[25]);
and(w3_6, P[27], P[26], P[25], G[24]);

or(G_B[6], G[27], w1_6 ,w2_6 ,w3_6);



//Block 7: bits 31-28

//Block propagate

and(P_B[7], P[28], P[29], P[30], P[31]);

// Block Generate
wire w1_7,w2_7 ,w3_7;
and(w1_7, P[31], G[30]);
and(w2_7, P[31], P[30], G[29]);
and(w3_7, P[31], P[30], P[29], G[28]);

or(G_B[7], G[31], w1_7 ,w2_7 ,w3_7);


//Computes the carry in for each of the 4-block

assign C[0] = Cin;

assign C[1] = G_B[0] | (P_B[0] & C[0]);
assign C[2] = G_B[1] | (P_B[1] & C[1]);
assign C[3] = G_B[2] | (P_B[2] & C[2]);
assign C[4] = G_B[3] | (P_B[3] & C[3]);
assign C[5] = G_B[4] | (P_B[4] & C[4]);
assign C[6] = G_B[5] | (P_B[5] & C[5]);
assign C[7] = G_B[6] | (P_B[6] & C[6]);
assign C[8] = G_B[7] | (P_B[7] & C[7]);

//Gives the values to the Full Adders that was declared in the start of the program
fourBitCLABlock0 block0 (.A(A[3:0]), .B(B[3:0]), .Cin(C[0]), .S(S[3:0]), .Cout(C[1]));
fourBitCLABlock1 block1 (.A(A[7:4]), .B(B[7:4]), .Cin(C[1]), .S(S[7:4]), .Cout(C[2]));
fourBitCLABlock2 block2 (.A(A[11:8]), .B(B[11:8]), .Cin(C[2]), .S(S[11:8]), .Cout(C[3]));
fourBitCLABlock3 block3 (.A(A[15:12]), .B(B[15:12]), .Cin(C[3]), .S(S[15:12]), .Cout(C[4]));
fourBitCLABlock4 block4 (.A(A[19:16]), .B(B[19:16]), .Cin(C[4]), .S(S[19:16]), .Cout(C[5]));
fourBitCLABlock5 block5 (.A(A[23:20]), .B(B[23:20]), .Cin(C[5]), .S(S[23:20]), .Cout(C[6]));
fourBitCLABlock6 block6 (.A(A[27:24]), .B(B[27:24]), .Cin(C[6]), .S(S[27:24]), .Cout(C[7]));
fourBitCLABlock7 block7 (.A(A[31:28]), .B(B[31:28]), .Cin(C[7]), .S(S[31:28]), .Cout(C[8]));

// Final carry-out
assign Cout = C[8];
endmodule
