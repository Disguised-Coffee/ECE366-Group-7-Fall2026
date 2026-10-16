// in EDA, it should pop up normally.

module fa_KGST_TB;

  reg [15:0] valA, valB;  
  reg Cin, Sub;

  // OUTPUTS CANNOT BE REGISTERS!!!
  wire [15:0] sumO;
  wire Cout;

  // One FA for all tests. Like one object for all test cases.
  koggeStoneAdder FA(.A(valA), .B(valB), .Cin(Cin), .S(sumO), .Cout(Cout));
  
  // think of these as function! Or as cs 251 test cases.
  task unsigned_FA_Test(input [15:0] in1, input [15:0] in2, input _Cin);
    begin
      valA = in1;
      valB = in2;
      Cin = _Cin;

      // allow time for signal propagation...
      // so that the waveform can properly show up.
      #2;

      if($signed(sumO) == in1 + in2)
          $display("\t[PASS] Signed Adding %d + %d = %d", in1, in2, $signed(sumO));
        else
          $display("\t[FAIL] Signed Adding %d + %d = %d", in1, in2, $signed(sumO));
    end
  endtask

  initial begin
    $dumpfile("dump.vcd"); $dumpvars;

    valA <= 4'sd2;
    valB <= 4'sd4;
    Cin <= 0;
    Sub <= 0;
    

    #2
    
    // unsigned adds
    $display("----------------------\nCase One: Unsigned Addition\n");
    unsigned_FA_Test(3, 2 , 0);
    $display("Carry out: %d", Cout);

    // unsigned subs
    $display("----------------------\nCase Two: Unsigned Subtraction\n");
    unsigned_FA_Test(3, 2 , 1);

    // signed adds w/negative op
    $display("----------------------\nCase Three: Signed Addition with negatives\n");
    unsigned_FA_Test(3, -2 , 0);
    unsigned_FA_Test(-3, 2 , 0);

    // signed subs w/ negative op
    $display("----------------------\nCase Four: Signed Subtraction with negatives\n");
    unsigned_FA_Test(3, -6 , 1);
    unsigned_FA_Test(-3, 2 , 1);

    // case with produced carry-out (ie: overflow)
    $display("----------------------\nCase Five: Propagated carry-out\n");
    $display(">>> Case with NO carry-out");
    unsigned_FA_Test(1, 1 , 0);
    $display("\tCarry out: %b", Cout);
    
    
    $display(">>> Case with carry-out");
    unsigned_FA_Test(15, 2 , 0);
    
    
    $display("\tCarry out: %b", Cout);
    
    // last waveform doesn't appear, so we need to reset the registers
    valA = 0;
    valB = 0;
    $finish;
    
  end

endmodule