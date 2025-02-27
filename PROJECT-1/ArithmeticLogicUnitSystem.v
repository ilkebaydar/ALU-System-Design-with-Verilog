`timescale 1ns / 1ps


    

    
module ArithmeticLogicUnitSystem(RF_OutASel, RF_OutBSel, RF_FunSel, RF_RegSel, RF_ScrSel, ALU_FunSel,ALU_WF, ARF_OutCSel, ARF_OutDSel,
ARF_FunSel, ARF_RegSel,IR_LH, IR_Write, Mem_WR, Mem_CS, MuxASel, MuxBSel,MuxCSel, Clock );
    //RegisterFile
    input wire [2:0] RF_OutASel, RF_OutBSel, RF_FunSel;
    input wire [3:0] RF_RegSel, RF_ScrSel;
    wire [15:0] OutA, OutB;
    reg [15:0] MuxAOut;
    
    //ALU
    input wire [4:0] ALU_FunSel;
    wire [3:0] ALU_Flags;
    input wire ALU_WF;
    wire [15:0] ALUOut;
    
    //Address Reg. File
    input wire [1:0] ARF_OutCSel, ARF_OutDSel;
    input wire [2:0] ARF_FunSel, ARF_RegSel;
    reg [15:0] MuxBOut; // redundant??
    wire [15:0] OutC, OutD; // redundant??
    
   //IR
   input wire IR_LH, IR_Write;
   wire  [7:0] MemOut;
	wire [15:0] IROut;
 

  //Memory
  input wire Mem_WR, Mem_CS;
  reg [7:0] MuxCOut;
  wire [15:0] Address;
  assign Address = OutD;
  
  //Mux 
   input wire [1:0] MuxASel, MuxBSel;
   input wire MuxCSel;
   input wire Clock;
   
   Memory MEM(
   .Clock(Clock),
   .Data(MuxCOut),
   .WR(Mem_WR),
   .CS(Mem_CS),
   .MemOut(MemOut),
   .Address(Address)
   );
   
   ArithmeticLogicUnit ALU(
   .A(OutA),
   .B(OutB),
   .FunSel(ALU_FunSel),
   .Clock(Clock),
   .ALUOut(ALUOut),
   .FlagsOut(ALU_Flags),
   .WF(ALU_WF)   
   );
   
   
   RegisterFile RF(
   .Clock(Clock),
   .I(MuxAOut),
   .OutASel(RF_OutASel),
   .OutBSel(RF_OutBSel),
   .FunSel(RF_FunSel),
   .RegSel(RF_RegSel),
   .ScrSel(RF_ScrSel),
   .OutA(OutA),
   .OutB(OutB)
   );
   
   
   AddressRegisterFile ARF(
   .I(MuxBOut),
   .Clock(Clock),
   .OutCSel(ARF_OutCSel),
   .OutDSel(ARF_OutDSel),
   .RegSel(ARF_RegSel),
   .FunSel(ARF_FunSel),
   .OutC(OutC),
   .OutD(OutD)
   );
   
   InstructionRegister IR(
   .Clock(Clock),
   .I(MemOut),
   .Write(IR_Write),
   .LH(IR_LH),
   .IROut(IROut)
   );
   
   always@(*)begin
        case(MuxASel)
           2'b00:begin
             MuxAOut=ALUOut;
        end
           2'b01:begin
             MuxAOut=OutC;
        end            
            2'b10:begin
             MuxAOut[7:0]=MemOut;
             MuxAOut[15:8]=0;
        end
            2'b11:begin
             MuxAOut[7:0]=IROut[7:0];
            MuxAOut[15:8]=0;
        end              
        endcase
        case(MuxBSel)
           2'b00:begin
             MuxBOut=ALUOut;
        end
           2'b01:begin
             MuxBOut=OutC;
        end            
            2'b10:begin
             MuxBOut[7:0]=MemOut;
             MuxBOut[15:8]=8'd0;
        end
            2'b11:begin
             MuxBOut[7:0]=IROut[7:0];
            MuxBOut[15:8]=8'd0;
        end              
        endcase
         case(MuxCSel)
           1'b0:begin
             MuxCOut=ALUOut[7:0];
        end
           1'b1:begin
             MuxCOut=ALUOut[15:8];
        end            
             
        endcase                 
   end

   endmodule
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   

