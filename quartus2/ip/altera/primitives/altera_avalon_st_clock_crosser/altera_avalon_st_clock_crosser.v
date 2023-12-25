`timescale 1ns / 1ns

module altera_avalon_st_clock_crosser(
                                 in_clk,
                                 in_reset,
                                 in_ready,
                                 in_valid,
                                 in_data,
                                 out_clk,
                                 out_reset,
                                 out_ready,
                                 out_valid,
                                 out_data
                                );

  parameter  SYMBOLS_PER_BEAT  = 1;
  parameter  BITS_PER_SYMBOL   = 8;
  parameter  FORWARD_SYNC_DEPTH = 2;
  parameter  BACKWARD_SYNC_DEPTH = 2;
  
  localparam  DATA_WIDTH = SYMBOLS_PER_BEAT * BITS_PER_SYMBOL;

  input                   in_clk;
  input                   in_reset;
  output                  in_ready;
  input                   in_valid;
  input  [DATA_WIDTH-1:0] in_data;

  input                   out_clk;
  input                   out_reset;
  input                   out_ready;
  output                  out_valid;
  output [DATA_WIDTH-1:0] out_data;

  // Data is guaranteed valid by control signal clock crossing.  Cut data
  // buffer false path.
  (* altera_attribute = {"-name SDC_STATEMENT \"set_false_path -from [get_registers *altera_avalon_st_clock_crosser:*|in_data_buffer*] -to [get_registers *altera_avalon_st_clock_crosser:*|out_data_buffer*]\""} *) reg    [DATA_WIDTH-1:0] in_data_buffer;
  reg    [DATA_WIDTH-1:0] out_data_buffer;

  reg                     in_data_toggle;
  wire                    in_data_toggle_returned;
  wire                    out_data_toggle;
  reg                     out_data_toggle_flopped;

  wire                    take_in_data;
  wire                    out_data_taken;

  wire                    out_valid_internal;
  wire                    out_ready_internal;

  assign in_ready = ~(in_data_toggle_returned ^ in_data_toggle);
  assign take_in_data = in_valid & in_ready;
  assign out_valid_internal = out_data_toggle ^ out_data_toggle_flopped;
  assign out_data_taken = out_ready_internal & out_valid_internal;

  always @(posedge in_clk or posedge in_reset) begin
    if (in_reset) begin
      in_data_buffer <= 'b0;
      in_data_toggle <= 1'b0;
    end else begin
      if (take_in_data) begin
        in_data_toggle <= ~in_data_toggle;
        in_data_buffer <= in_data;
      end
    end //in_reset
  end //in_clk always block

  always @(posedge out_clk or posedge out_reset) begin
    if (out_reset) begin
      out_data_toggle_flopped <= 1'b0;
      out_data_buffer <= 'b0;
    end else begin
      out_data_buffer <= in_data_buffer;
      if (out_data_taken) begin
        out_data_toggle_flopped <= out_data_toggle;
      end
    end //end if
  end //out_clk always block

  altera_std_synchronizer #(.depth(FORWARD_SYNC_DEPTH)) in_to_out_synchronizer (
				     .clk(out_clk),
				     .reset_n(~out_reset),
				     .din(in_data_toggle),
				     .dout(out_data_toggle)
				     );
  
  altera_std_synchronizer #(.depth(BACKWARD_SYNC_DEPTH)) out_to_in_synchronizer (
				     .clk(in_clk),
				     .reset_n(~in_reset),
				     .din(out_data_toggle_flopped),
				     .dout(in_data_toggle_returned)
				     );

  altera_avalon_st_pipeline_stage #(.BITS_PER_SYMBOL(BITS_PER_SYMBOL),
                             .SYMBOLS_PER_BEAT(SYMBOLS_PER_BEAT)) output_stage (
                                     .clk(out_clk),
                                     .reset(out_reset),
                                     .in_ready(out_ready_internal),
                                     .in_valid(out_valid_internal),
                                     .in_data(out_data_buffer),
                                     .out_ready(out_ready),
                                     .out_valid(out_valid),
                                     .out_data(out_data)
                                     );
endmodule
