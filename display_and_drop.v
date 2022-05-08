//////////////////////////////////////////////////////////////////////////////////

// Necula Mihai, 332AB

//////////////////////////////////////////////////////////////////////////////////
module display_and_drop(
    output reg [6:0] seven_seg1,
    output reg [6:0] seven_seg2,
    output reg [6:0] seven_seg3,
    output reg [6:0] seven_seg4,
    output reg [0:0] drop_activated,
    input [15:0] t_act,
    input [15:0] t_lim,
    input drop_en
    );

always @(*) begin

if(!drop_en) begin
	// cold
	seven_seg1 = 7'b0111001;
	seven_seg2 = 7'b1011100;
	seven_seg3 = 7'b0111000;
	seven_seg4 = 7'b1011110;
	drop_activated = 0;
end

else if (t_act < t_lim) begin
	// drop
	seven_seg1 = 7'b1011110;
	seven_seg2 = 7'b1010000;
	seven_seg3 = 7'b1011100;
	seven_seg4 = 7'b1110011;
	drop_activated = 1;

end

else if(t_act > t_lim) begin
	// hot
	seven_seg1 = 7'b0000000;
	seven_seg2 = 7'b1110110;
	seven_seg3 = 7'b1011100;
	seven_seg4 = 7'b1111000;
	drop_activated = 0;
end
end

endmodule

