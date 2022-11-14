module accelerator #
(
  // you can add parameters here
  // you can change these parameters

  // control interface parameters
  parameter integer avs_avalonslave_data_width = 32,
  parameter integer avs_avalonslave_address_width = 4,

  // control interface parameters
  parameter integer avm_avalonmaster_data_width = 32,
  parameter integer avm_avalonmaster_address_width = 32
)
(
  // user ports begin

  // user ports end
  // dont change these ports

  // clock and reset
  input wire csi_clock_clk,
  input wire csi_clock_reset,

  // control interface ports

  input wire [avs_avalonslave_address_width - 1:0] avs_avalonslave_address,
  output wire avs_avalonslave_waitrequest,
  input wire avs_avalonslave_read,
  input wire avs_avalonslave_write,
  output wire [avs_avalonslave_data_width - 1:0] avs_avalonslave_readdata,
  input wire [avs_avalonslave_data_width - 1:0] avs_avalonslave_writedata,

  // magnitude interface ports
  output wire [avm_avalonmaster_address_width - 1:0] avm_avalonmaster_address,
  input wire avm_avalonmaster_waitrequest,
  output wire avm_avalonmaster_read,
  output wire avm_avalonmaster_write,
  input wire [avm_avalonmaster_data_width - 1:0] avm_avalonmaster_readdata,
  output wire [avm_avalonmaster_data_width - 1:0] avm_avalonmaster_writedata
);
//states parameter
localparam s0 = 4'd0, s1 = 4'd1, s2 = 4'd2, s3 = 4'd3, s4 = 4'd4, s5 = 4'd5, s6 = 4'd6, s7 = 4'd7, s8 = 4'd8, s9 = 4'd9, s10 = 4'd10, s11 = 4'd11;
//

// define your extra ports as wire here

reg[avm_avalonmaster_address_width-1 : 0] addr_read_data_right = {avm_avalonmaster_address_width{1'b0}};
reg[avm_avalonmaster_address_width-1 : 0] addr_read_data_left = {avm_avalonmaster_address_width{1'b0}};
reg[avm_avalonmaster_address_width-1 : 0] addr_write_data = {avm_avalonmaster_address_width{1'b0}};
reg[18:0] read_iteration = 19'b0;
wire read_iteration_cmp_res;
reg[10:0] write_iteration = 11'b0;
wire write_iteration_cmp_res;


//acc signals
reg[(2*avm_avalonmaster_data_width) - 1:0] acc = {(2*avm_avalonmaster_data_width){1'b0}};

//slave signals

wire[avs_avalonslave_data_width - 1:0] slv_reg0;
wire[avs_avalonslave_data_width - 1:0] slv_reg1;
wire[avs_avalonslave_data_width - 1:0] slv_reg2;
wire[avs_avalonslave_data_width - 1:0] slv_reg3;
reg slave_done = 1'b0;
wire slave_start;
reg[10:0] num_of_portion = 11'd0;
reg[18:0] size_of_portion = 19'd0;

//master signals
reg master_start = 1'b0;
wire master_done;
reg[avm_avalonmaster_address_width - 1:0] addr_to_master = {avm_avalonmaster_address_width{1'b0}};
wire[avm_avalonmaster_data_width-1 : 0]data_from_master;
wire[avm_avalonmaster_data_width-1:0] abs_data;
reg[avm_avalonmaster_data_width - 1 : 0] data_to_master = {avm_avalonmaster_address_width{1'b0}};
reg master_read_req;
reg master_write_req;



//states
reg[3:0] state = 4'd0;
reg[avm_avalonmaster_data_width-1 : 0] captured_data = {avm_avalonmaster_data_width{1'b0}};


//
//

// control interface instanciation
AVS_AVALONSLAVE #
(
  // you can add parameters here
  // you can change these parameters
  .AVS_AVALONSLAVE_DATA_WIDTH(avs_avalonslave_data_width),
  .AVS_AVALONSLAVE_ADDRESS_WIDTH(avs_avalonslave_address_width)
) AVS_AVALONSLAVE_INST // instance  of module must be here
(
  // user ports begin
  .START(slave_start),
  .DONE(slave_done),
  .slv_reg0_output_interface(slv_reg0),
  .slv_reg1_output_interface(slv_reg1),
  .slv_reg2_output_interface(slv_reg2),
  .slv_reg3_output_interface(slv_reg3),
  // user ports end
  // dont change these ports
  //.COE_CONDUIT_REG0(coe_conduit_reg0),
  .CSI_CLOCK_CLK(csi_clock_clk),
  .CSI_CLOCK_RESET(csi_clock_reset),
  .AVS_AVALONSLAVE_ADDRESS(avs_avalonslave_address),
  .AVS_AVALONSLAVE_WAITREQUEST(avs_avalonslave_waitrequest),
  .AVS_AVALONSLAVE_READ(avs_avalonslave_read),
  .AVS_AVALONSLAVE_WRITE(avs_avalonslave_write),
  .AVS_AVALONSLAVE_READDATA(avs_avalonslave_readdata),
  .AVS_AVALONSLAVE_WRITEDATA(avs_avalonslave_writedata)
);

// magnitude interface instanciation
AVM_AVALONMASTER_MAGNITUDE #
(
  // you can add parameters here
  // you can change these parameters
  .AVM_AVALONMASTER_DATA_WIDTH(avm_avalonmaster_data_width),
  .AVM_AVALONMASTER_ADDRESS_WIDTH(avm_avalonmaster_address_width)
) AVM_AVALONMASTER_MAGNITUDE_INST // instance  of module must be here
(
  // user ports begin
  .START(master_start),
  .DONE(master_done),
  .addr_in(addr_to_master),
  .write_data(data_to_master),
  .read_data(data_from_master),
  .read_req(master_read_req),
  .write_req(master_write_req),
  // user ports end
  // dont change these ports
  .CSI_CLOCK_CLK(csi_clock_clk),
  .CSI_CLOCK_RESET(csi_clock_reset),
  .AVM_AVALONMASTER_ADDRESS(avm_avalonmaster_address),
  .AVM_AVALONMASTER_WAITREQUEST(avm_avalonmaster_waitrequest),
  .AVM_AVALONMASTER_READ(avm_avalonmaster_read),
  .AVM_AVALONMASTER_WRITE(avm_avalonmaster_write),
  .AVM_AVALONMASTER_READDATA(avm_avalonmaster_readdata),
  .AVM_AVALONMASTER_WRITEDATA(avm_avalonmaster_writedata)
);


assign read_iteration_cmp_res = (read_iteration < size_of_portion);
assign write_iteration_cmp_res = (write_iteration < num_of_portion);
assign abs_data = (captured_data[31] == 1'b1) ? ((~captured_data) + 32'd1) : captured_data;
always @(posedge csi_clock_clk, posedge csi_clock_reset) begin
  if(csi_clock_reset == 1'b1) begin
    state <= s0;
    data_to_master <= {avm_avalonmaster_data_width{1'b0}};
    addr_to_master <= {avm_avalonmaster_data_width{1'b0}};
    num_of_portion <= 11'd0;
    size_of_portion <= 19'd0;
    addr_write_data <= {avm_avalonmaster_address_width{1'b0}};
    addr_read_data_left <= {avm_avalonmaster_address_width{1'b0}};
    addr_read_data_right <= {avm_avalonmaster_address_width{1'b0}};
    captured_data <= {avm_avalonmaster_data_width{1'b0}};
    acc <= {(2*avm_avalonmaster_data_width){1'b0}};
    read_iteration <= 19'd0;
    write_iteration <= 11'd0;
  end
  else begin
    case(state)
      s0 : begin
        if(slave_start == 1'b1)begin
          state <= s1;
          size_of_portion <= slv_reg0[30:12];
          num_of_portion <= slv_reg0[11:1];
          addr_write_data <= slv_reg3;
          addr_read_data_right <= slv_reg1;
          addr_read_data_left <= slv_reg2;
          acc <= {(2*avm_avalonmaster_data_width){1'b0}};
          read_iteration <= 19'd0;
          write_iteration <= 11'd0;
        end
      end
      s1 : begin
        if(slave_start == 1'b0)
          state <= s2;
      end
      s2 : begin
        addr_to_master <= addr_read_data_right;
        addr_read_data_right <= addr_read_data_right + 32'd4;
        state <= s3;
        read_iteration <= read_iteration + 19'd1;
      end
      s3 : state <= s4;
      s4 : begin
        if(master_done == 1'b1) begin
          state <= s5;
          captured_data <= data_from_master;
        end
      end
      s5 : begin
        acc <= acc + {{avm_avalonmaster_data_width{1'b0}}, abs_data};
        if(read_iteration_cmp_res == 1'b1)
          state <= s2;
        else
          state <= s6;
      end
      s6 : begin
        write_iteration <= write_iteration + 11'd1;
        data_to_master <= acc[31:0];
        addr_to_master <= addr_write_data;
        addr_write_data <= addr_write_data + 32'd4;
        state <= s7;
      end
      s7 : state <= s8;
      s8 : begin
        if(master_done == 1'b1)
          state <= s9;
      end
      s9 : begin
        data_to_master <= acc[63:32];
        addr_to_master <= addr_write_data;
        addr_write_data <= addr_write_data + 32'd4;
        state <= s10;
      end
      s10 : state <= s11;
      s11 : begin
        if(master_done == 1'b1) begin
          read_iteration <= 19'd0;
          acc <= {(2*avm_avalonmaster_data_width){1'b0}};
          if(write_iteration_cmp_res == 1'b1)
            state <= s2;
          else
            state <= s0;
        end
      end
    endcase
  end
end


always @(*) begin
  slave_done = 1'b0;
  master_start = 1'b0;
  master_read_req = 1'b0;
  master_write_req = 1'b0;
  case(state)
    s0 :
      slave_done = 1'b1;
    s3 : begin
      master_read_req = 1'b1;
      master_start = 1'b1;
    end
    s7 : begin
      master_write_req = 1'b1;
      master_start = 1'b1;
    end
    s10 : begin
      master_write_req = 1'b1;
      master_start = 1'b1;
    end
  endcase
end

endmodule
