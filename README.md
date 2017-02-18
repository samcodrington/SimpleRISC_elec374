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
* ALU adder/subtractor seems to use the values given to it right before receiving the "ADD/SUB" opcode

## Sam's notebook
* ALU add subtract function outputs values taken right before opcode selects it... why? fixable?
* need to make sure bus/ALU works inside of 1 clock cycle per norm
* check twos works as a concurrent statement
* 

***
## Bulletin Board
## Phase 1
## Work to Be Done
### Components 
  * ALU
    * MUL
      * Array MUL
      * Booth MUL
      * *BONUS* Booth w/Bit Pair Recoding
    
    
### Macro Work
* Connect Bus to ALU
* Phase 1 Test Bench  

## Work in Progress
* Connect Arithmetic Components within ALU (S)
* Connect all registers to Bus & check that they are wired properly (S)
## Work to be Tested
* Enclose BusMux with Encoder into CPU_Bus (S)
* Connect MDR register to the bus (S)
* 2s COMPLEMENT (NEG) (S)


## Work Completed
* BusMux
* Bus Encoder
* 32 bit Register
* MDR
* ADD/SUB
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
11111   IncPC (add by 4)

Extras
11000   Ripple Carry Adder (soon to be Carry Lookahead Adder)
11001   Booth Multiplier with Bit Pair Recoding (if we get there)   
