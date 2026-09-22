local gfx = playdate.graphics

bobber_target_x = 0
bobber_target_y = 0

-- Movement configuration
-- With MOVE_FACTOR = 0.35, ~98.7% of the distance is covered in 10 frames (1 - 0.35)^10 ≈ 0.013
-- and it snaps cleanly into place when distance < 1.0 pixel.
local MOVE_FACTOR = 0.35

function lerp(a, b, t)
    return a + (b - a) * t
end

function set_bobber_target(x, y)
    -- Clamp target position within screen space
    bobber_target_x = math.max(0, math.min(400, x))
    bobber_target_y = math.max(0, math.min(240, y))
end

function move_bobber(arg1, arg2, arg3, arg4)
    -- Support setting target if coordinates are passed:
    -- move_bobber(targetX, targetY) or legacy move_bobber(startX, startY, destX, destY, ...)
    if arg3 and arg4 then
        set_bobber_target(arg3, arg4)
    elseif arg1 and arg2 then
        set_bobber_target(arg1, arg2)
    end

    if not isCast or not bobber then
        return
    end

    local dx = bobber_target_x - bobber_x
    local dy = bobber_target_y - bobber_y
    local distance = math.sqrt(dx * dx + dy * dy)

    if distance < 1.0 then
        bobber_x = bobber_target_x
        bobber_y = bobber_target_y
        isMoving = false
    else
        isMoving = true
        -- Speed is proportional to remaining distance so it arrives in ~10 frames
        local speed = distance * MOVE_FACTOR
        if speed < 1.0 then
            speed = 1.0
        end

        local stepX = (dx / distance) * speed
        local stepY = (dy / distance) * speed

        -- Prevent overshooting
        if math.abs(stepX) >= math.abs(dx) then
            bobber_x = bobber_target_x
        else
            bobber_x = bobber_x + stepX
        end

        if math.abs(stepY) >= math.abs(dy) then
            bobber_y = bobber_target_y
        else
            bobber_y = bobber_y + stepY
        end
    end

    bobber:moveTo(bobber_x, bobber_y)
end

    
    