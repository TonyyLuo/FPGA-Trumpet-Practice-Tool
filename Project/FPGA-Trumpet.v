

//KEY[0] is reset
module FPGA-Trumpet (
	// Inputs
	CLOCK_50,
	KEY,
	LEDR,
	HEX0,
	HEX1,
	HEX2,
	HEX3,
	HEX4,
	HEX5,

	AUD_ADCDAT,

	// Bidirectionals
	AUD_BCLK,
	AUD_ADCLRCK,
	AUD_DACLRCK,

	FPGA_I2C_SDAT,

	// Outputs
	AUD_XCK,
	AUD_DACDAT,

	FPGA_I2C_SCLK,
	SW
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/


/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
// Inputs
input				CLOCK_50;
input		[3:0]	KEY;
input		[3:0]	SW;
output	[3:0] LEDR;
output	[6:0]HEX0;
output	[6:0]HEX1;
output	[6:0]HEX2;
output	[6:0]HEX3;
output	[6:0]HEX4;
output	[6:0]HEX5;

input				AUD_ADCDAT;

// Bidirectionals
inout				AUD_BCLK;
inout				AUD_ADCLRCK;
inout				AUD_DACLRCK;

inout				FPGA_I2C_SDAT;

// Outputs
output				AUD_XCK;
output				AUD_DACDAT;

output				FPGA_I2C_SCLK;

/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/
// Internal Wires
wire				audio_in_available;
wire		[31:0]	left_channel_audio_in;
wire		[31:0]	right_channel_audio_in;
wire				read_audio_in;

wire				audio_out_allowed;
wire		[31:0]	left_channel_audio_out;
wire		[31:0]	right_channel_audio_out;
wire				write_audio_out;

// Internal Registers

reg [18:0] delay_cnt;
wire [18:0] delay;
reg snd;

// State Machine Registers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 * 										  Square Wave                               *
 *****************************************************************************/
	// SEQUENTIAL
 
//always @(posedge CLOCK_50)
//	if(delay_cnt == delay) begin
//		delay_cnt <= 0;
//		snd <= !snd;
//	end else delay_cnt <= delay_cnt + 1;

	// COMBINATIONAL

//assign delay = {pitch}; 
//wire [31:0] sound = (delay_cnt == 0) ? 0 : snd ? 32'd10000000 : -32'd10000000;	
//
//
//assign read_audio_in			= audio_in_available & audio_out_allowed;
//
//assign left_channel_audio_out	= sound;
//assign right_channel_audio_out	= sound;
//assign write_audio_out			= audio_in_available & audio_out_allowed;

/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/

Audio_Controller Audio_Controller (
	// Inputs
	.CLOCK_50						(CLOCK_50),
	.reset						(~KEY[0]),

	.clear_audio_in_memory		(),
	.read_audio_in				(read_audio_in),
	
	.clear_audio_out_memory		(),
	.left_channel_audio_out		(left_channel_audio_out),
	.right_channel_audio_out	(right_channel_audio_out),
	.write_audio_out			(write_audio_out),

	.AUD_ADCDAT					(AUD_ADCDAT),

	// Bidirectionals
	.AUD_BCLK					(AUD_BCLK),
	.AUD_ADCLRCK				(AUD_ADCLRCK),
	.AUD_DACLRCK				(AUD_DACLRCK),


	// Outputs
	.audio_in_available			(audio_in_available),
	.left_channel_audio_in		(left_channel_audio_in),
	.right_channel_audio_in		(right_channel_audio_in),

	.audio_out_allowed			(audio_out_allowed),

	.AUD_XCK					(AUD_XCK),
	.AUD_DACDAT					(AUD_DACDAT)

);

avconf #(.USE_MIC_INPUT(1)) avc (
	.FPGA_I2C_SCLK					(FPGA_I2C_SCLK),
	.FPGA_I2C_SDAT					(FPGA_I2C_SDAT),
	.CLOCK_50					(CLOCK_50),
	.reset						(~KEY[0])
);



	wire [18:0]pitch;
	
	note_Select u0 (
		.keys(~KEY[3:1]),
		.airflow(air),
		.note(pitch)
		);

	
	
	
//**************************************************************************************
	wire [31:0] temp1;
	wire [31:0] temp2;
	wire [31:0] temp3;
	wire [31:0] temp4;
	wire [31:0] temp5;
	wire [31:0] temp6;
	wire [31:0] temp7;
	wire [31:0] temp8;
	wire [31:0] temp9;
	wire [31:0] temp10;
	wire [31:0] temp11;
	wire [31:0] temp12;
	wire [31:0] temp13;
	wire [31:0] temp14;
	wire [31:0] temp15;
	wire [31:0] temp16;
	wire [31:0] temp17;
	wire [31:0] temp18;
	wire [31:0] temp19;

	RotatingRegister r1(
		.left_channel_audio_in(outp),
		.clk(CLOCK_50), 
		.reset(~KEY[0]),
		.temp1(temp1), 
		.temp2(temp2), 
		.temp3(temp3), 
		.temp4(temp4), 
		.temp5(temp5), 
		.temp6(temp6), 
		.temp7(temp7), 
		.temp8(temp8), 
		.temp9(temp9), 
		.temp10(temp10)
	);
	
		
		wire [2:0]airflow; 
		wire [1:0] air;
		
	
	assign LEDR[0]=air[0];
	assign LEDR[1]=air[1];
	//assign LEDR[2]=air[2];
	
	wire Enable;
	wire [25:0]RDiv;
	wire [31:0]divOut;
	wire [31:0] outp;
	
	assign outp = (left_channel_audio_in[31] ==1)? -left_channel_audio_in: left_channel_audio_in;
	
	wire [50:0]avgInput;
	
	assign avgInput = (outp + temp1 + temp2 + temp3 + temp4 + temp5 + temp6 + temp7 + temp8 + temp9 + temp10+ temp11 + temp12 + temp13 + temp14 + temp15 + temp16 + temp17 + temp18 + temp19)/20; 
	
	//test3 t1(avgInput[31:0], Enable, air);
	//test t2(right_channel_audio_in, CLOCK_50, LEDR[1]);
	
	wire [10:0] lCount;
	wire [10:0] mCount;
	wire [10:0] hCount;
	wire [10:0] rc;
	
	testmic tm0 (outp, Enable, lCount, mCount, hCount, rc, air);
	
	assign Enable = (RDiv == 26'b00000000000000000000000000)?1:0;
	
	RateDivider rd0 (
		.Clock(CLOCK_50),
		.q(RDiv)
		);
	
	divOut do0(left_channel_audio_in, Enable, divOut);
	
	hex_decoder H0(
        .hex_digit(lCount[3:0]), 
        .segments(HEX0)
        );
	
	hex_decoder H1(
        .hex_digit(lCount[7:4]), 
        .segments(HEX1)
        );
	hex_decoder H2(
        .hex_digit(mCount[3:0]), 
        .segments(HEX2)
        );
	hex_decoder H3(
        .hex_digit(mCount[7:4]), 
        .segments(HEX3)
        );
	hex_decoder H4(
        .hex_digit(hCount[3:0]), 
        .segments(HEX4)
        );
	hex_decoder H5(
        .hex_digit(hCount[7:4]), 
        .segments(HEX5)
        );
	
	
	
	
endmodule
//*****************************************************************************************************************************************

module note_Select (keys, airflow, note);
	input [2:0] keys;
	input [1:0]airflow;
	
	output reg [18:0] note;
	
	always @(*)	//declare always block
	begin
		case (airflow[1:0])
			//alternate code used for testing
			2'b00: note = 5'b00000;	//case 0: no airflow
			2'b01:
				begin
					if (keys == 3'b000)			//Middle C 523
						note = 19'd191204;
					else if (keys == 3'b111)		//C# 554
						note = 19'd180505;
					else if (keys == 3'b101)		//D 587
						note = 19'd170357;
					else if (keys == 3'b011)		//D# 622
						note = 19'd160771;
					else if (keys == 3'b110)		//E 659
						note = 19'd151745;
					else if (keys == 3'b100)		//F 698
						note = 19'd143266;
					else if (keys == 3'b010)		//F# 740	
						note = 19'd135135;
					else
						note = 19'b0;
				end
			2'b10:
				begin
					if (keys == 3'b000)			//G 784
						note = 19'd127551;
					else if (keys == 3'b011)		//G# 831	
						note = 19'd120336;
					else if (keys == 3'b110)		//A 880
						note = 19'd113636;
					else if (keys == 3'b100)		//A# 932
						note = 19'd107296;
					else if (keys == 3'b010)		//B 988
						note = 19'd101214;
					else
						note = 19'b0;
				end
			2'b11: 
				begin
					if (keys == 3'b000)			//High C 1047
						note = 19'd95510;
					else if (keys == 3'b110)		//C# 	1109
						note = 19'd90171;
					else if (keys == 3'b100)		//D 1175
						note = 19'd85106;
					else if (keys == 3'b010)		//D# 1245
						note = 19'd80321;
					else
						note = 19'b0;
				end
			default: note = 19'b0;	//default case
		endcase
	end

endmodule


module RotatingRegister (left_channel_audio_in, clk, reset, temp1, temp2, temp3, temp4, temp5, temp6, temp7, temp8, temp9, temp10, temp11, temp12, temp13, temp14, temp15, temp16, temp17, temp18, temp19);
	input [31:0] left_channel_audio_in;
	input clk;
	input reset;
	output [31:0] temp1;
	output [31:0] temp2;
	output [31:0] temp3;
	output [31:0] temp4;
	output [31:0] temp5;
	output [31:0] temp6;
	output [31:0] temp7;
	output [31:0] temp8;
	output [31:0] temp9;
	output [31:0] temp10;
	output [31:0] temp11;
	output [31:0] temp12;
	output [31:0] temp13;
	output [31:0] temp14;
	output [31:0] temp15;
	output [31:0] temp16;
	output [31:0] temp17;
	output [31:0] temp18;
	output [31:0] temp19;
	
	subReg u0(
		.D(left_channel_audio_in),
		.clk(clk),
		.reset(reset),
		.Q(temp1)
		);
		
	subReg u1(
		.D(temp1),
		.clk(clk),
		.reset(reset),
		.Q(temp2)
		);

	subReg u2(
		.D(temp2),
		.clk(clk),
		.reset(reset),
		.Q(temp3)
		);
		
	subReg u3(
		.D(temp3),
		.clk(clk),
		.reset(reset),
		.Q(temp4)
		);

	subReg u4(
		.D(temp4),
		.clk(clk),
		.reset(reset),
		.Q(temp5)
		);
	subReg u5(
		.D(temp5),
		.clk(clk),
		.reset(reset),
		.Q(temp6)
		);
	subReg u6(
		.D(temp6),
		.clk(clk),
		.reset(reset),
		.Q(temp7)
		);
	subReg u7(
		.D(temp7),
		.clk(clk),
		.reset(reset),
		.Q(temp8)
		);
	subReg u8(
		.D(temp8),
		.clk(clk),
		.reset(reset),
		.Q(temp9)
		);
	subReg u9(
		.D(temp9),
		.clk(clk),
		.reset(reset),
		.Q(temp10)
		);
	subReg u10(
		.D(temp10),
		.clk(clk),
		.reset(reset),
		.Q(temp11)
		);
	subReg u11(
		.D(temp11),
		.clk(clk),
		.reset(reset),
		.Q(temp12)
		);
	subReg u12(
		.D(temp12),
		.clk(clk),
		.reset(reset),
		.Q(temp13)
		);
	subReg u13(
		.D(temp13),
		.clk(clk),
		.reset(reset),
		.Q(temp14)
		);
	subReg u14(
		.D(temp14),
		.clk(clk),
		.reset(reset),
		.Q(temp15)
		);
	subReg u15(
		.D(temp15),
		.clk(clk),
		.reset(reset),
		.Q(temp16)
		);
	subReg u16(
		.D(temp16),
		.clk(clk),
		.reset(reset),
		.Q(temp17)
		);
	subReg u17(
		.D(temp17),
		.clk(clk),
		.reset(reset),
		.Q(temp18)
		);
	subReg u18(
		.D(temp18),
		.clk(clk),
		.reset(reset),
		.Q(temp19)
		);

endmodule


module subReg(D, clk, reset, Q);
	input [31:0]D;
	input clk;
	input reset;
	output reg [31:0]Q;
	
	always @(posedge clk)
	begin
		if (reset == 1)
			Q<=0;
		else
			Q<=D;
	end
endmodule



module test(in1, D, clk, out1);
	input [31:0] in1;
	input clk;
	input D;
	output reg out1;
	
	wire en;
	
	assign en = (in1[31] ==1)?0:1;
	
	
	
	always @(posedge clk)
	begin
		if (en ==1)
			begin
				if (in1 > 32'b00000000000010110000000000000000 )
					out1<=1;
				else
					out1<=0;
			end
		else
			out1<=D;
	end
endmodule

module test2(in1, clk, out1);
	input [31:0] in1;
	input clk;
	output reg [2:0]out1;
	
	
	always @(posedge clk)
	begin
			if (in1 > 32'b00000000111111111110000000000000)
				out1<=3'b010;
			else if (in1 > 32'b00000000000111100000000000000000)
				out1<=3'b001;
			else
				out1<=3'b000;

	end
endmodule

module test3(in1, clk, out1);
	input [31:0] in1;
	input clk;
	output reg [1:0]out1;
	
	
	always @(posedge clk)
	begin
			if (in1 > 32'b00000001111000000000000000000000)
				out1<=2'b10;
			else if (in1 > 32'b00000000000111111100000000000000)
				out1<=3'b01;
			else
				out1<=3'b00;

	end
endmodule




module testmic (audio_in, clk, lCount, mCount, hCount, q, air);
	input [31:0]audio_in;
	input clk;
	output reg [10:0] lCount;
	output reg [10:0] mCount;
	output reg [10:0] hCount;
	output reg [10:0]q;
	output reg [1:0]air;
	
	always @(posedge clk) // triggered every time clock rises
	begin
		if (q == 10'b0000000000) // when q is the min value for the counter
			begin
				//if (hCount> 10'b0000000100 || hCount > lCount && hCount > mCount)
					//air <=2'b10;
				//else if (mCount > lCount || mCount >10'b0000000011)
					//air <=2'b01;
				//else
					//air <=2'b00;
			
			
				if (lCount > mCount && lCount > hCount)
					air<=2'b00;
				else if (mCount > lCount && mCount > hCount)
					air<=2'b01;
				else if (hCount > lCount && hCount > mCount)
					air <=2'b10;
				else
					air <= air;
				
				q <= 26'b0000001111;//something bit something; // q reset to 0
				hCount <= 11'b00000000000;
				mCount <= 11'b00000000000;
				lCount <= 11'b00000000000;
			end
		else
			begin
			q <= q - 1; // decrement q
			if (audio_in > 32'b00000001111000000000000000000000)
				hCount <= hCount + 1;
			else if (audio_in > 32'b00000000000111111100000000000000)
				mCount <= mCount + 1;
			else
				lCount <= lCount + 1;
			end
	end
endmodule


module hex_decoder(hex_digit, segments);
    input [3:0] hex_digit;
    output reg [6:0] segments;
   
    always @(*)
        case (hex_digit)
            4'h0: segments = 7'b100_0000;
            4'h1: segments = 7'b111_1001;
            4'h2: segments = 7'b010_0100;
            4'h3: segments = 7'b011_0000;
            4'h4: segments = 7'b001_1001;
            4'h5: segments = 7'b001_0010;
            4'h6: segments = 7'b000_0010;
            4'h7: segments = 7'b111_1000;
            4'h8: segments = 7'b000_0000;
            4'h9: segments = 7'b001_1000;
            4'hA: segments = 7'b000_1000;
            4'hB: segments = 7'b000_0011;
            4'hC: segments = 7'b100_0110;
            4'hD: segments = 7'b010_0001;
            4'hE: segments = 7'b000_0110;
            4'hF: segments = 7'b000_1110;   
            default: segments = 7'h7f;
        endcase
endmodule


module RateDivider (Clock, q);
	input Clock;
	
	output reg [25:0] q; // declare q

	always @(posedge Clock) // triggered every time clock rises
	begin
		if (q == 26'b00000000000000000000000000) // when q is the min value for the counter
			//Real code value
			q <= 26'b00000001111111111111111111;//something bit something; // q reset to 0

		else
			q <= q - 1; // decrement q
	end

endmodule

module divOut (inSound, clk, outSound);
	input [31:0]inSound;
	input clk;
	output reg [31:0] outSound;
	
	always @(posedge clk)
		begin
			outSound <= inSound;
		end
	
endmodule
