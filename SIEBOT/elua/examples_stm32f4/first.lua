-- elua example to configurate all stm32f4 Discovery Boards' 
-- LEDS to GPIO output pin and turn them ON
pio.pin.setdir(pio.OUTPUT,pio.PD_12)
pio.pin.sethigh(pio.PD_12)
pio.pin.setdir(pio.OUTPUT,pio.PD_13)
pio.pin.sethigh(pio.PD_13)
pio.pin.setdir(pio.OUTPUT,pio.PD_14)
pio.pin.sethigh(pio.PD_14)
pio.pin.setdir(pio.OUTPUT,pio.PD_15)
pio.pin.sethigh(pio.PD_15)
platform = pd.platform()

-- Routine to print a message in the console output
term.clrscr()
term.print("Hello from " .. platform .. "Platform :P")