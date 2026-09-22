import "CoreLibs/timer"
import "background"
import "fishing_throw"
import "bobber_control"
import "move_bobber"
import "PullPush"
import "spawn_bubble"
import "reel_fish"

local gfx = playdate.graphics

bobber_x = 0
bobber_y = 0
bobber_target_x = 0
bobber_target_y = 0
player_x = 200
player_y = 220

resetCastDistanceThreshold = 20

bobber = nil
bubbleSprite = nil
bubblePosition = {0, 0}

isCast = false
fishHooked = false
isMoving = false
justCastThisFrame = false

accelerometerMoveTheshold = 0.9
accelerometerYankScalar = 1.0
crankScalar = 0.05
throwDistance = 90

gfx.setColor(gfx.kColorBlack)

createBackgroundSprite()
playdate.startAccelerometer()

function playdate.update()
    gravityX, gravityY, gravityZ = playdate.readAccelerometer()
    playdate.timer.updateTimers()

    --[[
    if playdate.buttonJustPressed("A") and not isCast and not isMoving then
        isCast = true
        throw_line(math.random(100, 300), math.random(20, 220))
    end
    --]]

    -- Cast line while holding B
    if playdate.buttonIsPressed("B") and not isCast then
        if gravityY < -accelerometerMoveTheshold then
            -- Find target coordinates based on throw
            local targetX = player_x + (gravityX * throwDistance)
            local targetY = player_y + (gravityY * throwDistance)

            -- Limit to screen space
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
            
            print("THROW!")
            throw_line(targetX, targetY)
            justCastThisFrame = true
        end
    end

    -- Yank with accelerometer
    if isCast then
        if math.abs(gravityX) > accelerometerMoveTheshold or math.abs(gravityY) > accelerometerMoveTheshold then
            set_bobber_target(bobber_target_x + (gravityX * accelerometerYankScalar), bobber_target_y + (gravityY * accelerometerYankScalar))
        end
    end

    -- Reset bobber
    if playdate.buttonJustPressed("B") and isCast and not justCastThisFrame then
        set_bobber_target(player_x, player_y)
    end

    -- Retrieve/destroy bobber when it has returned back to the player
    if isCast and not justCastThisFrame and distanceToPlayer() < resetCastDistanceThreshold and targetDistanceToPlayer() < resetCastDistanceThreshold then
        destroy_bobber()
        isCast = false
        fishHooked = false
    end

    -- Continuously move bobber towards target
    if isCast and bobber then
        move_bobber()
    end

    justCastThisFrame = false

    -- Bubble spawner
    if bubbleSprite == nil and not fishHooked then
        spawn_bubble(0, math.random(20, 220))
    end

    -- Check if bubble overlaps with bobber
    if fishHooked == false then
        overlapping_fish_bobber_check()
    end

    -- Reeling minigame
    if fishHooked then
        reeling_minigame()
    end

    gfx.sprite.update()
    
    if isCast then
        gfx.drawLine(player_x, player_y, bobber_x, bobber_y)
    end

    --print(isCast)
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
        Push(change * crankScalar)
    end
end