local gfx = playdate.graphics

local moveProgress = 0.0
local moveDuration = 30

local function lerp(a, b, t)
    return a + (b - a) * t
end

-- Move bobber position either left or right based on accelerometer X value
function moveHorizontal(destX)
    
    function bobber:update()
    end

    local startX = bobber_x
    local endX = startX + destX
    local t = 0.1

    bobber_x = lerp(startX, endX, t)
end

-- Move bobber position either up or down based on crank rotation
function moveVertical(destY)

end