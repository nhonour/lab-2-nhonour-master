module fillscreen(input logic clk, input logic rstn, input logic start, output logic done,
                  output logic [7:0] vga_x, output logic [6:0] vga_y,
                  output logic [2:0] vga_colour, output logic vga_plot);
     // fill the screen
	 
	 
always_ff @(posedge clk)
begin
if (rstn == 0)
	begin
		vga_x = -1;
		vga_y = -1;
		vga_plot = 0;
	end
if (start == 1)
begin
	done = 0;
	if (vga_x < 159)
	begin
		vga_x = vga_x + 1;
		vga_colour = vga_x % 8;
		vga_plot = 1;
	end
	else
	begin
		vga_y = vga_y +1;
		vga_x = 0;
		vga_colour = vga_x % 8;
		vga_plot = 1;
	end
	if (vga_y == 120)
	done = 1;
end
end 

	 
endmodule
