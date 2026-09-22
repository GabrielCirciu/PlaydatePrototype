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
        -- Apply crank to pullScalar



        -- Apply accelerometer to pullScalar

        local dx = player_x - bobber_x
        local dy = player_y - bobber_y

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

-- Only if a fish is caught should the crank value be restricted
function playdate.cranked(change, acceleratedChange)

    if change < -1 then
        currentCrankChange = math.abs(change)
    end

end

playdate.startAccelerometer()

function readAccelerometerPull()
	local gravityX, gravityY, gravityZ = playdate.readAccelerometer()

    if gravityY > 0.9 then
        applyAccel = true
    else
        applyAccel = false
    end

end
