module DC #(
	parameter STREAM_COUNT = 2,
	ID_WIDTH = $clog2(STREAM_COUNT)
)(
	input enable,
	input [ID_WIDTH-1:0] data,
	output [STREAM_COUNT-1:0] Q
);

assign Q = !enable ? 0 : 1 << data;

endmodule