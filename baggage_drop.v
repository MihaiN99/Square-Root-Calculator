//////////////////////////////////////////////////////////////////////////////////

// Necula Mihai, 332AB

//////////////////////////////////////////////////////////////////////////////////
module baggage_drop(
    output reg [6:0] seven_seg1,
    output reg [6:0] seven_seg2,
    output reg [6:0] seven_seg3,
    output reg [6:0] seven_seg4,
    output reg [0:0] drop_activated,
    input [7:0] sensor1,
    input [7:0] sensor2,
    input [7:0] sensor3,
    input [7:0] sensor4,
    input [15:0] t_lim,
    input drop_en
    );

reg [15:0] t_act;
// sensors_input module
reg [7:0] height;
reg [8:0] media;
// square_root module
reg [15:0] out;
reg [15:0] sqrt; // radacina
reg [31:0] x; // valoarea de sub radical
reg [15:0] A;
reg [15:0] val;
reg [15:0] M;
reg [15:0] R; // r = rest, M = divisor, 
reg [5:0] i;
//reg MSB;
//reg u;

always @(*) begin

media = 0;
if(sensor1 == 0 || sensor3 == 0) begin
media = (sensor2 + sensor4 + 1) >>> 1;
end
else if(sensor2 == 0 || sensor4 == 0) begin
media = (sensor1 + sensor3 + 1) >>> 1;
end
else begin 
media = (sensor1 + sensor3 + sensor2 + sensor4 + 2) >>> 2;
end

height = media;

x=height<<16; // pentru fiecare 2 biti shiftati se adauga o zecimala dupa virgula (obtinem o precizie mai buna)
sqrt = 16'b0;
A = 16'b0; // acumulator
M = 16'b0; // divisor
R = 16'b0; // remainder

for(i=0; i<16; i=i+1) begin
	 A = {R[15:0], x[31:30]}; // in momentul in care incepem calcularea radicalului, coboram cate 2 biti pana ajungem la final
	// $display("A = %b", A);
	 val = {sqrt, R[15]}; // umplem sqrt cu MSB-ul din rest
	// $display("val = %b", val);
	 M = {val, 1'b1};
	// $display("M = %b", M);
    x=x<<2;
    R = (R[15] == 1 ? A + M : A - M); // daca MSB e 1 - bit de semn (negativ), adunam daca e negativ si scadem, daca R e pozitiv
	
    sqrt={sqrt[14:0],!R[15]};
end

out = sqrt; // rezultatul final
t_act = out >> 1; // pentru baggage drop aplicam formula din enunt t_act = sqrt(height) / 2

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