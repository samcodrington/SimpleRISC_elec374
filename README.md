# cpuProj

> **"Move! That! BusMux!"** _- Extreme Makeover: Comp Edition_


# Jump to
1. [Bugs] (#bugs)
2. [Bulletin Board] (#bulletin-board)
    1. [Phase 1] (#phase-1)
    2. [Phase 2] (#phase-2)
    3. [Phase 3] (#phase-3)
    4. [Phase 4] (#phase-4)
    5. [Bonus] (#bonus)

***
## Bugs
*Register outputs need to be mapped to signals so the output can be shown in the test bench.
  * These signals will go to their destinations as well as top-level port
***
## Bulletin Board
## Phase 1
## Work to Be Done
### Components 
  * ALU
    * ADD/SUB
    * MUL
      * Array MUL
      * Booth MUL
      * *BONUS* Booth w/Bit Pair Recoding
    * DIV
    * OR
    * SHR/SHL 
    
### Macro Work
* Connect MDR register to the bus (S)
* Connect Arithmetic Components within ALU
* Connect Bus to ALU  

## Work in Progress
* Connect all registers to Bus & check that they are wired properly (S)
## Work to be Tested
* Enclose BusMux with Encoder into CPU_Bus (S)


## Work Completed
* BusMux
* Bus Encoder
* 32 bit Register
* MDR

***
