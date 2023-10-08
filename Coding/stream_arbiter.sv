module stream_arbiter #(
  parameter T_DATA_WIDTH = 8,
  T_QOS__WIDTH = 4,
  STREAM_COUNT = 2,
  T_ID___WIDTH = $clog2(STREAM_COUNT)
)(
  input logic clk,
  input logic rst_n,
  // input streams
  input logic [T_DATA_WIDTH-1:0] s_data_i [STREAM_COUNT-1:0],
  input logic [T_QOS__WIDTH-1:0] s_qos_i [STREAM_COUNT-1:0],
  input logic [STREAM_COUNT-1:0] s_last_i ,
  input logic [STREAM_COUNT-1:0] s_valid_i,
  output logic [STREAM_COUNT-1:0] s_ready_o,
  // output stream
  output logic [T_DATA_WIDTH-1:0] m_data_o,
  output logic [T_QOS__WIDTH-1:0] m_qos_o,
  output logic [T_ID___WIDTH-1:0] m_id_o,
  output logic m_last_o,
  output logic m_valid_o,
  input logic m_ready_i
);

wire [STREAM_COUNT-1:0] dc_out;

id_selector #(.QOS_WIDTH(T_QOS__WIDTH), .STREAM_COUNT(STREAM_COUNT)) selector (.clk(clk), .rst(rst_n), .qos_i(s_qos_i), .valid_i(s_valid_i), .id_o(m_id_o));

MUX #(.DATA_WIDTH(T_QOS__WIDTH), .STREAM_COUNT(STREAM_COUNT)) qos_mux (.data(s_qos_i), .adress(m_id_o), .Q(m_qos_o));
MUX #(.DATA_WIDTH(T_DATA_WIDTH), .STREAM_COUNT(STREAM_COUNT)) data_mux (.data(s_data_i), .adress(m_id_o), .Q(m_data_o));

DC #(.STREAM_COUNT(STREAM_COUNT)) ready_dc (.enable(m_ready_i), .data(m_id_o), .Q(dc_out));
assign s_ready_o = s_valid_i & dc_out;

assign m_last_o = s_last_i ? 1 : 0;

assign m_valid_o = s_valid_i ? 1 : 0;

endmodule