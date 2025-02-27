`timescale 1ns / 1ps

module ArithmeticLogicUnit (
    input  [15:0] A,
    input [15:0] B,
    input  [4:0] FunSel,
    input  WF,
    input  Clock,
    output reg [15:0] ALUOut,
    output reg [3:0] FlagsOut
    );
   
    reg [16:0] temp;

    wire Z ;
    wire C;
    wire N;
    wire O;

   always @ (*) begin
     case(FunSel)
       //8-bit operation
     5'b00000: //out A
      begin
      ALUOut[7:0] = A[7:0];
      ALUOut[15:8] =  {8'b0};
      end
        
      5'b00001:// out B
      begin
      ALUOut[7:0] = B[7:0];
      ALUOut[15:8] =  {8'b0};
      end
        
      5'b00010: // not A
      begin
      ALUOut[7:0] = ~A[7:0];
      ALUOut[15:8] =  {8'b0};
      end
         
      5'b00011: // not b
      begin
      ALUOut[7:0] = ~B[7:0];
      ALUOut[15:8] =  {8'b0};
      end
         
      5'b00100: // a+b
      begin
      temp=A+B;        
      ALUOut=temp;
      end
       
     5'b00101: //a+b+carry
     begin
     temp = A + B ;
     temp= temp+ FlagsOut[2];
     ALUOut = temp;
    end
       
     5'b00110: //a-b
     begin
     temp = A + ~B + 1;
     ALUOut = temp;
     end
         
     5'b00111: //a and b
     begin
      ALUOut[7:0] = A & B;
      ALUOut[15:8]= {8'b0};
     end
       
     5'b01000://a or b
     begin
     ALUOut[7:0] = A | B; 
     ALUOut[15:8]= {8'b0};
     end
       
      5'b01001: //a xor b
      begin
      ALUOut[7:0] = A ^ B; 
      ALUOut[15:8]= {8'b0};   
      end
       
      5'b01010: //a nand b
      begin
      ALUOut[7:0] = ~(A & B);
      ALUOut[15:8]= {8'b0};
      end
       
       5'b01011: //LSL A
       begin
       ALUOut[7:0] = A[7:0];
       ALUOut = ALUOut << 1;
       ALUOut[15:8]={8'b0};
       temp= A[7];
       end
       
       5'b01100: //LSR A
       begin
       ALUOut[7:0] = A[7:0];
       ALUOut = ALUOut >> 1;
       ALUOut[15:8]={8'b0};
       temp= A[0];
        end
    
       5'b01101: //ASR A
       begin
       ALUOut[7:0]=A[7:0];
       ALUOut = {8'b0, A[7], A[7:1]};
       temp= A[0];
       end
           
       5'b01110: //CSL A
       begin
       temp=A[7];
       ALUOut = {8'b0, A[6:0], A[7]};
      end
       5'b01111: //CSR A
       begin
       temp=A[0];
       ALUOut = {8'b0, A[0], A[7:1]};
       end
  
  //16-bit operations
     5'b10000: //out A
      begin
      ALUOut = A;
      end
      
     5'b10001:// out B
     begin
     ALUOut=B;
     end
      
    5'b10010: // not A 
     begin
     ALUOut = ~A;
     end
       
   5'b10011: //not b
   begin
     ALUOut = ~B;
    end       
      
   5'b10100: //a+b
   begin
   temp=A+B; 
    ALUOut=temp;
    end
    
    5'b10101: //a+b+carry
    begin
    temp = A + B ;
    temp= temp+ FlagsOut[2];
    ALUOut = temp;
end   

  5'b10110: //a-b
   begin
   temp = A + ~B + 1;
    ALUOut = temp;
      end
      
      5'b10111: //a and b
      begin
      ALUOut = A & B;
      end
      
      5'b11000://a or b
      begin
     ALUOut = A | B; 
      end
      
     5'b11001: //a xor b
     begin
     ALUOut = A ^ B; 
     end
      
      5'b11010: //a nand b
      begin
        ALUOut = ~(A & B);
      end         
      
     5'b11011: //LSL A
      begin
     ALUOut={A[14:0],{1'b0}};
     temp= A[15];
     end
      
      5'b11100: //LSR A
      begin
     ALUOut={{1'b0}, A[15:1]};
     temp= A[0];
      end

      5'b11101: //ASR A
      begin
      ALUOut = {A[15], A[15:1]};
      temp= A[0];
      end
          
      5'b11110: //CSL A
      begin
      temp=A[15];
      ALUOut = {A[14:0], A[15]};
     end
     
      
      5'b11111: //CSR A
      begin
      temp=A[0];
      ALUOut = {A[0], A[15:1]};
     end
     
      
  endcase
  end  
  //*******************************************************************************
  //*******************************************************************************
  //*******************************************************************************
   always @ (posedge Clock) begin //for flags

        
  case(FunSel)
      //8-bit operation
      5'b00000: //out A
      begin

      if(WF) begin
          if(ALUOut[7]==1) //negative
          FlagsOut[1]=1;
          else  FlagsOut[1]=0;
          if(ALUOut== 15'b0) begin //zero
              FlagsOut[3] =1;
          end
          else   FlagsOut[3] =0;
       end  
      end
      
      5'b00001:// out B
      begin

      if(WF) begin
        if(ALUOut[7]==1) //negative
        FlagsOut[1]=1;
        else  FlagsOut[1]=0;
        if(ALUOut== 15'b0) begin //zero
        FlagsOut[3] =1;
        end
       else   FlagsOut[3] =0;
      end
      end
      
     5'b00010: // not A
      begin

       if(WF) begin
         if(ALUOut[7]==1) //negative
         FlagsOut[1]=1;
         else  FlagsOut[1]=0;
         if(ALUOut== 16'b0) begin //zero
          FlagsOut[3] =1;
         end
         else   FlagsOut[3] =0;
       end
      end
       
    5'b00011: // not b
    begin

    if(WF) begin

       if(ALUOut[7]==1) //negative
         FlagsOut[1]=1;
         else  FlagsOut[1]=0;
       if(ALUOut== 16'b0) begin //zero
       FlagsOut[3] =1;
      end
      else FlagsOut[3] =0;
    end
    end
       
    5'b00100: // a+b
    begin
    temp= A+B;
      if(WF)begin
         if(ALUOut==0)FlagsOut[3]=1; //zero
         else FlagsOut[3]=0;
         FlagsOut[2]=temp[8];//carry
         FlagsOut[1]=temp[7]; //negative
         if(A[7]== B[7] && A[7] != ALUOut[7])begin //overflow
             FlagsOut[0]=1;
           end
           else FlagsOut[0]=0;
         end
      end
     
   5'b00101: //a+b+carry
   begin
    temp = A + B + FlagsOut[2];
   if(WF)begin
     if(ALUOut==0)FlagsOut[3]=1; //zero
     else FlagsOut[3]=0;
    FlagsOut[2]=temp[8];//carry
    FlagsOut[1]=temp[7]; //negative
    if(A[7]== B[7] && A[7] != ALUOut[7])begin //overflow
       FlagsOut[0]=1;
    end
    else FlagsOut[0]=0;
   end
  end
     
     5'b00110: //a-b
     begin
     temp = A + ~B + 1;
     if(WF) begin
      if(ALUOut == 0) begin
      FlagsOut[3]=1;
      end 
      else FlagsOut[3]=0;
     FlagsOut[2]=temp[8];//carry
     FlagsOut[1]=temp[7]; //negative
     if(A[7]==B[7]==0 && ALUOut[7]==1) begin //overflow
          if(A>B) FlagsOut[0]=1;
          else FlagsOut[0]=0;
     end
      if(A[7]==B[7]==1 && ALUOut[7]==0) begin
          if(A<B) FlagsOut[0]=1;
          else FlagsOut[0]=0;
      end
      if(A[7]==B[7]==ALUOut[7]==1) begin
          if(A>B) FlagsOut[0]=1;
          else FlagsOut[0]=0;
      end
        if(B[7]==ALUOut[7] != A[7]) FlagsOut[0]=1;
        else FlagsOut[0]=0;
      end
    end
       
     5'b00111: //a and b
     begin
     if(WF) begin
     if(ALUOut==0) FlagsOut[3]=1; //zero
     else FlagsOut[3]=0;
     if(ALUOut[7]==1) FlagsOut[1]=1; //negative
     else FlagsOut[1]=0;
     
     end
     end
     
     5'b01000://a or b
     begin
    if(WF)begin
    if(ALUOut[7]==1) FlagsOut[1]=1; //negative
    else FlagsOut[1]=0;
    if(ALUOut==0) FlagsOut[3]=1; //zero
    else FlagsOut[3]=0;
   end
   end 
    5'b01001: //a xor b
    begin
   if(WF) begin
          if(ALUOut[7]==1) FlagsOut[1]=1; //negative
          else FlagsOut[1]=0;
          if(ALUOut==0) FlagsOut[3]=1; //zero
          else FlagsOut[3]=0;    
     end
     end
     
     5'b01010: //a nand b
     begin
     if(WF) begin
          if(ALUOut[7]==1) FlagsOut[1]=1; //negative
          else FlagsOut[1]=0;
          if(ALUOut==0) FlagsOut[3]=1; //zero
          else FlagsOut[3]=0;
     end
     end
     5'b01011: //LSL A
     begin
     temp= A[7];
        if(WF) begin
          if(temp==1) FlagsOut[2]=1; //carry
          else FlagsOut[2]=0;
        if(ALUOut=={16'b0}) FlagsOut[3]=1; //zero
        else FlagsOut[3]=0;
        if(ALUOut[7]==1) FlagsOut[1]=1; //negative
        else FlagsOut[1]=0;
      end
    end
     
     5'b01100: //LSR A
     begin
     temp= A[0];
        if(WF) begin
           if(temp==1) FlagsOut[2]=1; //carry
           else FlagsOut[2]=0;
          if(ALUOut=={16'b0}) FlagsOut[3]=1; //zero
          else FlagsOut[3]=0;
          
        FlagsOut[1]=0; //negative
       end  
      end
  
     5'b01101: //ASR A
     begin
     temp= A[0];
     if(WF) begin
       if(temp==1) FlagsOut[2]=1; //carry
       else FlagsOut[2]=0;
       if(ALUOut=={16'b0}) FlagsOut[3]=1; //zero
       else FlagsOut[3]=0;       
      end  
     end
         
     5'b01110: //CSL A
     begin
     temp=A[7];
     if(WF) begin
       if(temp==1) FlagsOut[2]=1; //carry
       else FlagsOut[2]=0;
       if(ALUOut=={16'b0}) FlagsOut[3]=1; //zero
       else FlagsOut[3]=0;
       if(ALUOut[7]==1) FlagsOut[1]=1; //negative
       else FlagsOut[1]=0;        
     end
    end
     5'b01111: //CSR A
     begin
     temp=A[0];
     if(WF) begin
       if(temp==1) FlagsOut[2]=1; //carry
       else FlagsOut[2]=0;
       if(ALUOut=={16'b0}) FlagsOut[3]=1; //zero
       else FlagsOut[3]=0;
       if(ALUOut[7]==1) FlagsOut[1]=1; //negative
       else FlagsOut[1]=0;        
     end       
    end

//16-bit operations
   5'b10000: //out A
    begin

    if(WF) begin
     if(ALUOut[15]==1) //negative
     FlagsOut[1]=1;
     else FlagsOut[1]=0;
     if(ALUOut== 16'b0) begin //zero
     FlagsOut[3] =1;
     end
    else FlagsOut[3] =0;
    end   
    end
    
   5'b10001:// out B
   begin

     if(WF) begin
       if(ALUOut[15]==1)
         FlagsOut[1]=1;
       else  FlagsOut[1]=0;
       if(ALUOut== 16'b0) begin
         FlagsOut[3] =1;
        end
      else FlagsOut[3] =0;
    end
    end
    
     5'b10010: // not A 
     begin

     if(WF) begin
       if(ALUOut[15]==1)
       FlagsOut[1]=1;
       else  FlagsOut[1]=0;
      if(ALUOut== 16'b0) begin
       FlagsOut[3] =1;
       end
      else FlagsOut[3] =0;
     end
     end
     
 5'b10011: //not b
 begin

   if(WF) begin
   if(ALUOut[15]==1)
        FlagsOut[1]=1;
    else  FlagsOut[1]=0;
    if(ALUOut== 16'b0) begin
    FlagsOut[3] =1;
  end
  else  FlagsOut[3] =0;
  end 
  end    
     
    
    5'b10100: //a+b
    begin
    temp=A+B;
      if(WF)begin
          if(ALUOut==0)FlagsOut[3]=1; //zero
          else FlagsOut[3]=0;
          FlagsOut[2]=temp[16];//carry
          FlagsOut[1]=temp[15]; //negative
          if(A[15]== B[15] && A[15] != ALUOut[15])begin //overflow
                FlagsOut[0]=1;
          end
          else FlagsOut[0]=0;
      end
    end
  
5'b10101: //a+b+carry
begin
temp = A + B + FlagsOut[2];
if(WF)begin
  if(ALUOut==0)FlagsOut[3]=1; //zero
  else FlagsOut[3]=0;
FlagsOut[2]=temp[16];//carry
FlagsOut[1]=temp[15]; //negative
if(A[15]== B[15] && A[15] != ALUOut[15])begin //overflow
FlagsOut[0]=1;
end
else FlagsOut[0]=0;
end
end   

    5'b10110: //a-b
     begin
     temp = A + ~B + 1;
     if(WF) begin
      if(ALUOut == 0) begin
      FlagsOut[3]=1;
      end 
      else FlagsOut[3]=0;
     FlagsOut[2]=temp[16];//carry
     FlagsOut[1]=temp[15]; //negative
     if(A[15]==B[15]==0 && ALUOut[15]==1) begin //overflow
          if(A>B) FlagsOut[0]=1;
          else FlagsOut[0]=0;
     end
      if(A[15]==B[15]==1 && ALUOut[15]==0) begin
          if(A<B) FlagsOut[0]=1;
          else FlagsOut[0]=0;
      end
      if(A[15]==B[15]==ALUOut[15]==1) begin
          if(A>B) FlagsOut[0]=1;
          else FlagsOut[0]=0;
      end
        if(B[15]==ALUOut[15] != A[15]) FlagsOut[0]=1;
        else FlagsOut[0]=0;
      end
    end
    
    5'b10111: //a and b
    begin
if(WF) begin
    if(ALUOut[15]==1) FlagsOut[1]=1; //negative
    else FlagsOut[1]=0;
    if(ALUOut==0) FlagsOut[3]=1;
    else FlagsOut[3]=0;
    end
    end
    5'b11000://a or b
    begin
   if(WF) begin
   if(ALUOut[15]==1) FlagsOut[1]=1; //negative
   else FlagsOut[1]=0;
   if(ALUOut==0) FlagsOut[3]=1; //zero
   else FlagsOut[3]=0;
  end
   end 
   5'b11001: //a xor b
   begin
   if(WF) begin
   if(ALUOut[15]==1) FlagsOut[1]=1; //negative
   else FlagsOut[1]=0;
   if(ALUOut==0) FlagsOut[3]=1;
   else FlagsOut[3]=0;    
   end
    end
    5'b11010: //a nand b
    begin
     if(WF) begin
     if(ALUOut[15]==1) FlagsOut[1]=1; //negative
     else FlagsOut[1]=0;
     if(ALUOut==0) FlagsOut[3]=1;
    else FlagsOut[3]=0;
    end         
    end
   5'b11011: //LSL A
    begin
   temp= A[15];
   if(WF) begin
     if(temp==1) FlagsOut[2]=1; //carry
      else FlagsOut[2]=0;
      if(ALUOut=={16'b0}) FlagsOut[3]=1; //zero
      else FlagsOut[3]=0;
      if(ALUOut[15]==1) FlagsOut[1]=1; //negative
      else FlagsOut[1]=0;
   end
   end
    
    5'b11100: //LSR A
    begin
    temp= A[0];
    if(WF) begin
    if(temp==1) FlagsOut[2]=1; //carry
     else FlagsOut[2]=0;
     if(ALUOut=={16'b0}) FlagsOut[3]=1; //zero
     else FlagsOut[3]=0;
     if(ALUOut[15]==1) FlagsOut[1]=1; //negative
     else FlagsOut[1]=0;
    end
    end

    5'b11101: //ASR A
    begin
    temp= A[0];
    if(WF) begin
    if(temp==1) FlagsOut[2]=1; //carry
    else FlagsOut[2]=0;
    if(ALUOut=={16'b0}) FlagsOut[3]=1; //zero
    else FlagsOut[3]=0;       
     end  
    end
        
    5'b11110: //CSL A
    begin
    temp=A[15];
    if(WF) begin
    if(temp==1) FlagsOut[2]=1; //carry
    else FlagsOut[2]=0;
    if(ALUOut=={16'b0}) FlagsOut[3]=1; //zero
    else FlagsOut[3]=0;
    if(ALUOut[15]==1) FlagsOut[1]=1; //negative
    else FlagsOut[1]=0;        
    end
   end
   
    
    5'b11111: //CSR A
    begin
    temp=A[0];
    if(WF) begin
    if(temp==1) FlagsOut[2]=1; //carry
    else FlagsOut[2]=0;
    if(ALUOut=={16'b0}) FlagsOut[3]=1; //zero
    else FlagsOut[3]=0;
    if(ALUOut[15]==1) FlagsOut[1]=1; //negative
    else FlagsOut[1]=0;        
    end       
   end
   
    
endcase
end  
endmodule
