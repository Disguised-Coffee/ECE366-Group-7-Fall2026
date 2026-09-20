// in EDA, it should pop up normally.

// These are weird.
module fa_RCS_TB;

  reg [3:0] valA, valB;

  // OUTPUTS CANNOT BE REGISTERS!!!
  wire [3:0] sumO;

  reg Cin, Sub;

  wire Cout;

  // FA 
  four_bit_RCA_RCS FA(.A(valA), .B(valB), .Cin(Cin), .S(sumO), .Sub(Sub), .Cout(Cout));

  // task reset()
  // endtask

  
  task unsigned_FA_Test(input [3:0] in1, input [3:0] in2, input subtract);
    begin
      valA = in1;
      valB = in2;
      Sub = subtract;
      Cin = 0;

      // allow time for signal propagation...
      #10;

      if (subtract == 0) begin
        if(sumO == in1 + in2)
          $display("\t[PASS] Adding %d + %d = %d", in1, in2, sumO);
        else
          $display("\t[FAIL] Adding %d + %d = %d", in1, in2, sumO);
      end else begin;
        if(sumO == in1 - in2)
          $display("\t[PASS] Subtracting %d - %d = %d", in1, in2, sumO);
        else
          $display("\t[FAIL] Subtracting %d - %d = %d", in1, in2, sumO);
      end
    end
  endtask

  task signed_FA_Test(input signed [3:0] in1, input signed [3:0] in2, input subtract);
    begin
      // cuz we wanted signed, we can do this 
      // https://chipverify.com/verilog/verilog-conversion-functions
      valA = in1;
      valB = in2;
      Sub = subtract;

      // allow time for signal propagation...
      #10;

      if (subtract == 0) begin
        if($signed(sumO) == in1 + in2)
          $display("\t[PASS] Signed Adding %d + %d = %d", in1, in2, $signed(sumO));
        else
          $display("\t[FAIL] Signed Adding %d + %d = %d", in1, in2, $signed(sumO));
      end else begin
        if(sumO == in1 - in2)
          $display("\t[PASS] Signed Subtracting %d - %d = %d", in1, in2, $signed(sumO));
        else
          $display("\t[FAIL] Signed Subtracting %d - %d = %d", in1, in2, $signed(sumO));
      end
    end
  endtask

  initial begin
    valA <= 4'sd2;
    valB <= 4'sd4;
    Cin <= 0;
    Sub <= 0;
    

    #10
    
    // unsigned adds
    $display("----------------------\nCase One: Unsigned Addition\n");
    unsigned_FA_Test(3, 2 , 0);
    $display("Carry out: %d", Cout);

    // unsigned subs
    $display("----------------------\nCase Two: Unsigned Subtraction\n");
    unsigned_FA_Test(3, 2 , 1);

    // signed adds w/negative op
    $display("----------------------\nCase Three: Signed Addition with negatives\n");
    signed_FA_Test(3, -2 , 0);
    signed_FA_Test(-3, 2 , 0);

    // signed subs w/ negative op
    $display("----------------------\nCase Four: Signed Subtraction with negatives\n");
    signed_FA_Test(3, -6 , 1);
    signed_FA_Test(-3, 2 , 1);

    // case with produced carry-out (ie: overflow)
    $display("----------------------\nCase Five: Propagated carry-out\n");
    $display(">>> Case with NO carry-out");
    unsigned_FA_Test(1, 1 , 0);
    $display("\tCarry out: %b", Cout);
    
    
    $display(">>> Case with carry-out");
    unsigned_FA_Test(15, 2 , 0);
    $display("\tCarry out: %b", Cout);
  end

endmodule