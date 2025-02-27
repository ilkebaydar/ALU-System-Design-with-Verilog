`timescale 1ns / 1ps


module Register(I, FunSel,E,Clock,Q);
  input wire [15:0] I;
  input wire [2:0] FunSel;
  input wire E;
  input wire Clock;
  output reg [15:0] Q;


  always @(posedge Clock)
  begin
  if(E) begin
  case(FunSel)
  3'b000: Q <= Q-1;
  3'b001: Q <= Q+1;
  3'b010: Q <= I;
  3'b011: Q <= 16'b0;
  3'b100: begin 
      Q[15:8] <= 8'b0;
      Q[7:0] <= I[7:0]; 
       
      end
  3'b101: begin
      Q[7:0]<= I[7:0]; 
      Q[15:8]=0;
      end
  3'b110: begin
      Q[15:8]<= I[7:0];
      Q[7:0]=0;
      end
  3'b111: begin
      Q[15:8]<={8{I[7]}};
      Q[7:0] <= I[7:0];
      end
      
  endcase
  end
  
  else begin
  Q <= Q;
  end  

end

endmodule

