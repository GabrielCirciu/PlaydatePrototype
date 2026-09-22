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
        local dx = bobber_target_x - player_x
        local dy = bobber_target_y - player_y

        local length = math.sqrt(dx * dx + dy * dy)

        if length > 0 then
            -- normalize to a unit vector
            dirToPlayerX = dx / length
            dirToPlayerY = dy / length

            -- Adjust target position towards player
            set_bobber_target(bobber_target_x + dirToPlayerX * pullScalar, bobber_target_y + dirToPlayerY * pullScalar)
        end

        -- If the bobber and target are close to the player, reset it
        if distanceToPlayer() < resetCastDistanceThreshold and targetDistanceToPlayer() < resetCastDistanceThreshold then
            print("Reset isCast")
            isCast = false
            if fishHooked then
                fishHooked = false
                fishCaught = true
                player_skill += 1
            end
            destroy_bobber()
        end
    end
end

pushX = 1.0
pushY = -1.0

function Push(pushScalar)
    if isCast then
        local scalar = pushScalar or 1.0
        set_bobber_target(bobber_target_x + (pushX * scalar), bobber_target_y + (pushY * scalar))
    end
end

function distanceToPlayer()
    distToPlayerX = bobber_x - player_x
    distToPlayerY = bobber_y - player_y

    return math.sqrt(distToPlayerX * distToPlayerX + distToPlayerY * distToPlayerY)
end

function targetDistanceToPlayer()
    local distTargetX = bobber_target_x - player_x
    local distTargetY = bobber_target_y - player_y

    return math.sqrt(distTargetX * distTargetX + distTargetY * distTargetY)
end