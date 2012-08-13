-- eLua examples to use PWM peripheral and control LED intensity with PWM

local uartid, pwmid, tmrid, crtduty, incr, pwmclock, pwmfreq = 0, 0, 3, 10, 5, 25000000, 50000

-- PWM configuration
pwm.setclock( pwmid, pwmclock )
tmr.start( tmrid )
pwm.setup( pwmid, pwmfreq, crtduty )
pwm.start( pwmid )

term.clrscr()
print "Control LED with PWM (fade up/down)\n"
print "Press any key to exit.\n"

-- Routine to change PWM duty cicle up and down
while uart.getchar( uartid, 0 ) == "" do
  if crtduty == 95 or crtduty == 5 then
    incr = -incr
  end
  crtduty = crtduty + incr
  print(crtduty .. "pwm.\n")
  pwm.setup( pwmid, pwmfreq, crtduty )  
  tmr.delay( 0, 50000 )  
end

pwm.stop( pwmid )
