module circle(input logic clk, input logic rstn, input logic [2:0] colour,
              input logic [7:0] centre_x, input logic [6:0] centre_y, input logic [7:0] radius,
              input logic start, output logic done,
              output logic [7:0] vga_x, output logic [6:0] vga_y,
              output logic [2:0] vga_colour, output logic vga_plot);
     // draw the circle
	 
reg [6:0] offset_y;
reg [7:0] offset_x, crit;
	
enum {setup, oct1, oct2, oct3, oct4, oct5, oct6, oct7, oct8, finish} curr, nxt;
	
always_ff @(posedge clk or negedge rstn)
begin
	if (rstn == 0)
		curr <= setup;
	else
		curr <= nxt;
end

always_comb
case (curr)
	setup: 
		begin
			vga_plot = 0;
			offset_y = 0;
			offset_x = radius;
			crit = 1 - radius;
			nxt = oct1;
			vga_colour = colour;
		end
	oct1:
		begin
		vga_x = centre_x + offset_x;
		vga_y = centre_y + offset_y;
		vga_plot = 1;
		end
	oct2:
		begin
		vga_x = centre_x + offset_y;
		vga_y = centre_y + offset_x;
		vga_plot = 1;
		end
	oct3:
		begin
		vga_x = centre_x - offset_x;
		vga_y = centre_y + offset_y;
		vga_plot = 1;
		end
	oct4:
		begin
		vga_x = centre_x - offset_y;
		vga_y = centre_y + offset_x;
		vga_plot = 1;
		end
	oct5:
		begin
		vga_x = centre_x - offset_x;
		vga_y = centre_y - offset_y;
		vga_plot = 1;
		end
	oct6:
		begin
		vga_x = centre_x - offset_y;
		vga_y = centre_y - offset_x;
		vga_plot = 1;
		end
	oct7:
		begin
		vga_x = centre_x + offset_x;
		vga_y = centre_y - offset_y;
		vga_plot = 1;
		end
	oct8:
		begin
		vga_x = centre_x + offset_y;
		vga_y = centre_y - offset_x;
		vga_plot = 1;
		
		if (crit <= 0)
			crit = crit + 2 * offset_y + 1;
		else
		begin
			offset_x = offset_x - 1;
			crit = crit + 2 * (offset_y - offset_x) + 1;
		end
		
		if(offset_y <= offset_x)
			nxt = finish;
		else
			nxt = oct1;
		end
	default: nxt = setup;
endcase 
	 
	 
	 
endmodule

