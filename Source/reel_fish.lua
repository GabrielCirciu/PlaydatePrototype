local gfx = playdate.graphics

local fishDirection = 0
local fishMoveTimer = 0
local isReeling = false
local distance = 10000

function overlapping_fish_bobber_check()
    -- Check distance between the bobber and the bubble
    if not spawnBoss then
        distance = math.sqrt((bubblePosition[1] - bobber_x)^2 + (bubblePosition[2] - bobber_y)^2)
    else
        distance = math.sqrt((bossBubblePosition[1] - bobber_x)^2 + (bossBubblePosition[2] - bobber_y)^2)
    end
    
    if distance < 20 and not fishHooked then
        fishHooked = true
        -- Show background.png for 1 seconds in the middle of the screen
        local alertSprite = gfx.sprite.new()
        alertSprite:setImage(gfx.image.new("SystemAssets/reeled_popup.png"))
        alertSprite:moveTo(200, 120)
        alertSprite:setZIndex(999)
        alertSprite:add()
        destroy_bubble()
        SoundManager:playSound(SoundManager.fishHooked)
        playdate.timer.performAfterDelay(1000, function()
            alertSprite:remove()
            alertSprite = nil
        end)
    end
end

function reeling_minigame()
    if not isReeling then
        isReeling = true
        -- change bobber image to a hooked fish
        bobber:setImage(gfx.image.new("SystemAssets/hooked_fish.png"))
    end

    -- Every second the fish decides on a direction to swim
    fishMoveTimer = fishMoveTimer + 1
    if fishMoveTimer >= 60 - player_skill * 10 then
        fishMoveTimer = 0
        fishDirection = math.random(-45, 45)
        local rad = math.rad(fishDirection)
        local newBobberX = bobber_x + math.sin(rad) * 100
        local newBobberY = bobber_y - math.cos(rad) * 50

        SoundManager:playSound(SoundManager.fishPull)

        -- Check if new position is within screen bounds
        if newBobberX >= 0 and newBobberX <= 400 and newBobberY >= 0 and newBobberY <= 240 then
            set_bobber_target(newBobberX, newBobberY)
        end
    end
end

function reset_reeling()
    isReeling = false
end