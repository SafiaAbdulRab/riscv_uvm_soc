interface riscv_if(input logic clk,input logic rst);
    logic        instruct_en;
    logic [31:0] instruction;     // to drive instruction from driver
    logic [31:0] result;
endinterface
