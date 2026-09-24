local gfx = playdate.graphics

local popupTime = 2000
local popupSprite = nil

function caughtPopup()
    if popupSprite == nil then
        popupSprite = gfx.sprite.new()

        print(player_skill, " Player skill")

        if player_skill <= spawnBossAtFishCount then
            popupSprite:setImage(gfx.image.new("SystemAssets/caught_popup.png"))
            popupSprite:setZIndex(999)
        end
        
    end

    popupSprite:moveTo(200, 120)
    popupSprite:add()

    SoundManager:playSound(SoundManager.fishCaught)

    print("CAUGHT! - Resetting")
    fishCaught = false

    playdate.timer.performAfterDelay(popupTime, function()
        popupSprite:remove()
        popupSprite = nil
    end)
end