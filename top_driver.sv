class top_driver extends uvm_driver #(seq_item);
  `uvm_component_utils(top_driver)

  virtual top_if vif;

  function new(string name = "top_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual top_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("DRV", "Failed to get Virtual Interface in Driver")
    end
  endfunction

  virtual task run_phase(uvm_phase phase);
    // 1. Local Hardcoded Instructions Array inside run_phase
    bit [31:0] hardcoded_instr[3];
    hardcoded_instr[0] = 32'h00500093; // addi x1, x0, 5
    hardcoded_instr[1] = 32'h00500113; // addi x2, x0, 5
    hardcoded_instr[2] = 32'h002081b3; // add  x3, x1, x2 (Result = 10)

    // 2. Initial Signals Driving
    vif.rst         <= 1'b0;
    vif.instruct_en <= 1'b0;
    vif.instruction <= 32'h00000013; // Default NOP

    // 3. Reset hold for 2 cycles
    repeat(2) @(posedge vif.clk);
    vif.rst <= 1'b1;

    // 4. Directly driving the hardcoded instructions
    foreach (hardcoded_instr[i]) begin
      @(posedge vif.clk);
      vif.instruct_en <= 1'b1;
      vif.instruction <= hardcoded_instr[i];
    end

    // 5. Drive NOPs to flush the CPU pipeline
    repeat(10) begin
      @(posedge vif.clk);
      vif.instruct_en <= 1'b1;
      vif.instruction <= 32'h00000013; // NOP
    end

    // 6. Disable instruction enable
    @(posedge vif.clk);
    vif.instruct_en <= 1'b0;

  endtask

endclass
