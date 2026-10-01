// Test Bench
module CLA_test_bench;

	reg [31:0] A, B;
	reg Cin;
	wire [31:0] S;
	wire Cout;

  CLA dut (.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));

  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    //Test 1
    A = 32'h00000001;
    B = 32'h00001000;
    Cin = 0;
    #10;
    $display("A=%d B=%d Cin=%b --> S=%d Cout=%b", A ,B, Cin, S, Cout);

    //Test 2
    A = 32'h00000001;
    B = 32'h0000FFFF;
    Cin = 0;
    #10;
    $display("A=%d B=%d Cin=%b --> S=%d Cout=%b", A ,B, Cin, S, Cout);

    //Test 3
    A = 32'h000F0F0F;
    B = 32'h00001010;
    Cin = 1;
    #10;
    $display("A=%d B=%d Cin=%b --> S=%d Cout=%b", A ,B, Cin, S, Cout);

    // propagation test
    A = 32'hFFFFFFFF;
    B = 32'h00000000;
    Cin = 1;
    #10;
    $display("[PROP_TEST:]\tA=%d B=%d Cin=%b --> S=%h Cout=%b", A ,B, Cin, S, Cout);
    Cin = 0;

    #10
    $display("finished testbench!");

    $finish;
  end
endmodule
