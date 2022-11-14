module AVS_AVALONSLAVE #
(
  // you can add parameters here
  // you can change these parameters
  parameter integer AVS_AVALONSLAVE_DATA_WIDTH = 32,
  parameter integer AVS_AVALONSLAVE_ADDRESS_WIDTH = 4
)
(
  // user ports begin
  output [AVS_AVALONSLAVE_DATA_WIDTH - 1:0] slv_reg0_output_interface,
  output [AVS_AVALONSLAVE_DATA_WIDTH - 1:0] slv_reg1_output_interface,
  output [AVS_AVALONSLAVE_DATA_WIDTH - 1:0] slv_reg2_output_interface,
  output [AVS_AVALONSLAVE_DATA_WIDTH - 1:0] slv_reg3_output_interface,
  output wire START,
  input wire DONE,

  // user ports end
  // dont change these ports
  //output [AVS_AVALONSLAVE_DATA_WIDTH-1:0]COE_CONDUIT_REG0,
  input wire CSI_CLOCK_CLK,
  input wire CSI_CLOCK_RESET,
  input wire [AVS_AVALONSLAVE_ADDRESS_WIDTH - 1:0] AVS_AVALONSLAVE_ADDRESS,
  output wire AVS_AVALONSLAVE_WAITREQUEST,
  input wire AVS_AVALONSLAVE_READ,
  input wire AVS_AVALONSLAVE_WRITE,
  output wire [AVS_AVALONSLAVE_DATA_WIDTH - 1:0] AVS_AVALONSLAVE_READDATA,
  input wire [AVS_AVALONSLAVE_DATA_WIDTH - 1:0] AVS_AVALONSLAVE_WRITEDATA
);

  // output wires and registers
  // you can change name and type of these ports
  wire start;

  wire wait_request;
  assign wait_request = 1'b0;
  reg [AVS_AVALONSLAVE_DATA_WIDTH - 1:0] read_data;

  // these are slave registers. they MUST be here!
  reg [AVS_AVALONSLAVE_DATA_WIDTH - 1:0] slv_reg0;
  reg [AVS_AVALONSLAVE_DATA_WIDTH - 1:0] slv_reg1;
  reg [AVS_AVALONSLAVE_DATA_WIDTH - 1:0] slv_reg2;
  reg [AVS_AVALONSLAVE_DATA_WIDTH - 1:0] slv_reg3;
  //assign COE_CONDUIT_REG0 = slv_reg0;

  // I/O assignment
  // never directly send values to output
  assign START = start;

  assign AVS_AVALONSLAVE_WAITREQUEST = wait_request;
  assign AVS_AVALONSLAVE_READDATA = read_data;

  assign slv_reg0_output_interface = slv_reg0;
  assign slv_reg1_output_interface = slv_reg1;
  assign slv_reg2_output_interface = slv_reg2;
  assign slv_reg3_output_interface = slv_reg3;

  assign start = slv_reg0[0];

  // it is an example and you can change it or delete it completely
  always @(posedge CSI_CLOCK_CLK, posedge CSI_CLOCK_RESET)
  begin
    if(CSI_CLOCK_RESET == 1)
    begin
      slv_reg0 <= 0;
      slv_reg1 <= 0;
      slv_reg2 <= 0;
      slv_reg3 <= 0;
    end
    else  begin
      slv_reg0[31] <= DONE;
      if(AVS_AVALONSLAVE_WRITE) begin
        // address is bytewise, it must be devided by 4
        case(AVS_AVALONSLAVE_ADDRESS >> 2)
        0: slv_reg0[30:0] <= AVS_AVALONSLAVE_WRITEDATA[30:0];
        1: slv_reg1 <= AVS_AVALONSLAVE_WRITEDATA;
        2: slv_reg2 <= AVS_AVALONSLAVE_WRITEDATA;
        3: slv_reg3 <= AVS_AVALONSLAVE_WRITEDATA;
        default:
        begin
          slv_reg0[30:0] <= slv_reg0[30:0];
          slv_reg1 <= slv_reg1;
          slv_reg2 <= slv_reg2;
          slv_reg3 <= slv_reg3;
        end
        endcase
      end
    end
  end

  always @(*) begin
    case(AVS_AVALONSLAVE_ADDRESS >> 2)
      0:  read_data = slv_reg0;
      1:  read_data = slv_reg1;
      2:  read_data = slv_reg2;
      3:  read_data = slv_reg3;
      default :  read_data = {AVS_AVALONSLAVE_DATA_WIDTH{1'b0}};
    endcase
  end

endmodule
