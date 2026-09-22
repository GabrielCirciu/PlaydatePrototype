local gfx = playdate.graphics

function showIntroScreen()
    local introSprite = gfx.sprite.new()
    local introImage = gfx.image.new("SystemAssets/launchImage.png")
    
    introSprite:setImage(introImage)
    introSprite:moveTo(200, 120)
    introSprite:setZIndex(1000) -- On top of everything
    introSprite:add()

    playdate.timer.performAfterDelay(1000, function()
        introSprite:remove()
        introSprite = nil
        isIntro = false
        print("Gameplay started!")
    end)
end