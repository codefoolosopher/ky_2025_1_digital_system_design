`timescale 1ns / 1ps

module Timer_PWM (
  input clk,                 // Clock signal
  input reset,               // Reset signal
  input [31:0] load_value,   // Timer period
  input [31:0] compare_value,// Duty cycle value
  output reg pwm_out,        // PWM output signal
  output reg [31:0] timer_value // Current timer value
);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      timer_value <= 0;       // Reset timer value
      pwm_out <= 0;           // Reset PWM output
    end else begin
      if (timer_value < load_value) begin
        timer_value <= timer_value + 1; // Increment timer value
      end else begin
        timer_value <= 0;     // Reset timer when period is reached
      end
      
      // Generate PWM signal based on compare value
      if (timer_value < compare_value) begin
        pwm_out <= 1;         // Logic High for duty cycle duration
      end else begin
        pwm_out <= 0;         // Logic Low for remaining period
      end
    end
  end

endmodule
