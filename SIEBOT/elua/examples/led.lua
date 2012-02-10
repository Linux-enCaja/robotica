ledpin = pio.PD_2
function cycle()
  pio.pin.sethigh( ledpin ) 
  tmr.delay( 0, 100000 )
  pio.pin.setlow( ledpin ) 
  tmr.delay( 0, 100000 )
end

pio.pin.setdir( pio.OUTPUT, ledpin )
print( "Hello from eLua on " .. pd.board() )
print "Watch your LED blinking :)"
print "Enjoy eLua !"
print "Press any key to end this demo.\n"

while uart.getchar( 0, 0 ) == "" do
  cycle()
end

