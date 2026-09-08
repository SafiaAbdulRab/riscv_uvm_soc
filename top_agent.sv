class top_agent extends uvm_agent;
  `uvm_component_utils(top_agent)

  // Sub-components handles
  top_sequencer sequencer;
  top_driver    driver;
  top_monitor   monitor;

  function new(string name = "top_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // Build Phase: Sub-components create karna
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    // Monitor meshamesha create hota hai (Active aur Passive dono mode mein)
    monitor = top_monitor::type_id::create("monitor", this);
    
    // Agar agent Active mode mein hai, toh Driver aur Sequencer bhi banenge
    if (get_is_active() == UVM_ACTIVE) begin
      sequencer = top_sequencer::type_id::create("sequencer", this);
      driver    = top_driver::type_id::create("driver", this);
    end
  endfunction

  // Connect Phase: Driver aur Sequencer ko connect karna
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    if (get_is_active() == UVM_ACTIVE) begin
      driver.seq_item_port.connect(sequencer.seq_item_export);
    end
  endfunction

endclass

