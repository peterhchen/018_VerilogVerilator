// toggle Flip Flop
module tff (q, clk, reset);
  output reg q;
  input clk, reset;

  //  always @(posedge reset or posedge clk) begin
  // 1) First way to fix counter: change posedge to negedge
  // always @(posedge reset or negedge clk) begin
  // 2) Second way: keep the posedge clk. 
  // Bit need to inverse the output ~ck, ~q[0], ~q[1]. ~q[2]
  always @(posedge reset or posedge clk) begin
     if (reset) begin
         q <= 1'b0;
     end else begin
          q <= ~q;
     end
   end
endmodule

module ripple_carry_counter (q, clk, reset);
   output [3:0] q;
   input clk, reset;

   // 1) No change
   //tff tff0 (q[0], clk, reset);
   // tff tff1 (q[1], q[0], reset);
   // tff tff2 (q[2], q[1], reset);
   // tff tff3 (q[3], q[2], reset);
   // 2) change 
   tff tff0 (q[0], ~clk, reset);
   tff tff1 (q[1], ~q[0], reset);
   tff tff2 (q[2], ~q[1], reset);
   tff tff3 (q[3], ~q[2], reset);
endmodule