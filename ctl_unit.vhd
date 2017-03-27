LIBRARY IEEE;
USE ieee.std_logic_1164.all;

ENTITY ctl_unit IS
	PORT(
		clk, reset, stop, con_ff	:	IN STD_LOGIC;
		IR									:	IN STD_LOGIC_VECTOR(31 DOWNTO 0);
		--Indicators
		run, clr,
		--- Register Control Ports
		Rin, Rout, Gra, Grb, Grc,
		
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
	TYPE State IS (Fetch0, Fetch1, Fetch2,
						load3, load4, load5, load6, load7,
						loadi3, loadi4, loadi5,
						loadr3, loadr4, loadr5, loadr6, loadr7,
						Add3, Add4, Add5, Add6,
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
					Present_State <= fetch1;
				when fetch1 =>
					Present_State <= fetch2;
				
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
				
				when loadi3 =>
					Present_State <= loadi4;
				when loadi4 =>
					Present_State <= loadi5;
				when loadi5 =>
					Present_State <= fetch0;
				
				when fetch2 =>
					Case IR(31 downto 27) is
						when "00000" =>
							Present_State <= load3;
						when "00001" =>
							Present_State <= loadi3;
						when "00101" =>
							Present_State <= add3;
						when others =>
					end case;
				when others =>
			end case;
		end if;
	END PROCESS;
	
	worker : PROCESS(Present_State)
		BEGIN
		--always set signals to 0 then set them to 1 as req'd
		run<= '0'; clr <= '0';
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
				clr <= '1';
			when fetch0 =>
				PCout <= '1'; MARin <= '1'; IncPC <= '1'; Zin<= '1';
			when fetch1 =>
				ZLoOut <= '1'; PCin <= '1'; ReadSig <= '1'; MDRin <= '1';
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
				GRB <= '1'; BAout <= '1'; Yin <= '1'; 
			when loadi4 =>
				Cout <= '1'; ADD <= '1'; Zin <= '1'; 
			when loadi5 =>
				ZLoOut <= '1'; GRA <= '1'; Rin <= '1'; 
			-------------------------------------------	
			
			
			when others =>
		end CASE;
	END PROCESS;
END;
