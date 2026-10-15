module PPA_test_bench;

  reg  [15:0] A, B;
  reg         Cin;
  wire [15:0] S;
  wire        Cout;

  reg [16:0] expected;
  integer errors = 0;
  integer k;

  PPA dut (.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));

  task check(input [15:0] a, input [15:0] b, input c, input [255:0] label);
    begin
      A = a; B = b; Cin = c;
      #10;
      expected = {1'b0, a} + {1'b0, b} + c;
      if ({Cout, S} === expected)
        $display("[PASS] %0s: %h + %h + %b = %h (Cout=%b)", label, a, b, c, S, Cout);
      else begin
        errors = errors + 1;
        $display("[FAIL] %0s: %h + %h + %b -> got Cout=%b S=%h, expected %h",
                 label, a, b, c, Cout, S, expected);
      end
    end
  endtask

  initial begin
    $dumpfile("dump.vcd"); $dumpvars;

    // unsigned add
    check(16'h0005, 16'h0003, 0, "unsigned add");
    check(16'h0005, 16'h0003, 1, "unsigned add with Cin");

    // signed add with a negative operand 2's complement
    check(16'hFFFB, 16'h0003, 0, "signed: -5 + 3 = -2");
    check(16'h0005, 16'hFFFD, 0, "signed: 5 + -3 = 2");
    check(16'hFFFB, 16'hFFFD, 0, "signed: -5 + -3 = -8");

    // carry across one 4-bit group
    check(16'h000F, 16'h0001, 0, "carry across 1 group");

    // carry propagation across multiple 4-bit groups
    check(16'h0FFF, 16'h0001, 0, "propagate through 3 groups");
    check(16'h7FFF, 16'h0001, 0, "propagate through 15 bits");

    // carry-out
    check(16'hFFFF, 16'h0001, 0, "carry-out");
    check(16'hFFFF, 16'h0000, 1, "Cin propagates to Cout");
    check(16'hFFFF, 16'hFFFF, 1, "max + max + 1");

    // random tests 120 ns for ss
    for (k = 0; k < 200; k = k + 1)
      check($random, $random, $random, "random");

    if (errors == 0) $display("ALL TESTS PASSED");
    else             $display("%0d TESTS FAILED", errors);

    #10;
    $finish;
  end
endmodule