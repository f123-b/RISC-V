// Portable examples to bind around a CORE-V instruction/data interface wrapper.
module core_protocol_properties (
  input logic clk_i,
  input logic rst_ni,
  input logic instr_req,
  input logic instr_gnt,
  input logic data_req,
  input logic data_gnt
);
  instr_request_eventually_granted: assert property (@(posedge clk_i) disable iff (!rst_ni)
    instr_req |-> ##[0:16] instr_gnt);
  data_request_eventually_granted: assert property (@(posedge clk_i) disable iff (!rst_ni)
    data_req |-> ##[0:16] data_gnt);
endmodule
