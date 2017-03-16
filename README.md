# cpuProj

> **"Move! That! BusMux!"** _- Extreme Makeover: Comp Edition_


# Jump to
1. [Bugs] (#bugs)
2. [Sam's Notebook] (#sams-notebook)
3. [Bulletin Board] (#bulletin-board)
    1. [Phase 1] (#phase-1)
    2. [Phase 2] (#phase-2)
    3. [Phase 3] (#phase-3)
    4. [Phase 4] (#phase-4)
    5. [Bonus] (#bonus)
4. [OpCodes Reference] (#OpCodes)

***
## Bugs

## Sam's notebook

 * Total Compilation fails, but A & E and ModelSim works fine ... fixed for Phase 2
 

### Signals inside Processes
http://stackoverflow.com/questions/15485749/vhdl-variable-vs-signal
The sequential statements inside a process operate on the values they are at immediately before the process begins 


ie. If two signals val and clk change from 0 to 1 at 10ns and you have two different processes
```VHDL
ex1_proc :process(val)
begin
  output1 => val; 
end ex1_proc;

ex2_proc : process(clk)
begin
  output2 => val;
end ex2_proc;
```
`output1 = 0` and `output2 = 1`

### To Do
 
* Plan of Attack
 	(2017/03/15)
 	* connect RAM & rewire MAR to output to RAM
	* rewire differing ports from Phase I
		* Gra, Grb, Grc, Rin, Rout, BAout ports replacing RegIn/Regout (not ones going to bus)
		* add CONin signal
		* remove inport/outport, opcode ports?
***
## Bulletin Board
## Phase 2
## Work to Be Done
* Memory Subsystem
	* create MAR register
	* connect MDR
* Select and Encode
	* configure Input Enables
	* Configure BusMuxOutSelects
	* Connect IR to C_sign_extended register (?)
* Redesign Top Level
	1. Reconfigure cpu_codyale
		* Remove multibit regin & regout ports
		* add Gra/b/c, BA (Base Address) inputs & Rin & Rout inputs
	2. Reconfigure cpu_codyale_tb instructions & component
		*  remove old ALU instructions & add new instructions
* CON FF Logic (used for branching, 
* Input, Output Ports (let's use Strobe and get rid of Portin signals)


    
    
### Macro Work

## Work in Progress

## Work to be Tested
* Revision to R0 (S)

## Work Completed
* MAR (S)
***

## OpCodes
00101   Add  
00110   Subtract  
00111   And  
01000   Or  
01001   Shift Right  
01010   Shift Left  
01011   Rotate Right  
01100   Rotate Left  
01101   Add immediate  
01110   And immediate  
01111   Or Immediate  
10000   Multiply  
10001   Divide  
10010   Negate  

Extras
11000   Ripple Carry Adder (soon to be Carry Lookahead Adder)  
11001   Booth Multiplier with Bit Pair Recoding (if we get there)     
