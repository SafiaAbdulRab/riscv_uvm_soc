`include "uvm_macros.svh"
import uvm_pkg::*;
import pkg::*; // Package import yahan zaroori hai

module tb_top;

  bit clk;
  always #5 clk = ~clk;

  top_if intf(clk);

  topmodule DUT (
    .result      (intf.result),
    .rst         (intf.rst),
    .clk         (intf.clk),
    .instruct_en (intf.instruct_en)
  );

  initial begin
    uvm_config_db#(virtual top_if)::set(null, "*", "vif", intf);
    
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_top);

    run_test("top_test");
  end

endmodule
