local gfx = playdate.graphics

function lerp(a, b, t)
    return a + (b - a) * t
end

function move_bobber(startX, startY, destX, destY, duration, arcW, arcH, onComplete)
    local moveProgress = 0.0
    local startX, startY = startX, startY
    local endX, endY = destX, destY
    isMoving = true

    function bobber:update()
        if isMoving then
            moveProgress = moveProgress + (1.0 / duration)
            if moveProgress >= 1.0 then
                moveProgress = 1.0
                isMoving = false
                if onComplete then
                    onComplete()
                end
            end

            -- lerping animation
            local t = moveProgress
            local arc_x = 4 * arcW * t * (1.0 - t)
            bobber_x = lerp(startX, endX, t) + arc_x
            local arc_y = 4 * arcH * t * (1.0 - t)
            bobber_y = lerp(startY, endY, t) - arc_y
            self:moveTo(bobber_x, bobber_y)
        end
    end
end
    
    