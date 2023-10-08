module MUX #(
	parameter DATA_WIDTH = 8,
	STREAM_COUNT = 2,
	ADRESS_WIDTH = $clog2(STREAM_COUNT)
)(
	input logic [DATA_WIDTH-1:0] data [STREAM_COUNT-1:0],
	input logic [ADRESS_WIDTH-1:0] adress,
	
	output logic [DATA_WIDTH-1:0] Q
);

assign Q = data[adress];

endmodule