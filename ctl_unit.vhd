LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY ctl_unit IS
	PORT(
		clk, reset, stop, con_ff	:	IN STD_LOGIC;
		IR									:	IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		--Indicators
		run, 
		--- Register Control Ports
		clr,
		Rin, Rout, Gra, Grb, Grc, RA_en,
		
		PCout, MDRout, ZHiOut, ZLoOut, HiOut, LoOut, 
		InportOut,
		
		HiIn, LOIn, CONin, PCin, IRin, Yin, Zin, 
		MARin, MDRin, Outport_en,Cout, BAout,
		
		--ALU Signals
		ADD, SUB, ANDop, ORop, 
		SHR, SHL, ROTR, ROTL,
		MUL, DIV, NEG, NOTop, 
		IncPC, claADD,
		
		--Memory Signals
		ReadSig, WriteSig 	: OUT STD_LOGIC
	);
END ctl_unit;

ARCHITECTURE behavioural OF ctl_unit IS
	TYPE State IS (Fetch0, Fetch11, fetch12, fetch13, Fetch2,
						load3, load4, load5, load6, load7,
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
	SIGNAL Present_State		: State;
BEGIN
	fsm: PROCESS(clk, reset, stop)
		BEGIN
		if (Reset = '1') then
			Present_State <= Reset_state;
		elsif (stop = '0' AND rising_edge(clk)) then
			case Present_State IS
				when Reset_State =>
					Present_state <= fetch0;
				when fetch0 =>
					Present_State <= fetch11;
				when fetch11 =>
					Present_State <= fetch12;
				when fetch12 =>
					Present_State <= fetch13;
				when fetch13 =>
					Present_State <= fetch2;
				-------------------------------------------
				when load3 =>
					Present_State <= load4;
				when load4 =>
					Present_State <= load5;
				when load5 =>
					Present_State <= load6;
				when load6 =>
					Present_State <= load7;
				when load7 =>
					Present_State <= fetch0;
				-------------------------------------------
				when loadi3 =>
					Present_State <= loadi4;
				when loadi4 =>
					Present_State <= loadi5;
				when loadi5 =>
					Present_State <= fetch0;
				-------------------------------------------
				when store3 =>
					Present_State <= store4;
				when store4 =>
					Present_State <= store5;
				when store5 =>
					Present_State <= fetch0;
				-------------------------------------------
				when loadr3 =>
					Present_State <= loadr4;
				when loadr4 =>
					Present_State <= loadr5;
				when loadr5 =>
					Present_State <= loadr61;
				when loadr61 =>
					Present_State <= loadr61;
				when loadr62 =>
					Present_State <= loadr62;
				when loadr63 =>
					Present_State <= loadr7;
				when loadr7 =>
					Present_State <= fetch0;
				-------------------------------------------
				when storer3 =>
					Present_State <= storer4;
				when storer4 =>
					Present_State <= storer5;
				when storer5 =>
					Present_State <= storer6;
				when storer6 =>
					Present_State <= storer7;
				when storer7 =>
					Present_State <= fetch0;
				-------------------------------------------
				when add3 =>
					Present_State <= add4;
				when add4 =>
					Present_State <= add5;
				when add5 =>
					Present_State <= fetch0;					
				-------------------------------------------
				when sub3 =>
					Present_State <= sub4;
				when sub4 =>
					Present_State <= sub5;
				when sub5 =>
					Present_State <= fetch0;					
				-------------------------------------------
				when and3 =>
					Present_State <= and4;
				when and4 =>
					Present_State <= and5;
				when and5 =>
					Present_State <= fetch0;					
				-------------------------------------------
				when or3 =>
					Present_State <= or4;
				when or4 =>
					Present_State <= or5;
				when or5 =>
					Present_State <= fetch0;	
				-------------------------------------------
				when SHR3 =>
					Present_State <= SHR4;
				when SHR4 =>
					Present_State <= SHR5;
				when SHR5 =>
					Present_State <= fetch0;	
				-------------------------------------------
				when SHL3 =>
					Present_State <= SHL4;
				when SHL4 =>
					Present_State <= SHL5;
				when SHL5 =>
					Present_State <= fetch0;
				-------------------------------------------
				when ROTR3 =>
					Present_State <= ROTR4;
				when ROTR4 =>
					Present_State <= ROTR5;
				when ROTR5 =>
					Present_State <= fetch0;	
				-------------------------------------------
				when ROTL3 =>
					Present_State <= ROTL4;
				when ROTL4 =>
					Present_State <= ROTL5;
				when ROTL5 =>
					Present_State <= fetch0;	
				-------------------------------------------
				when addi3 =>
					Present_State <= addi4;
				when addi4 =>
					Present_State <= addi5;
				when addi5 =>
					Present_State <= fetch0;
				-------------------------------------------	
				when andi3 =>
					Present_State <= andi4;
				when andi4 =>
					Present_State <= andi5;
				when andi5 =>
					Present_State <= fetch0;
				-------------------------------------------	
				when ori3 =>
					Present_State <= ori4;
				when ori4 =>
					Present_State <= ori5;
				when ori5 =>
					Present_State <= fetch0;
				-------------------------------------------	
				when mul3 =>
					Present_State <= mul4;
				when mul4 =>
					Present_State <= mul5;
				when mul5 =>
					Present_State <= mul6;
				when mul6 =>
					Present_State <= fetch0;
				-------------------------------------------	
				when div3 =>
					Present_State <= div4;
				when div4 =>
					Present_State <= div5;
				when div5 =>
					Present_State <= div6;
				when div6 =>
					Present_State <= fetch0;
				-------------------------------------------	
				when neg3 =>
					Present_State <= neg4;
				when neg4 =>
					Present_State <= fetch0;
				-------------------------------------------	
				when not3 =>
					Present_State <= not4;
				when not4 =>
					Present_State <= fetch0;
				-------------------------------------------	
				when br3 =>
					if (con_ff = '1') then
						Present_State <= br4;
					else
						Present_State <= fetch0;
					end if;	
				-------------------------------------------	
				when jr3 =>
					Present_State <= fetch0;
				-------------------------------------------	
				when jal3 =>
					Present_State <= jal4;
				when jal4 =>
					Present_State <= jal5;
				when jal5 =>
					Present_State <= fetch0;
				-------------------------------------------	
				when in3 =>
					Present_State <= fetch0;
				-------------------------------------------	
				when out3 =>
					Present_State <= fetch0;
				-------------------------------------------	
				when mfhi3 =>
					Present_State <= fetch0;
				-------------------------------------------	
				when mflo3 =>
					Present_State <= fetch0;
				-------------------------------------------	
				when nop =>
					Present_State <= fetch0;
				when halt => -- do nothing, remain halted
				-------------------------------------------
				-------------------------------------------
				when fetch2 =>
					Case IR(31 downto 27) is
						when "00000" =>
							Present_State <= load3;
						when "00001" =>
							Present_State <= loadi3;
						when "00010" =>
							Present_State <= store3;
						when "00011" =>
							Present_State <= loadr3;
						when "00100" =>
							Present_State <= storer3;
						when "00101" =>
							Present_State <= add3;
						when "00110" =>
							Present_State <= sub3;
						when "00111" =>
							Present_State <= and3;
						when "01000" =>
							Present_State <= or3;
						when "01001" =>
							Present_State <= shr3;
						when "01010" =>
							Present_State <= shl3;
						when "01011" =>
							Present_State <= rotr3;
						when "01100" =>
							Present_State <= rotl3;
						when "01101" =>
							Present_State <= addi3;
						when "01110" =>
							Present_State <= andi3;
						when "01111" =>
							Present_State <= ori3;
						when "10000" =>
							Present_State <= mul3;
						when "10001" =>
							Present_State <= div3;
						when "10010" =>
							Present_State <= neg3;
						when "10011" =>
							Present_State <= not3;
						when "10100" =>
							Present_State <= br3;	
						when "10101" =>
							Present_State <= jr3;
						when "10110" =>
							Present_State <= jal3;
						when "10111" =>
							Present_State <= in3;
						when "11000" =>
							Present_State <= out3;
						when "11001" =>
							Present_State <= mfhi3;
						when "11010" =>
							Present_State <= mflo3;
						when "11011" =>
							Present_State <= nop;
						when "11100" =>
							Present_State <= halt;
						when others =>
					end case;
				when others =>
			end case;
		end if;
	END PROCESS;
	
	worker : PROCESS(Present_State)
		BEGIN
		--always set signals to 0 then set them to 1 as req'd
		clr <= '0';
		--- Register Control Ports
		Rin<= '0'; Rout<= '0'; Gra<= '0'; Grb<= '0'; Grc<= '0';
		
		PCout<= '0'; MDRout<= '0'; ZHiOut<= '0'; ZLoOut<= '0'; HiOut<= '0'; LoOut<= '0'; 
		InportOut<= '0';
		
		HiIn<= '0'; LOIn<= '0'; CONin<= '0'; PCin<= '0'; IRin<= '0'; Yin<= '0'; Zin<= '0'; 
		MARin<= '0'; MDRin<= '0'; Outport_en<= '0';Cout<= '0'; BAout<= '0';
		
		--ALU Signals
		ADD<= '0'; SUB<= '0'; ANDop<= '0'; ORop<= '0'; 
		SHR<= '0'; SHL<= '0'; ROTR<= '0'; ROTL<= '0';
		MUL<= '0'; DIV<= '0'; NEG<= '0'; NOTop<= '0'; 
		IncPC<= '0'; claADD<= '0';
		
		--Memory Signals
		ReadSig<= '0'; WriteSig <= '0';
		CASE Present_State IS
			when Reset_State =>
				clr <= '1';  Run <= '0';
			when fetch0 =>
				PCout <= '1'; MARin <= '1'; IncPC <= '1'; Zin<= '1'; Run <= '1';
			when fetch11 =>	ZLoOut <= '1'; PCin <= '1'; ReadSig <= '1'; MDRin <= '1';
			when fetch12 =>	ZLoOut <= '1'; PCin <= '1'; ReadSig <= '1'; MDRin <= '1';
			when fetch13 =>	ZLoOut <= '1'; PCin <= '1'; ReadSig <= '1'; MDRin <= '1';
			when fetch2 =>
				MDRout <= '1'; IRin <= '1';
			-------------------------------------------	
			when load3 =>
				GRB <= '1'; Rout <= '1'; Yin <= '1';
				if IR(22 downto 19)<= "0000" then
					 BAout <= '1';
				end if;				
			when load4 =>
				Cout <= '1'; Zin <= '1'; 
			when load5 =>
				ZLoOut <= '1'; MARin <= '1'; 
			when load6 =>
				ReadSig <= '1'; MDRin <= '1'; 
			when load7 =>
				MDRout <= '1'; GRA <= '1'; Rin <= '1'; 
			-------------------------------------------					
			when loadi3 =>
				GRB <= '1'; Rout <= '1'; Yin <= '1'; 
				if IR(22 downto 19) <= "0000" then
					BAout <= '1'; 
				end if;
			when loadi4 =>
				Cout <= '1'; ADD <= '1'; Zin <= '1'; 
			when loadi5 =>
				ZLoOut <= '1'; GRA <= '1'; Rin <= '1'; 
			-------------------------------------------	
			when store3 =>
				MDRout <= '1'; MARin <= '1'; 
			when store4 =>
				GRA <= '1'; Rout <= '1'; Yin <= '1'; 
				if IR(22 downto 19) <= "0000" then
					BAout <= '1'; 
				end if;
			when store5 =>
				MDRout <= '1'; WriteSig  <= '1'; 
			-------------------------------------------	
			when loadr3 =>
				ZloOut <= '1'; Yin <= '1'; 
			when loadr4 =>	
				Cout <= '1'; ADD <= '1'; Zin <= '1'; 
			when loadr5 =>
				ZloOut <= '1'; MARin <= '1'; 
			when loadr61 =>	MDRin <= '1'; ReadSig  <= '1'; 
			when loadr62 =>	MDRin <= '1'; ReadSig  <= '1'; 
			when loadr63 =>	MDRin <= '1'; ReadSig  <= '1'; 
			when loadr7 =>
				MDRout <= '1'; GRA <= '1'; Rin <= '1';  
			-------------------------------------------
			when storer3 =>
				Cout <= '1'; Yin <= '1'; 
			when storer4 =>
				PCout <= '1'; Zin <= '1'; ADD  <= '1'; 
			when storer5 =>
				ZLoOut <= '1'; MARin <= '1'; 
			when storer6 =>
				GRA <= '1'; Rout <= '1'; MDRin <= '1'; 
			when storer7 =>
				MDROut <= '1'; WriteSig <= '1'; 
			-------------------------------------------
			when add3 =>
				Rout <= '1'; GRB <= '1'; Yin <= '1'; 
			when add4 =>
				Rout <= '1'; GRC <= '1'; ADD <= '1'; Zin <= '1'; 
			when add5 =>
				ZLoOut <= '1'; Rin <= '1'; GRA <= '1'; 
			-------------------------------------------
			when sub3 =>
				Rout <= '1'; GRB <= '1'; Yin <= '1'; 
			when sub4 =>
				Rout <= '1'; GRC <= '1'; SUB <= '1'; Zin <= '1'; 
			when sub5 =>
				ZLoOut <= '1'; Rin <= '1'; GRA <= '1'; 
			-------------------------------------------
			when and3 =>
				Rout <= '1'; GRB <= '1'; Yin <= '1'; 
			when and4 =>
				Rout <= '1'; GRC <= '1'; ANDop <= '1'; Zin <= '1'; 
			when and5 =>
				ZLoOut <= '1'; Rin <= '1'; GRA <= '1'; 
			-------------------------------------------
			when or3 =>
				Rout <= '1'; GRB <= '1'; Yin <= '1'; 
			when or4 =>
				Rout <= '1'; GRC <= '1'; ORop <= '1'; Zin <= '1'; 
			when or5 =>
				ZLoOut <= '1'; Rin <= '1'; GRA <= '1'; 
			-------------------------------------------
			when shr3 =>
				Rout <= '1'; GRB <= '1'; Yin <= '1'; 
			when shr4 =>
				Rout <= '1'; GRC <= '1'; SHR <= '1'; Zin <= '1'; 
			when shr5 =>
				ZLoOut <= '1'; Rin <= '1'; GRA <= '1'; 
			-------------------------------------------
			when shl3 =>
				Rout <= '1'; GRB <= '1'; Yin <= '1'; 
			when shl4 =>
				Rout <= '1'; GRC <= '1'; SHL <= '1'; Zin <= '1'; 
			when shl5 =>
				ZLoOut <= '1'; Rin <= '1'; GRA <= '1'; 
			-------------------------------------------
			when rotr3 =>
				Rout <= '1'; GRB <= '1'; Yin <= '1'; 
			when rotr4 =>
				Rout <= '1'; GRC <= '1'; ROTR <= '1'; Zin <= '1'; 
			when rotr5 =>
				ZLoOut <= '1'; Rin <= '1'; GRA <= '1'; 
			-------------------------------------------
			when rotl3 =>
				Rout <= '1'; GRB <= '1'; Yin <= '1'; 
			when rotl4 =>
				Rout <= '1'; GRC <= '1'; ROTL <= '1'; Zin <= '1'; 
			when rotl5 =>
				ZLoOut <= '1'; Rin <= '1'; GRA <= '1'; 
			-------------------------------------------
			when addi3 =>
				Rout <= '1'; GRB <= '1'; Yin <= '1'; 
			when addi4 =>
				Cout <= '1'; ADD <= '1'; Zin <= '1'; 
			when addi5 =>
				ZLoOut <= '1'; Rin <= '1'; GRA <= '1'; 
			-------------------------------------------
			when andi3 =>
				Rout <= '1'; GRB <= '1'; Yin <= '1'; 
			when andi4 =>
				Cout <= '1'; ANDop <= '1'; Zin <= '1'; 
			when andi5 =>
				ZLoOut <= '1'; Rin <= '1'; GRA <= '1'; 
			-------------------------------------------
			when ori3 =>
				Rout <= '1'; GRB <= '1'; Yin <= '1'; 
			when ori4 =>
				Cout <= '1'; ORop <= '1'; Zin <= '1'; 
			when ori5 =>
				ZLoOut <= '1'; Rin <= '1'; GRA <= '1'; 
			-------------------------------------------
			when mul3 =>
				Rout <= '1'; GRA <= '1'; Yin <= '1';  
			when mul4 =>
				Rout <= '1'; GRB <= '1'; Zin <= '1'; MUL <= '1'; 
			when mul5 =>
				ZLoOut <= '1'; LoIn <= '1'; 
			when mul6 =>
				ZHiOut <= '1'; HiIn <= '1'; 
			-------------------------------------------
			when div3 =>
				Rout <= '1'; GRA <= '1'; Yin <= '1';  
			when div4 =>
				Rout <= '1'; GRB <= '1'; Zin <= '1'; DIV <= '1'; 
			when div5 =>
				ZLoOut <= '1'; LoIn <= '1'; 
			when div6 =>
				ZHiOut <= '1'; HiIn <= '1'; 
			-------------------------------------------
			when neg3 =>
				Rout <= '1'; GRB <= '1'; Zin <= '1';  NEG <= '1';
			when neg4 =>
				ZLoOut <= '1'; GRA <= '1'; Rin <= '1';
			-------------------------------------------
			when not3 =>
				Rout <= '1'; GRB <= '1'; Zin <= '1';  NOTop <= '1';
			when not4 =>
				ZLoOut <= '1'; GRA <= '1'; Rin <= '1';
			-------------------------------------------
			when br3 =>
				Rout <= '1'; GRA <= '1'; CONin <= '1';
			when br4 =>
				Rout <= '1'; GRB <= '1'; PCin <= '1';
			-------------------------------------------
			when jr3 =>
				Rout <= '1'; GRA <= '1'; PCin <= '1';
			-------------------------------------------
			when jal3 =>
				PCout <= '1'; IncPC <= '1'; Zin <= '1'; 
			when jal4 =>
				ZLoOut <= '1'; RA_en <= '1'; 
			when jal5 =>
				Rout <= '1'; GRA <= '1'; PCin <= '1'; 
			-------------------------------------------
			when in3 =>
				Rout <= '1'; GRA <= '1'; Outport_en <= '1';
			-------------------------------------------
			when out3 =>
				InportOut <= '1'; Rin <= '1'; GRA <= '1';
			-------------------------------------------
			when mfhi3 =>
				HiOut <= '1'; Rin <= '1'; GRA <= '1';
			-------------------------------------------
			when mflo3 =>
				LoOut <= '1'; Rin <= '1'; GRA <= '1';
			-------------------------------------------
			when nop => --do nothing
			-------------------------------------------
			when halt =>
				Run <= '0';
			-------------------------------------------
			-------------------------------------------
			when others =>
		end CASE;
	END PROCESS;
END;
