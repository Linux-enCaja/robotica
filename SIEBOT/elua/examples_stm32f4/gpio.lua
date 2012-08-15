-- eLua GPIO example, prints the logic level in the defined PIN

local uartid, oldval , newval = 0, 0, 0

-- Input pin configuration
pio.pin.setdir( pio.INPUT, pio.PB_0 )
newval = pio.pin.getval(pio.PB_0)
oldval = newval

term.clrscr()
print( "Hello from eLua on " .. pd.board() .. ".\n")
print "GPIO State Viewer :O \n"
print "Enjoy eLua ! \n"
print "Press any key to end this demo.\n"
print(newval .. " Logic Level.\n")

-- Routine to get and print the pins logic level
while uart.getchar( uartid, 0 ) == "" do
  newval = pio.pin.getval(pio.PB_0)
  if newval ~= oldval then
    print(newval .. " Logic Level.\n")
    oldval = newval
  end
end 
