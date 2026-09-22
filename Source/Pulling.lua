--import "main"
import "move_bobber"

applyAccel = false

currentCrankChange = 0
accelMoveValue = 10

local targetX = 0
local targetY = 0

local dirToPlayerY = 0
local dirToPlayerX = 0

function Pull(pullScalar)

    if isCast then
        print("PULL")

        local dx = bobber_x - player_x
        local dy = bobber_y - player_y

        local length = math.sqrt(dx * dx + dy * dy)

        if length > 0 then
            -- normalize to a unit vector
            dirToPlayerX = dx / length
            dirToPlayerY = dy / length

            -- Set the target position for the bobber towards the player this frame
            targetX = bobber_x + dirToPlayerX * pullScalar
            targetY = bobber_y + dirToPlayerY * pullScalar
        end

        -- MOVE BOBBER
        move_bobber(bobber_x, bobber_y, targetX, targetY, 30, 0, 0)
    end
end

pushX = 20
pushY = -10

function Push()
    
    if isCast then
        targetX = bobber_x + pushX
        targetY = bobber_y + pushY
    end

    -- MOVE BOBBER
    move_bobber(bobber_x, bobber_y, targetX, targetY, 30, 0, 0)
    
end
