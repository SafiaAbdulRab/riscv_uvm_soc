class riscv_sequence extends uvm_sequence #(seqs_item);
  `uvm_object_utils(riscv_sequence)
 
  bit [31:0] instr_list[] = '{
    32'h00500093,   // addi x1, x0, 5
    32'h00600113,   // addi x2, x0, 6
    32'h002081b3    // add  x3, x1, x2
  };
 
  function new(string name = "riscv_sequence");
    super.new(name);
  endfunction
 
  task body();
    seqs_item req;
    foreach (instr_list[i]) begin
      req = seqs_item::type_id::create("req");
      start_item(req);
      if (!req.randomize() with { instruction == instr_list[i]; })
        `uvm_error("SEQ", "Randomization failed")
      finish_item(req);
    end
  endtask
endclass
