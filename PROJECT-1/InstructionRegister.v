`timescale 1ns / 1ps


module InstructionRegister(Clock,I,Write,LH,IROut);
    input wire Clock;  
    input wire [7:0] I;
    input Write;
    input LH;
    output reg[15:0] IROut;
    
   always @(posedge Clock) begin
     
      case(LH)
      
      1'b0: begin if(Write) begin IROut[7:0] = I ;end else begin IROut<=IROut; end end
      1'b1: begin if(Write)begin IROut[15:8] = I;end else begin IROut<=IROut; end  end
    
      endcase  

  
   end
endmodule
