module AVM_AVALONMASTER_MAGNITUDE #
(
  // you can add parameters here
  // you can change these parameters
  parameter integer AVM_AVALONMASTER_DATA_WIDTH = 32,
  parameter integer AVM_AVALONMASTER_ADDRESS_WIDTH = 32
)
(
  // user ports begin

  // these are just some example ports. you can change them all
  input wire START,
  output wire DONE,
  input[AVM_AVALONMASTER_ADDRESS_WIDTH - 1:0] addr_in,
  input[AVM_AVALONMASTER_DATA_WIDTH - 1:0] write_data,
  output[AVM_AVALONMASTER_DATA_WIDTH - 1:0] read_data,
  input read_req,
  input write_req,

  // user ports end
  // dont change these ports
  input wire CSI_CLOCK_CLK,
  input wire CSI_CLOCK_RESET,
  output wire [AVM_AVALONMASTER_ADDRESS_WIDTH - 1:0] AVM_AVALONMASTER_ADDRESS,
  input wire AVM_AVALONMASTER_WAITREQUEST,
  output wire AVM_AVALONMASTER_READ,
  output wire AVM_AVALONMASTER_WRITE,
  input wire [AVM_AVALONMASTER_DATA_WIDTH - 1:0] AVM_AVALONMASTER_READDATA,
  output wire [AVM_AVALONMASTER_DATA_WIDTH - 1:0] AVM_AVALONMASTER_WRITEDATA
);
  localparam s0 = 3'd0, s1_r = 3'd1, s1_w = 3'd2, s2 = 3'd3;

  // output wires and registers
  // you can change name and type of these ports
  reg[AVM_AVALONMASTER_DATA_WIDTH-1 : 0] data;
  reg done = 1'b0;
  reg read = 1'b0;
  reg write = 1'b0;
  reg[2:0] state = s0;

  // I/O assignment
  // never directly send values to output
  assign DONE = done;
  assign AVM_AVALONMASTER_ADDRESS = (addr_in);
  assign AVM_AVALONMASTER_READ = read;
  assign AVM_AVALONMASTER_WRITE = write;
  assign AVM_AVALONMASTER_WRITEDATA = write_data;
  assign read_data = data;

  /****************************************************************************
  * all main function must be here or in main module. you MUST NOT use control
  * interface for the main operation and only can import and export some wires
  * from/to it
  ****************************************************************************/

  // user logic begin
  always @(posedge CSI_CLOCK_CLK, posedge CSI_CLOCK_RESET) begin
    if(CSI_CLOCK_RESET == 1) begin
      state <= s0;
      data <= {AVM_AVALONMASTER_DATA_WIDTH{1'b0}};
    end
    else begin
      case(state)
        s0 : begin
          if(START) begin
            if(write_req)
              state <= s1_w;
            else if(read_req)
              state <= s1_r;
            else
              state <= s0;
          end
        end

        s1_r : begin
          if(AVM_AVALONMASTER_WAITREQUEST == 1'b1)
            state <= s1_r;
          else begin
            data <= AVM_AVALONMASTER_READDATA;
            state <= s2;
          end
        end

        s1_w : begin
          if(AVM_AVALONMASTER_WAITREQUEST == 1'b1)
            state <= s1_w;
          else
            state <= s2;
        end

        s2 : state <= s0;
      endcase
    end
  end

  always @(*) begin
    read = 1'b0;
    write = 1'b0;
    done = 1'b0;
    case(state)
      s1_r : read = 1'b1;
      s1_w : write = 1'b1;
      s2 : done = 1'b1;
    endcase
  end

  // user logic end

endmodule
