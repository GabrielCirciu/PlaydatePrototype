local gfx = playdate.graphics

local fishDirection = 0
local fishMoveTimer = 0

function overlapping_fish_bobber_check()
    -- Check distance between the bobber and the bubble
    local distance = math.sqrt((bubblePosition[1] - bobber_x)^2 + (bubblePosition[2] - bobber_y)^2)
    if distance < 20 and not fishHooked then
        fishHooked = true
        -- Show background.png for 1 seconds in the middle of the screen
        local alertSprite = gfx.sprite.new()
        alertSprite:setImage(gfx.image.new("SystemAssets/reeled_popup.png"))
        alertSprite:moveTo(200, 120)
        alertSprite:setZIndex(999)
        alertSprite:add()
        destroy_bubble()
        playdate.timer.performAfterDelay(1000, function()
            alertSprite:remove()
            alertSprite = nil
        end)
    end
end

function reeling_minigame()
    -- Every second the fish decides on a direction to swim
    fishMoveTimer = fishMoveTimer + 1
    if fishMoveTimer == 60 then
        fishMoveTimer = 0
        fishDirection = math.random(0, 360)
        local newBobberX = bobber_x + math.cos(fishDirection) * 10
        local newBobberY = bobber_y + math.sin(fishDirection) * 10

        -- Check if new position is within screen bounds
        if newBobberX >= 0 and newBobberX <= 400 and newBobberY >= 0 and newBobberY <= 240 then
            move_bobber(bobber_x, bobber_y, newBobberX, newBobberY, 10, 0, 0)
        end
    end
end