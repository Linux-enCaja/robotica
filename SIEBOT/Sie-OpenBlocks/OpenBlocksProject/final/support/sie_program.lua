function forever()
sie_Llib.move(1,255)
sie_Llib.delayMs(2000,1)
sie_Llib.restart_enc()
sie_Llib.move(3,math.floor((100*1.27)+128))
sie_Llib.delayMs(math.floor(90/100*3600/0.9))
sie_Llib.move(0,0)
end

repeat
forever()
until false
