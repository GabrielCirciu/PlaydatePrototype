local gfx = playdate.graphics

local winSprite = nil

function winscreen()
    if winSprite == nil then
        winSprite = gfx.sprite.new()
        
        winSprite:setImage(gfx.image.new("SystemAssets/launchImage.png"))
        
        winSprite:setZIndex(999)
    end

    winSprite:moveTo(200, 120)
    winSprite:add()

    -- SoundManager:playSound(SoundManager.WIN)

    print("WIN!!!")
end