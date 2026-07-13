module tb;
reg clk = 0;
reg reset;
wire [1:0] light;

traffic_light uut(.clk(clk), .reset(reset), .light(light));

always begin
    #5 clk = !clk;
end

initial begin
    #1  reset = 1;
    #5 reset = 0;
    #90 $finish;
end

propimpl1 : assert property (@(posedge clk) ((light == 0) ##1 (light == 1) ##1 (light == 2) ##1 (light == 0)));

endmodule