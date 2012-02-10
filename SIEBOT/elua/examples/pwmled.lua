-- eLua examples
-- Control LED intensity with PWM
local pwmid, tmrid, ledpin

  pwmid, tmrid = 1, 1
  pwm.setclock( pwmid, 25000000 )

print "Control LED with PWM (fade up/down)"
print "Press any key to exit"

local crtduty, incr = 10, 5
tmr.start( tmrid )
pwm.setup( pwmid, 50000, crtduty )
pwm.start( pwmid )

while uart.getchar( 0, 0 ) == "" do
  if crtduty == 95 or crtduty == 5 then
    incr = -incr
  end
  crtduty = crtduty + incr
  pwm.setup( pwmid, 50000, crtduty )  
  tmr.delay( tmrid, 50000 )  
end

pwm.stop( pwmid )
