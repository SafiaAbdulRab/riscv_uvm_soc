// 1. Sequencer Typedef (seq_item use kar rahe hain)
typedef uvm_sequencer #(seq_item) top_sequencer;

// 2. Base Sequence
class top_sequence extends uvm_sequence #(seq_item);
  `uvm_object_utils(top_sequence)

  function new(string name = "top_sequence");
    super.new(name);
  endfunction

  virtual task body();
    seq_item item;
    
    repeat(50) begin // 50 transactions generate karega
      item = seq_item::type_id::create("item");
      
      start_item(item);
      
      if (!item.randomize()) begin
        `uvm_error("SEQ", "Randomization failed!")
      end
      
      finish_item(item);
    end
  endtask
endclass


