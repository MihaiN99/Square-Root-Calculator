//////////////////////////////////////////////////////////////////////////////////

// Necula Mihai, 332AB

//////////////////////////////////////////////////////////////////////////////////
module square_root(
    output [15:0] out,
    input [7:0] in
    );
	 
	 
reg [15:0] sqrt; // radacina
reg [31:0] x; // valoarea de sub radical
reg [15:0] A;
reg [15:0] val;
reg [15:0] M;
reg [15:0] R; // r = rest, M = divisor, 
reg [5:0] i;
//reg [15:0] aux;
//reg MSB;
//reg u;

always @(*) begin

x=in<<16;
sqrt = 16'b0;
A = 16'b0; // remainder
M = 16'b0; // divisor
R = 16'b0;

for(i=0; i<16; i=i+1) begin
	 A = {R[15:0], x[31:30]}; // in momentul in care incepem calcularea radicalului, coboram cate 2 biti pana ajungem la final
	// $display("A = %b", A);
	 val = {sqrt, R[15]}; // umplem sqrt cu MSB-ul din rest
	// $display("val = %b", val);
	 M = {val, 1'b1};
	// $display("M = %b", M);
    x=x<<2;
	R = (R[15] == 1 ? A + M : A - M);  // daca MSB e 1 - bit de semn (negativ), adunam daca e negativ si scadem, daca R e pozitiv
    sqrt={sqrt[14:0],!R[15]};
end

end

assign out = sqrt; // rezultatul final

endmodule
