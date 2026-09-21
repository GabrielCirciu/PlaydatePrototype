import "main"

valToSubtractX = 0
valToSubtractY = 0

maxCrankChange = 50
crankChange = 0


function playdate.cranked(change, acceleratedChange)
    
    if change < -1 then
        
        crankChange = crankChange + math.abs(change)
        
        if crankChange > maxCrankChange then
            -- Apply change to bobber
        end
        
    end

end

playdate.startAccelerometer()

function readAccelerometerPull()
	pullX, pullY = playdate.readAccelerometer()
	
    -- if they use the accelerometer reset crankchange so they can use it again
    
    if pullY > 20 then
        crankChange = 0
    end
end
