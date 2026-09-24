local gfx = playdate.graphics
introSprite = nil

function showIntroScreen()
    if introSprite ~= nil then return end
    introSprite = gfx.sprite.new()
    local introImage = gfx.image.new("SystemAssets/launchImage.png")
    
    introSprite:setImage(introImage)
    introSprite:moveTo(200, 120)
    introSprite:setZIndex(3000) -- On top of everything
    introSprite:add()
end

function removeIntroScreen()
    if introSprite ~= nil then
        introSprite:remove()
        introSprite = nil
    end
    isIntro = false
    print("Gameplay started!")
end