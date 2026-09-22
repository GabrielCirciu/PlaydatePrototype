import "background"
import "fishing_throw"
import "bobber_control"
import "move_bobber"
import "PullPush"
import "spawn_bubble"

local gfx = playdate.graphics

bobber_x = 0
bobber_y = 0
player_x = 200
player_y = 220

resetCastDistanceThreshold = 10

bobber = nil

isCast = false
fishHooked = false
isMoving = false

accelerometerMoveTheshold = 0.9
accelerometerYankScalar = 5

crankScalar = 2
bubbleCount = 0
bubbleMax = 1
bubblePositions = {}
bubbleSprites = {}

gfx.setColor(gfx.kColorBlack)

createBackgroundSprite()
playdate.startAccelerometer()

function playdate.update()
    gravityX, gravityY, gravityZ = playdate.readAccelerometer()

    --[[
    if playdate.buttonJustPressed("A") and not isCast and not isMoving then
        isCast = true
        throw_line(math.random(100, 300), math.random(20, 220))
    end
    --]]

    -- Cast line
    if playdate.buttonIsPressed("B") and not isCast and not isMoving then
        if gravityY < -accelerometerMoveTheshold then
            local throwDistance = 150 -- tune this to taste — how far the line casts

            local targetX = player_x + (gravityX * throwDistance)
            local targetY = player_y + (gravityY * throwDistance)

            if targetX >= 400 then
                targetX = 400
            elseif targetX < 0 then
                targetX = 0
            end        

            if targetY >= 240 then
                targetY = 240
            elseif targetY < 0 then
                targetY = 0
            end
                

            throw_line(targetX, targetY)
            isCast = true
            print("THROW!")
        end
    end


    -- Yank with accelerometer
    if isCast and not isMoving then
        if math.abs(gravityX) > accelerometerMoveTheshold or math.abs(gravityY) > accelerometerMoveTheshold then
            move_bobber(bobber_x, bobber_y, bobber_x + (gravityX * accelerometerYankScalar), bobber_y + (gravityY * accelerometerYankScalar), 5, 0, 0)
        end    
    end

    -- Reset bobber
    if playdate.buttonJustPressed("B") and isCast and not isMoving then
        isCast = false
        move_bobber(bobber_x, bobber_y, player_x, player_y, 30, 0, 0)
    end

    -- Random chance of spawning bubble
    if math.random(1, 100) == 1 and bubbleCount < bubbleMax then
        spawn_bubble(50, math.random(20, 220))
    end

    gfx.sprite.update()
    if isCast then
        gfx.drawLine(player_x, player_y, bobber_x, bobber_y)
    end

    print(isCast)
    -- playdate.drawFPS(0,0)
    -- gfx.drawText('bobber x: '..bobber_x, 0, 20)
    -- gfx.drawText('bobber y: '..bobber_y, 0, 40)
    -- gfx.drawText('player x: '..player_x, 0, 60)
    -- gfx.drawText('player y: '..player_y, 0, 80)
end

-- Use crank to reel in or give line to bobber
function playdate.cranked(change, acceleratedChange)

    -- If the line is not cast the player can't pull it
    if not isCast then
        return
    end

    if change < -1 then
        Pull(change * crankScalar)
    end

    if change > 1 then
        Push()
    end

end