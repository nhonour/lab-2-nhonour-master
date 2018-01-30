module tb_task2();

reg clk;
reg [3:0] but;

wire [9:0] vr, vg, vb;
wire vhs, vvs, vblank, vs, vclk;

task2 dothetask(.CLOCK_50(clk), .KEY(but), .VGA_R(vr), .VGA_G(vg), .VGA_B(vb), .VGA_HS(vhs), .VGA_VS(vvs), .VGA_BLANK(vblank), .VGA_SYNC(vs), .VGA_CLK(vclk));

initial forever begin
	clk = 0;
	#5;
	clk = 1;
	#5;
end

initial begin
	but[3] = 1;
	#20;
	but[3] = 0;
	#10;
	but[3] = 1;
end

endmodule