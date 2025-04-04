`timescale 1ns/1ps

module pwm_testbench;

  reg clk;                  // Clock signal
  reg reset;                // Reset signal
  reg [31:0] load_value;    // Timer period value
  reg [31:0] compare_value; // Duty cycle value
  wire pwm_out;             // PWM output signal
  wire [31:0] timer_value;  // Current timer value

  // Instantiate the Timer_PWM module
  Timer_PWM uut (
    .clk(clk),
    .reset(reset),
    .load_value(load_value),
    .compare_value(compare_value),
    .pwm_out(pwm_out),
    .timer_value(timer_value)
  );

  // Clock generation (10 ns clock period)
  initial begin
    clk = 0;
    forever #5 clk = ~clk;   // Generate a clock with a period of 10 time units
  end

  // Test sequence for observing three PWM cycles
  initial begin
    $display("Starting simulation for observing three PWM cycles...");
    
    reset = 1;
    load_value = 32'd100;     // Set timer period to 100 clock cycles
    
    #10 reset = 0;            // Release reset after some time
    
    // Cycle 1: Duty cycle = 50%
    compare_value = 32'd50;   // Set duty cycle to 50%
    $display("Cycle 1: Period = %d, Duty Cycle = %d%%", load_value, (compare_value * 100) / load_value);
    
    repeat (100) begin        // Observe one full cycle (100 clock cycles)
      @(posedge clk);
      $display("Cycle %0t: Timer Value = %d, PWM Output = %b", $time, timer_value, pwm_out);
    end
    
    // Cycle 2: Duty cycle = 25%
    compare_value = 32'd25;   // Set duty cycle to 25%
    $display("Cycle 2: Period = %d, Duty Cycle = %d%%", load_value, (compare_value * 100) / load_value);
    
    repeat (100) begin        // Observe one full cycle (100 clock cycles)
      @(posedge clk);
      $display("Cycle %0t: Timer Value = %d, PWM Output = %b", $time, timer_value, pwm_out);
    end
    
    // Cycle 3: Duty cycle = 75%
    compare_value = 32'd75;   // Set duty cycle to 75%
    $display("Cycle 3: Period = %d, Duty Cycle = %d%%", load_value, (compare_value * 100) / load_value);
    
    repeat (100) begin        // Observe one full cycle (100 clock cycles)
      @(posedge clk);
      $display("Cycle %0t: Timer Value = %d, PWM Output = %b", $time, timer_value, pwm_out);
    end
    
    $stop;                  // End simulation
  end

endmodule


