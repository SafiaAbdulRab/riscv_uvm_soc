class top_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(top_scoreboard)

  uvm_analysis_imp #(seq_item, top_scoreboard) item_imp;

  // Verification metrics
  int match_count = 0;
  int mismatch_count = 0;

  function new(string name = "top_scoreboard", uvm_component parent = null);
    super.new(name, parent);
    item_imp = new("item_imp", this);
  endfunction

  virtual function void write(seq_item item);
    `uvm_info("SCB", $sformatf("Recv Transaction: instruct_en = %0b | result = 0x%08h", 
                              item.instruct_en, item.result), UVM_LOW)

    // Example Checking Logic (Apne testbench logic ke mutabiq adjust karein)
    if (item.instruct_en) begin
      // Yahan expected result calculate karein ya reference model se compare karein
      // Example check:
      if (item.result != 32'h0) begin
        `uvm_info("SCB_MATCH", $sformatf("PASS! Valid result observed: 0x%08h", item.result), UVM_LOW)
        match_count++;
      end else begin
        `uvm_warning("SCB_ZERO", "Instruction enabled but result is zero/null.")
      end
    end
  endfunction

  // Simulation ke end par summary print karne ke liye phase
  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("SCB_SUMMARY", $sformatf("Matches: %0d | Mismatches: %0d", match_count, mismatch_count), UVM_LOW)
  endfunction

endclass
