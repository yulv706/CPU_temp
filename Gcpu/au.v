module au(au_en,ac,a,b,t,gf);
  input au_en;
  input [3:0] ac;
  input [7:0] a;
  input [7:0] b;
  output [7:0] t;
  output gf;
  reg [7:0] t;
  reg gf;
  always @(*)
  begin
    t = 8'b00000000;
    gf = 1'b0;
    if (au_en == 1'b0) 
      begin
      t = 8'hZZ;
      end 
    else
      begin
      case (ac)
        4'b1000: begin 
          t = a + b;
        end
        4'b1001: begin 
          t = b - a;
          if(b[7]==1'b0&&a[7]==1'b1) gf = 1'b1;
          else if(b[7]==1'b1&&a[7]==1'b0) gf = 1'b0;
          else if(b>a) gf = 1'b1;
          else gf= 1'b0;
        end
        4'b0100, 4'b0101, 4'b1101: begin 
          t = a;
        end
        default: begin 
          t = 8'hZZ;
        end
      endcase
      end
  end
endmodule