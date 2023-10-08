module id_selector #(
	parameter QOS_WIDTH = 4,
	STREAM_COUNT = 2,
	ID_WIDTH = $clog2(STREAM_COUNT)
)(
	input logic clk,
	input logic rst,
	input logic [QOS_WIDTH-1:0] qos_i [STREAM_COUNT-1:0],
	input logic [STREAM_COUNT-1:0] valid_i,
	
	output logic [ID_WIDTH-1:0] id_o
);

integer i;
reg [QOS_WIDTH-1:0] max_qos;
reg [ID_WIDTH-1:0] max_qos_id;

initial begin
	i = 0;
	max_qos = 0;
	max_qos_id = 0;
end

always @(posedge clk) begin
	if (rst) begin
		i = 0;
	end	
end

always @* begin
	max_qos = 0;
	max_qos_id = 0;

	for (i = 0; i < STREAM_COUNT; i = i + 1) begin
		if (qos_i[i] > max_qos && valid_i[i] == 1) begin
			max_qos = qos_i[i];
			max_qos_id = i;
		end
		else if (qos_i[i] == 0 && valid_i[i] == 1) begin
			max_qos_id = i;
			break;
		end
	end
	
	id_o = max_qos_id;
end

endmodule