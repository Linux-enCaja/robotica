-- eLua blinking led example, the Hello World of embedded :)

local uartid, invert, ledpin1, ledpin2 ,ledpin3 ,ledpin4 = 0, true, pio.PD_12, pio.PD_13, pio.PD_14, pio.PD_15

-- Function to change value of defined pin
function cycle( outpin )
  if not invert then
    pio.pin.sethigh( outpin )
  else
    pio.pin.setlow( outpin )
  end
  tmr.delay( 0, 500000 )
  if not invert then
    pio.pin.setlow( outpin )
  else
    pio.pin.sethigh( outpin )
  end
  tmr.delay( 0, 500000 )
end

-- Pin output configuration
pio.pin.setdir( pio.OUTPUT, ledpin1 )
pio.pin.setdir( pio.OUTPUT, ledpin2 )
pio.pin.setdir( pio.OUTPUT, ledpin3 )
pio.pin.setdir( pio.OUTPUT, ledpin4 )

term.clrscr()
print( "Hello from eLua on " .. pd.board() .. ".\n" )
print "Watch your LED blinking :) \n"
print "Enjoy eLua ! \n"
print "Press any key to end this demo.\n"

-- Section to call cycle function and blink the leds
while uart.getchar( uartid, 0 ) == "" do
  cycle(ledpin1)
  cycle(ledpin2)
  cycle(ledpin3)
  cycle(ledpin4)
end 
