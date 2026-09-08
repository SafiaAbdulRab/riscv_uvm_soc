class top_env extends uvm_env;
  `uvm_component_utils(top_env)

  // Agent aur Scoreboard ke handles
  top_agent      agent;
  top_scoreboard scoreboard;

  function new(string name = "top_env", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build Phase: Agent aur Scoreboard create karna
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agent      = top_agent::type_id::create("agent", this);
    scoreboard = top_scoreboard::type_id::create("scoreboard", this);
  endfunction

  // Connect Phase: Monitor ka item_port Scoreboard ke item_imp se connect karna
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agent.monitor.item_port.connect(scoreboard.item_imp);
  endfunction

endclass

