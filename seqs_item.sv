class seqs_item extends uvm_sequence_item;

	rand logic instruct_en;
	logic [31:0] instruction; 
//constraints remaining
constraint c_instruction_en{ instruction_en{1:=70,0:=30};}

`uvm_object_utlis(seqs_item)

function new(string name="seqs_item");
super.new(name);
endfunction
endclass
