import "sound_manager"

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
        SoundManager:playSound(SoundManager.fishHooked)
        SoundManager:playMusicCatching()
        destroy_bubble()
        isAnimPlaying = true

        local alertSpriteText = gfx.sprite.new()
        alertSpriteText:setImage(gfx.image.new("SystemAssets/hooked_popup_text.png"))
        alertSpriteText:moveTo(200, 120)
        alertSpriteText:setZIndex(999)
        alertSpriteText:add()

        local textStartPoint = playdate.geometry.point.new(200, -100)
        local textEndPoint = playdate.geometry.point.new(200, 120)
        local textAnimator = gfx.animator.new(200, textStartPoint, textEndPoint, playdate.easingFunctions.outCubic)
        alertSpriteText:setAnimator(textAnimator)
        
        local alertSpriteFish = gfx.sprite.new()
        alertSpriteFish:setImage(gfx.image.new("SystemAssets/hooked_popup_fish.png"))
        alertSpriteFish:moveTo(-100, 120)
        alertSpriteFish:setZIndex(999)
        alertSpriteFish:add()

        -- Move the fish sprite to the center of teh screen over 0.2 seconds
        local startPoint = playdate.geometry.point.new(200, 300)
        local endPoint = playdate.geometry.point.new(200, 120)
        local fishAnimator = gfx.animator.new(200, startPoint, endPoint, playdate.easingFunctions.outCubic)
        alertSpriteFish:setAnimator(fishAnimator)

        playdate.timer.performAfterDelay(1000, function()
            alertSpriteText:remove()
            alertSpriteText = nil
            alertSpriteFish:remove()
            alertSpriteFish = nil
            isAnimPlaying = false
        end)
    end
end

function reeling_minigame()
    if not isReeling then
        isReeling = true
        -- change bobber image to a hooked fish
        if not spawnBoss then
            bobber:setImage(gfx.image.new("SystemAssets/hooked_fish.png"))
        else
            bobber:setImage(gfx.image.new("SystemAssets/hooked_boss.png"))
        end
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
        if newBobberX >= 0 and newBobberX <= 400 and newBobberY >= 0 and newBobberY <= 200 then
            set_bobber_target(newBobberX, newBobberY)
        end
    end
end

function reset_reeling()
    isReeling = false
end