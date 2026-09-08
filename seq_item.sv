class seq_item extends uvm_sequence_item;
  rand bit        instruct_en;
  rand bit [31:0] instr;       // Check karein ke naam 'instr' hi hai
       bit [31:0] result;

  `uvm_object_utils_begin(seq_item)
    `uvm_field_int(instruct_en, UVM_ALL_ON)
    `uvm_field_int(instr,       UVM_ALL_ON)
    `uvm_field_int(result,      UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "seq_item");
    super.new(name);
  endfunction
endclass
