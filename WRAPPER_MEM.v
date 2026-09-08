module wrapper_mem (
    wrapper_mem_o_for_data_mem_i,
    wrapper_mem_o,
    wrapper_mem_i,
    instruction,
    mem_write,
    store_op,
    mem_read,
    mem_addr,
    clk,
    rst,

    snoop_invalidate,
    snoop_addr,
    write_commit,
    write_commit_addr,
    mem_ready,

    HADDR,
    HWRITE,
    HTRANS,
    HSIZE,
    HWDATA,
    HRDATA,
    HREADY,
    HRESP
 );
 input wire [31:0]                 instruction;
 input wire [13:0]                    mem_addr;
 output reg [3:0]                     store_op;
 wire [31:0]                        data_mem_o;
 input wire [31:0]               wrapper_mem_i;
 output reg [31:0]               wrapper_mem_o;
 input wire                          mem_write;
 input wire                           mem_read;
 input wire                                clk;
 input wire                                rst;
 output reg [31:0]wrapper_mem_o_for_data_mem_i;

 input wire        snoop_invalidate;
 input wire [5:0]  snoop_addr;
 output wire       write_commit;
 output wire [5:0] write_commit_addr;
 output wire       mem_ready;

 output wire [31:0] HADDR;
 output wire        HWRITE;
 output wire [1:0]  HTRANS;
 output wire [2:0]  HSIZE;
 output wire [31:0] HWDATA;
 input  wire [31:0] HRDATA;
 input  wire        HREADY;
 input  wire        HRESP;

 // (existing always@(*) block for store_op / wrapper_mem_o /
 //  wrapper_mem_o_for_data_mem_i is unchanged from before)

     data_mem u_dm (
       .clk               (clk),
       .rst               (rst),
       .mem_addr          (mem_addr[7:2]),
       .mem_read          (mem_read),
       .mem_write         (mem_write),
       .data_mem_i        (wrapper_mem_o_for_data_mem_i),
       .data_mem_o        (data_mem_o),
       .write_mask        (store_op),
       .mem_ready         (mem_ready),
       .snoop_invalidate  (snoop_invalidate),
       .snoop_addr        (snoop_addr),
       .HADDR             (HADDR),
       .HWRITE            (HWRITE),
       .HTRANS            (HTRANS),
       .HSIZE             (HSIZE),
       .HWDATA            (HWDATA),
       .HRDATA            (HRDATA),
       .HREADY            (HREADY),
       .HRESP             (HRESP)
     );

endmodule
