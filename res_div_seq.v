//	Sequential
// Restoring for 2n/n : signed		// not checking for overflow

`timescale 1ns / 1ps

module res_div_seq(A,B, clk, enable,  Q,R);
parameter W=32; 
input [2*W-1:0] A;
input [W-1:0] B;
input clk, enable;
output reg [W-1:0] Q,R;
reg [2*W-1:0]A_;
reg [W-1:0] A1,A2,B_;
integer i;
reg [W-1:0]X1;
	
always@(posedge clk)
begin 
	if(enable)
			begin  
			i=0;
			if(A[W-1])	begin 	// -ve	
			A_ = ~A + 1'b1;  // 2's complement
			end 
			

	else
 			begin 		//+ve
			A_=A;  
			end	
				
			if(B[W-1])
			begin	
			B_= ~B +1'b1; // B_sign=1'b1; 
			end
				

	else 			
			begin //+ve
			B_=B;
			end		
				
				A1 = A_[2*W-1:W];
				A2 = A_[W-1:0];
				end
	else		
	begin
			if(i<W)    
			begin   	
			 i=i+1;
			{A1,A2}={A1,A2}<<1; 
				//PR=A1;
				X1=A1-B_;
				Q=Q<<1;
				Q[0]=~X1[W-1];
				
				case(Q[0])
				1'b1: A1=X1;
				endcase
				
				/*
				if(A[W-1])  // -ve
					begin
						A2[0]=1'b0;  
						A1=A1+B_;   // restored
					end
				else
					begin 
						A2[0]=1'b1;  
					end 	*/
			end
			else begin		
						if(A[W-1]) 		 R=~A1+1'b1;   // if dividend is -ve
						else		R=A1;
						if(A[W-1] ^ B[W-1]) 	Q=~Q+1'b1; 
						//else 	Q=A2;
//						
						$display("$%d: A=%d, B=%d, Quotient=%d=%b, Rem=%d=%b",$time,A,B,Q,Q,R,R);

			end
	end
end// always
endmodule
