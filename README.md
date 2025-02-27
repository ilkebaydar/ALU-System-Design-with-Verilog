# INTRODUCTION
 In this project, we have implemented registers, register file including Address Register,
 Instruction Register, Arithmetic Logic Unit and Arithmetic Logic Unit System. Moreover,
 inside this implementation, we can make arithmetic and logical operations and we can
 store the results of the operations with using memory and registers.
 # MATERIALS AND METHODS
 To implement this project, we used Verilog Hardware Description Language. As source
 materials, we benefited the given Verilog introduction slides, Digital Circuit Course’s slides
 [1] and the textbook Computer System Architecture by Morris Mano[2]. I and my teammate Beyza Türk carried out
 the implementation of this project in four parts. We designed, tested, simulated and
 reported each part together.
# DISCUSSION
 As we have explained in previous parts, we have started with describing different kind
 of registers and continued with implementing ALU which can perform both arithmetic
 (addition, substraction, complement etc.) and logic (AND, OR, XOR etc.) operations.
 After connecting the parts, we obtained an ALU system which is a basic architecture of
 a computer system, able to execute instructions, manipulate data, and perform various
 computational tasks.
 
# CONCLUSION
 Initially, we struggled to adapt to Verilog syntax and operational principles. At this
 stage, we benefited from the provided slides. We did not encounter much difficulty while
 implementing because instructions were given from basic to complex. However, during
 operations with 8-bit inputs and a 16-bit ALU, we faced uncertainty regarding whether to
 convert inputs to 16 bits with sign extension. Following the testing phase, we resolved this
 by appending 8-bit zeros to the higher half of the ALU to ensure successful test passage.
 Another problem that we encountered was ALU System simulation. We have failed 6
 out of 33 tests but we could not solve them, problems were not connected systemically,
 our implementation passed all tests until the last part. After discussion with another
 groups we have realized that they were passing the tests that we have failed with same
 actual value obtained. Then we solved it after the submission. We have learned how to use Verilog HDL, basic computer
 architecture, how to connect parts, how to test and simulate implementations, how to
 handle with errors.

 # REFERENCES
 [1] Digital Circuit Course Slide-1-2. Buzluca, F. 
 [2] Morris Mano. Computer system architecture third edition. Textbook.
 [3] https://www.geeksforgeeks.org/instruction register/.
 [4] https://www.geeksforgeeks.org/different-classes-of-cpu registers/
