local gfx = playdate.graphics
local tutorialSprite = nil

function showTutorial()
    if tutorialSprite ~= nil then return end
    tutorialSprite = gfx.sprite.new()
    local tutorialImage = gfx.image.new("SystemAssets/tutorial_popup.png")
    
    tutorialSprite:setImage(tutorialImage)
    tutorialSprite:moveTo(200, 120)
    tutorialSprite:setZIndex(3000) -- On top of everything
    tutorialSprite:add()
end

function removeTutorial()
    if tutorialSprite ~= nil then
        tutorialSprite:remove()
        tutorialSprite = nil
    end
    isTutorial = false
end