module traffic_light(
    input clk,
    input reset,
    output reg [1:0] light
);

parameter RED    = 2'b00;
parameter GREEN  = 2'b01;
parameter YELLOW = 2'b10;

reg [1:0] state;
reg [1:0] next_state;

always @(posedge clk or posedge reset) begin
    if (reset)
        state <= RED;
    else
        state <= next_state;
end


always @(*) begin
    case (state)
        RED:    next_state = GREEN;
        GREEN:  next_state = YELLOW;
        YELLOW: next_state = RED;
        default: next_state = RED;
    endcase
end


always @(*) begin
    case (state)
        RED:    light = RED;
        GREEN:  light = GREEN;
        YELLOW: light = YELLOW;
        default: light = RED;
    endcase
end


endmodule