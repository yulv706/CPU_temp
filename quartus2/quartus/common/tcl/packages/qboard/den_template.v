
//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

// DEN Top Level File template

//////////////////////////////////////////////////////
//////////////////////////////////////////////////////

module top
	(
		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_50,						//	50 MHz
		////////////////////	Push Button		////////////////////
		KEY,							//	Pushbutton[3:0]
		////////////////////	Color LEDs		////////////////////
		LED 							//	LED Colors[7:0]
	);

////////////////////////	Clock Input	 	////////////////////////
input			CLOCK_50;				//	50 MHz
////////////////////////	Push Button		////////////////////////
input	[3:0]	KEY;					//	Pushbutton[3:0]
////////////////////////////	LED		////////////////////////////
output	[7:0]	LED;					//	LED Color[7:0]

///////////////////////////////////////////////
/// Add implementation Here
/// -----------------------


///////////////////////////////////////////////


endmodule