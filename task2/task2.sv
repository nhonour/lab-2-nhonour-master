module task2(input logic CLOCK_50, input logic KEY[3:0], // KEY[3] is async active-low reset
             output logic [9:0] VGA_R, output logic [9:0] VGA_G, output logic [9:0] VGA_B,
             output logic VGA_HS, output logic VGA_VS,
             output logic VGA_BLANK, output logic VGA_SYNC, output logic VGA_CLK);
  
    // instantiate and connect the VGA adapter and your module
	
reg start, plot;
wire done;
wire [7:0] xcoor;
wire [6:0] ycoor;
wire [2:0] colour;

always_ff @(posedge CLOCK_50)
begin
if (KEY[3] == 0)
	start = 1;
if (done == 1)
	start = 0;
end	
	
fillscreen fill(.clk(CLOCK_50), .rstn(KEY[3]), .start(start), .done(done), .vga_x(xcoor), .vga_y(ycoor), .vga_colour(colour), .vga_plot(plot));
vga_adapter#(.RESOLUTION("160x120")) VGA_DISPLAY(.resetn(KEY[3]), .clock(CLOCK_50), .x(xcoor), .y(ycoor), .plot(plot));


endmodule

