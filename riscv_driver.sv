class riscv_driver extends uvm_component;   // uvm_driver nahi - kyunke sequencer se kuch nahi lena
  `uvm_component_utils(riscv_driver)

  virtual riscv_if vif;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual riscv_if)::get(this, "", "vif", vif))
      `uvm_fatal("DRIVER", "Failed to get vif")
  endfunction

  // ------ HARDCODED INSTRUCTIONS YAHIN HAIN ------
  bit [31:0] instr_array[3] = '{
    32'h00500093,   // addi x1, x0, 5
    32'h00600113,   // addi x2, x0, 6
    32'h002081b3    // add  x3, x1, x2
  };

  task run_phase(uvm_phase phase);
    // --- Reset ---
    vif.instruct_en = 1'b0;
    vif.instruction = 32'h0;
    repeat (2) @(posedge vif.clk);

    // --- Hardcoded instructions seedha DUT ko drive karo ---
    foreach (instr_array[i]) begin
      @(posedge vif.clk);
      vif.instruct_en <= 1'b1;
      vif.instruction <= instr_array[i];
    end

    // --- Enable off, pipeline drain hone do ---
    @(posedge vif.clk);
    vif.instruct_en <= 1'b0;
    vif.instruction <= 32'h0;
    repeat (6) @(posedge vif.clk);

  endtask
endclass
