interface top_if(input logic clk);
    logic        rst;
    logic        instruct_en;
    logic [31:0] instruction; // Direct Driver Instruction Driving
    logic [31:0] result;
endinterface
