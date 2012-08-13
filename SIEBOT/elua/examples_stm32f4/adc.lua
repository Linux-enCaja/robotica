-- elua example to use ADC peripheral, acquire analogue reading and print it 
-- every time the sensed value changes

local uartid, adcchnl , timer, count, smooth, newval, oldval = 0, 1, 1, 128, 128, 0, 0

-- ADC peripheral configuration
adc.setblocking(adcchnl,1) 
adc.setsmoothing(adcchnl,smooth)
adc.setclock(adcchnl, 128 ,timer)
-- For sample as fast as possible 
--adc.setclock(adcchnl, 0)

term.clrscr()
print( "Hello from eLua on " .. pd.board() .. ".\n")
print "ADC One channel test :p \n"
print( "Maximum Value of " .. adc.maxval( adcchnl ) .. ".\n")
print "Enjoy eLua ! \n"
print "Press any key to end this demo.\n"

-- Routine to sample and print the samples information
while uart.getchar( uartid, 0 ) == "" do
  if adc.isdone(adcchnl) == 1 then adc.sample( adcchnl, count ) end 
  newval=adc.getsample(adcchnl)
  if newval ~= oldval then
    print(newval .. " ADC Reading.\n")
    oldval = newval
  end
end 
