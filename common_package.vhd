package Common is    -- untested...
   TYPE State IS (Fetch0, fetch11, fetch12, fetch13, Fetch21, Fetch22,
						load3, load4, load5, load61, load62, load63, load7,
						loadi3, loadi4, loadi5,
						store3, store4, store5,
						loadr3, loadr4, loadr5, 
						loadr61, loadr62, loadr63, loadr7,
						storer3, storer4, storer5, storer6, storer7,
						Add3, Add4, Add5,
						Sub3, Sub4, Sub5,
						And3, And4, And5,
						Or3, Or4, Or5,
						SHR3, SHR4, SHR5,
						SHL3, SHL4, SHL5,
						RotR3, RotR4, RotR5,
						RotL3, RotL4, RotL5,
						addi3, addi4, addi5,
						andi3, andi4, andi5,
						ori3, ori4, ori5,
						mul3, mul4, mul5, mul6,
						div3, div4, div5, div6,
						neg3, neg4,
						not3, not4,
						br3, br4,
						jr3,
						jal3, jal4, jal5,
						in3,
						out3,
						mfhi3,
						mflo3,
						nop,
						halt,
						Reset_State);
end Common;