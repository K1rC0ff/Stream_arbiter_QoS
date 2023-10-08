
`timescale 1ns / 1ns
module testbench #(
	parameter STREAM_COUNT  = 2,
	T_QOS__WIDTH  = 4,
	T_DATA_WIDTH  = 8,
	T_ID___WIDTH  = 1
)(
	output logic [T_DATA_WIDTH-1:0]  m_data_o,
	output logic [T_QOS__WIDTH-1:0]  m_qos_o,
	output logic  m_last_o,
	output logic  m_valid_o,
	output logic [STREAM_COUNT-1:0]  s_ready_o,
	output logic [T_ID___WIDTH-1:0]  m_id_o
) ; 
 
  reg clk;
  reg rst_n;
  reg  [T_DATA_WIDTH-1:0]  s_data_i [STREAM_COUNT-1:0];
  reg  [T_QOS__WIDTH-1:0]  s_qos_i [STREAM_COUNT-1:0]; 
  reg  [STREAM_COUNT-1:0]  s_last_i   ; 
  reg  [STREAM_COUNT-1:0]  s_valid_i   ;
  reg  m_ready_i;
  
  stream_arbiter    #( .STREAM_COUNT(STREAM_COUNT) , .T_QOS__WIDTH(T_QOS__WIDTH) , .T_DATA_WIDTH(T_DATA_WIDTH) , .T_ID___WIDTH(T_ID___WIDTH)  )
   DUT  ( 
       .m_ready_i (m_ready_i ) ,
      .s_data_i (s_data_i) ,
      .m_data_o (m_data_o ) ,
      .s_qos_i (s_qos_i) ,
      .m_qos_o (m_qos_o ) ,
      .rst_n (rst_n ) ,
      .s_last_i (s_last_i ) ,
      .m_last_o (m_last_o ) ,
      .clk (clk ) ,
      .s_valid_i (s_valid_i ) ,
      .m_valid_o (m_valid_o ) ,
      .s_ready_o (s_ready_o ) ,
      .m_id_o (m_id_o ) 
	); 

	
  always #10 clk = ~clk;
  	
  initial
  begin
	  clk = 0;
	  rst_n = 0;
	  m_ready_i = 1'b1;
	  s_valid_i = 2'b00;
	  s_last_i = 2'b00;
	  s_qos_i[0] = 4'h0;
	  s_qos_i[1] = 4'h0;
	  s_data_i[0] = 8'h00;
	  s_data_i[1] = 8'h00;
	  
	  #60
	  
	  s_valid_i = 2'b11;
	  
	  s_qos_i[0] = 4'h3;
	  s_data_i[0] = 8'hAA;
	  
	  s_qos_i[1] = 4'h2;
	  s_data_i[1] = 8'hCC;
	  
	  #20
	  
	  s_data_i[0] = 8'hBB;
	  s_last_i = 2'b01;
	  
	  #20
	  
	  s_qos_i[0] = 4'h0;
	  s_data_i[0] = 8'h0;
	  s_valid_i = 2'b10;
	  s_last_i = 2'b0;
	  
	  #20
	  
	  s_last_i = 2'b10;
	  s_data_i[1] = 8'hDD;
	  
	  #20
	  
	  s_valid_i = 2'b00;
	  s_last_i = 2'b00;
	  s_qos_i[0] = 4'h0;
	  s_qos_i[1] = 4'h0;
	  s_data_i[0] = 8'h00;
	  s_data_i[1] = 8'h00;
	  
	  #60 $stop;
	  
	    end

endmodule
