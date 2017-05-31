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


## License
This project was created for an academic course at Queen's University. Please feel free to look at our work, but do not copy it directly, especially if you are taking this course.

MIT License

Copyright (c) [2017] [Sam Codrington]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

