local gfx = playdate.graphics

local winSpriteText = nil
local winSpriteFish = nil

function winscreen()
    winSpriteText = gfx.sprite.new()
    winSpriteText:setImage(gfx.image.new("SystemAssets/win_popup_text.png"))
    winSpriteText:setZIndex(2000)
    winSpriteText:moveTo(200, 120)
    winSpriteText:add()   

    winSpriteFish = gfx.sprite.new()
    winSpriteFish:setImage(gfx.image.new("SystemAssets/win_popup_fish.png"))
    winSpriteFish:setZIndex(1999)
    winSpriteFish:moveTo(200, 120)
    winSpriteFish:add()   

    -- SoundManager:playSound(SoundManager.WIN)

    print("WIN!!!")
    isWon = true
end