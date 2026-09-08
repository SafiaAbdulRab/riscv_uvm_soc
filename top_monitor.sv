class top_monitor extends uvm_monitor;
  `uvm_component_utils(top_monitor)

  // Virtual Interface Handle
  virtual top_if vif;

  // Analysis Port to send sampled data to Scoreboard
  uvm_analysis_port #(seq_item) item_port;

  function new(string name = "top_monitor", uvm_component parent = null);
    super.new(name, parent);
    item_port = new("item_port", this);
  endfunction

  // Build Phase: Virtual Interface retrieve karna
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual top_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("MON", "Virtual Interface get karne mein fail ho gaya!")
    end
  endfunction

  // Run Phase: Interface signals ko sample karna
  virtual task run_phase(uvm_phase phase);
  wait(vif.rst == 1'b1);
  
  forever begin
    seq_item item;
    
    @(posedge vif.clk);
    #1ns; // Step to verify: RTL ko signal update karne ka time milega
    
    item = seq_item::type_id::create("item");
    item.instruct_en = vif.instruct_en;
    item.result      = vif.result;
    
    item_port.write(item);
  end
endtask

endclass



