module vending_machine(clk,reset,BTN1,BTN2,BTN3,
					   product1,product2,product3,delivered,
					   digit1,digit2,digit3,digit4
					   );
					   

input clk,reset,BTN1,BTN2,BTN3;
// BTN1: TEA(product1), BTN2: COFFEE(product2), BTN3: HOT CHOCOLATE(product3)
// BTN1: 25 Krs, BTN2: 50 Krs, BTN3: 100 Krs

output reg product1,product2,product3,delivered;

output reg [6:0] digit1;
output reg [6:0] digit2;
output reg [6:0] digit3;
output reg [6:0] digit4;

reg [7:0] insertedMoney;
reg [7:0] totalChange;
reg [7:0] money;
reg [7:0] change;

parameter no_coin=0, initial_state=1,tea_0=2,tea_25=3,tea_50=4,tea_75=5,tea_100=6,tea_125=7,coffee_0=8,coffee_25=9,coffee_50=10,coffee_75=11,coffee_100=12,coffee_125=13,coffee_150=14,hot_0=15,hot_25=16,hot_50=17,hot_75=18,hot_100=19,hot_125=20,hot_150=21,hot_175=22,delivered_state=23;

parameter ssd_0=7'b0000001, ssd_1=7'b1001111, ssd_2=7'b0010010, ssd_3=7'b0000110, ssd_4=7'b1001100, ssd_5=7'b0100010, ssd_6=7'b0100000, ssd_7=7'b1110000, ssd_8=7'b0000000, ssd_not=7'b1111110;

// binaryde hatalar vardý????

reg [5:0] current_state, next_state;

// flip-flops
always @ (posedge clk or posedge reset)
begin
if (reset == 1) begin
current_state <= initial_state;
insertedMoney = 8'b00000000;
totalChange = 8'b00000000;
//money = 8'b0000000;
change <= 8'b00000000;
digit1<=7'b1111110;
digit2<=7'b1111110;
digit3<=7'b1111110;
digit4<=7'b1111110;
product1<=0;
product2<=0;
product3<=0;
delivered<=0;
end 

else begin

	if(current_state != initial_state)
	begin
	if(BTN1==1) insertedMoney = insertedMoney+5'b11001; 
	else if(BTN2==1)insertedMoney=insertedMoney+6'b110010;
	else if(BTN3==1) insertedMoney=insertedMoney+7'b1100100;
	end
	
	current_state <= next_state;
	totalChange=totalChange+change;
		
		/*
	product1<=product1;
	product2<=product2;
	product3<=product3;
		*/
		
if(current_state != delivered_state)
		begin
			if(insertedMoney==8'b00000000)
			begin
			digit1=7'b0000001;
			digit2=7'b0000001;
			end
			else if(insertedMoney==8'b00011001)
			begin
			digit1=7'b0010010;
			digit2=7'b0100100;
			end
			else if(insertedMoney==8'b00110010)
			begin
			digit1=7'b0100100;
			digit2=7'b0000001;
			end
			else if(insertedMoney==8'b01001011)
			begin
			digit1=7'b0001111;
			digit2=7'b0100100;
			end
			
		end
		else
		begin
		digit1=7'b1111110;
		digit2=7'b1111110;
		if(totalChange==8'b00000000)
			begin
			digit3=7'b0000001;
			digit4=7'b0000001;
			end
			else if(totalChange==8'b00011001)
			begin
			digit3=7'b0010010;
			digit4=7'b0100100;
			end
			else if(totalChange==8'b00110010)
			begin
			digit3=7'b0100100;
			digit4=7'b0000001;
			end
			else if(totalChange==8'b01001011)
			begin
			digit3=7'b0001111;
			digit4=7'b0100100;
			end
		end


end

end

// next state and output combinational logics
always @ *

begin
case (current_state)
initial_state: begin
delivered = 0;
change = 8'b00000000;

if (BTN1) begin
product1 = 1;
product2 = 0;
product3 = 0;
next_state = tea_0;
end

else if(BTN2) begin
product1 = 0;
product2 = 1;
product3 = 0;
next_state = coffee_0;
end

else if(BTN3) begin
product1 = 0;
product2 = 0;
product3 = 1;
next_state = hot_0;
end

else begin
next_state = initial_state;
end

end


tea_0: begin

if (BTN1)begin

next_state = tea_25;
change = 8'b00000000;
product1=1;
product2=0;
product3=0;
delivered=0;
end

else if (BTN2) begin
next_state = delivered_state;
change = 8'b00000000;
product1=1;
product2=0;
product3=0;
//delivered=1;
end

else if(BTN3) begin
next_state = delivered_state;
change = 8'b00110010;
product1=1;
product2=0;
product3=0;
//delivered=1;
end

else begin
next_state = tea_0; // If it did not make any choice keep your position
product1=1;
product2=0;
product3=0;
delivered=0;
end

end
tea_25: begin

if (BTN1)begin
next_state = delivered_state;
change = 8'b00000000;
product1=1;
product2=0;
product3=0;
delivered=0;
end

else if (BTN2) begin
next_state = delivered_state;
change = 8'b00011001;
product1=1;
product2=0;
product3=0;
//delivered=1;
end

else if(BTN3) begin
next_state = delivered_state;
change = 8'b01001011;
product1=1;
product2=0;
product3=0;
//delivered=1;
end

else begin
next_state = tea_25; // If it did not make any choice keep your position

//change = 8'b00000000;

product1=1;
product2=0;
product3=0;

delivered=0;
end

end


coffee_0: begin

if (BTN1) begin
next_state = coffee_25;
change = 8'b00000000;
product1=0;
product2=1;
product3=0;
delivered=0;
end

else if (BTN2) begin
next_state = coffee_50;
change = 8'b00000000;
product1=0;
product2=1;
product3=0;
delivered=0;
end

else if(BTN3) begin
next_state = delivered_state;
change = 8'b00011001;
product1=0;
product2=1;
product3=0;
//delivered=1;
end

else begin
next_state = coffee_0; // If it did not make any choice keep your position
//change = 8'b00000000;
product1=0;
product2=1;
product3=0;
//delivered=0;
end

end


coffee_25: begin // Coffee price = 75

if (BTN1)begin
next_state = coffee_50;
change = 8'b00000000;
product1=0;
product2=1;
product3=0;
delivered=0;
end

else if (BTN2) begin
next_state = delivered_state;
change = 8'b00000000;
product1=0;
product2=1;
product3=0;
//delivered=1;
end

else if(BTN3) begin
next_state = delivered_state;
change = 8'b00110010;
product1=0;
product2=1;
product3=0;
//delivered=1;
end

else begin
next_state = coffee_25; // If it did not make any choice keep your position
//change = 0;
product1=0;
product2=1;
product3=0;
delivered=0;
end

end


coffee_50: begin // Coffee price = 75

if (BTN1)begin
next_state = delivered_state;
change = 8'b00000000;
product1=0;
product2=1;
product3=0;
//delivered=1;
end

else if (BTN2) begin
next_state = delivered_state;
change = 8'b00011001;
product1=0;
product2=1;
product3=0;
//delivered=1;
end

else if(BTN3) begin
next_state = delivered_state;
change = 8'b01001011;
product1=0;
product2=1;
product3=0;
//delivered=1;
end

else begin
next_state = coffee_50; // If it did not make any choice keep your position
//change = 8'b00000000;
product1=0;
product2=1;
product3=0;
delivered=0;
end

end


hot_0: begin // Hot chocolate price = 100

if (BTN1)begin
next_state = hot_25;
change = 8'b00000000;
product1=0;
product2=0;
product3=1;
delivered=0;
end

else if (BTN2) begin
next_state = hot_50;
change = 8'b00000000;
product1=0;
product2=0;
product3=1;
delivered=0;
end

else if(BTN3) begin
next_state = delivered_state;
change = 8'b00000000;
product1=0;
product2=0;
product3=1;
//delivered=1;
end

else begin
next_state = hot_0; // If it did not make any choice keep your position
//change = 8'b00000000;
product1=0;
product2=0;
product3=1;
delivered=0;
end

end


hot_25: begin // Hot chocolate price = 100

if (BTN1)begin
next_state = hot_50;
change = 8'b00000000;
product1=0;
product2=0;
product3=1;
delivered=0;
end

else if (BTN2) begin
next_state = hot_75;
change = 8'b00000000;
product1=0;
product2=0;
product3=1;
delivered=0;
end

else if(BTN3) begin
next_state = delivered_state;
change = 8'b00011001;
product1=0;
product2=0;
product3=1;
//delivered=1;
end

else begin
next_state = hot_25; // If it did not make any choice keep your position
//change = 8'b00000000;
product1=0;
product2=0;
product3=1;
delivered=0;
end

end


hot_50: begin // Hot chocolate price = 100

if (BTN1)begin
next_state = hot_75;
change = 8'b00000000;
product1=0;
product2=0;
product3=1;
delivered=0;
end

else if (BTN2) begin
next_state = delivered_state;
change = 8'b00000000;
product1=0;
product2=0;
product3=1;
//delivered=1;
end

else if(BTN3) begin
next_state = delivered_state;
change = 8'b00110010;
product1=0;
product2=0;
product3=1;
//delivered=1;
end

else begin
next_state = hot_50; // If it did not make any choice keep your position
money = 8'b00000000;
//change = 8'b00000000;
product1=0;
product2=0;
product3=1;
delivered=0;
end

end


hot_75: begin // Hot chocolate price = 100

if (BTN1)begin
next_state = delivered_state;
change = 8'b00000000;
product1=0;
product2=0;
product3=1;
//delivered=1;
end

else if (BTN2) begin
next_state = delivered_state;
change = 8'b00011001;
product1=0;
product2=0;
product3=1;
//delivered=1;
end

else if(BTN3) begin
next_state = delivered_state;
change = 8'b01001011;
product1=0;
product2=0;
product3=1;
//delivered=1;
end

else begin
next_state = hot_75; // If it did not make any choice keep your position

product1=0;
product2=0;
product3=1;
//delivered=0;
end

end

delivered_state: begin
next_state = delivered_state;
change = 8'b00000000;
delivered = 1;

end


endcase
end

endmodule