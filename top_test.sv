class top_test extends uvm_test;
  `uvm_component_utils(top_test)

  top_env env;

  function new(string name = "top_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = top_env::type_id::create("env", this);
  endfunction

  virtual task run_phase(uvm_phase phase);

    phase.raise_objection(this);

    // Let the hardcoded instructions from instr.mem run
    repeat(25) @(posedge env.agent.driver.vif.clk);

    phase.drop_objection(this);

  endtask

endclass
