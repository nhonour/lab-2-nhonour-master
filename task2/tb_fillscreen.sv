module tb_fillscreen();

reg tclk, trst, tstart;
wire [7:0] tx;
wire [6:0] ty;
wire [2:0] tcolour;
wire tdone, tplot;


fillscreen fillemup(.clk(tclk), .rstn(trst), .start(tstart), .done(tdone), .vga_x(tx), .vga_y(ty), .vga_colour(tcolour), .vga_plot(tplot));

initial forever begin
tclk = 0;
#5;
tclk = 1;
#5;
end

initial begin
trst = 1;
#10;
trst = 0;
tstart = 1;
#10;
trst = 1;
#10;
end

endmodule