//////////////////////////////////////////////////////////////////////////////////

// Necula Mihai, 332AB

//////////////////////////////////////////////////////////////////////////////////
module sensors_input(
    output [7:0] height,
    input [7:0] sensor1,
    input [7:0] sensor2,
    input [7:0] sensor3,
    input [7:0] sensor4
    );

reg [8:0] media;

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

end

assign height = media;

endmodule