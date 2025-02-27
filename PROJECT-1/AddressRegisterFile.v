`timescale 1ns / 1ps

module AddressRegisterFile(I,Clock,OutCSel,OutDSel,RegSel,FunSel,OutC,OutD);
    input wire [15:0] I;
    input wire Clock;
    input wire [1:0] OutCSel;
    input wire [1:0] OutDSel;
    input wire [2:0] RegSel, FunSel;
    output reg [15:0] OutC, OutD;
    
    wire E_PC, E_AR, E_SP;
    wire [15:0] Q_PC, Q_AR, Q_SP;
    
    assign {E_PC, E_AR, E_SP} = RegSel;
    
    Register PC(.I(I),.Clock(Clock),.FunSel(FunSel),.Q(Q_PC), .E(~E_PC));
    Register AR(.I(I),.Clock(Clock),.FunSel(FunSel),.Q(Q_AR), .E(~E_AR));
    Register SP(.I(I),.Clock(Clock),.FunSel(FunSel),.Q(Q_SP), .E(~E_SP));
    
        always @ (*) begin
     case(OutCSel)
       2'b00: OutC <= Q_PC;
       2'b01: OutC<= Q_PC;
       2'b10: OutC <= Q_AR;
       2'b11: OutC <= Q_SP;
       
       endcase
       case(OutDSel)
              2'b00: OutD <= Q_PC;
              2'b01: OutD<= Q_PC;
              2'b10: OutD <= Q_AR;
              2'b11: OutD <= Q_SP;
       endcase
       end
      
endmodule
