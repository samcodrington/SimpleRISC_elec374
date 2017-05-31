# cpuProj

> **"Move! That! BusMux!"** _- Extreme Makeover: Comp Edition_
***
## Notes
 * When switching test benches, need to swtich test bench AND ram's mif initializer
 * Total Compilation fails, but A & E and ModelSim works fine ... fixed for Phase 2
 * RAM takes 1 clock cycle to write to memory BUT 3 clock cycles to read. THis is an unavoidable feature of the megafunction used, and does not need to be fixed.
 * Load Relative takes 7 clock cycles not 6 as in phase ii because the standard fetch instructions are modified in specification & that extra cycle is added in.
 * Store takes extra clock cycle as well
 

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



