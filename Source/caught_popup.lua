local gfx = playdate.graphics

local popupTime = 2000
local popupSpriteText = nil
local popupSpriteFrame = nil

function caughtPopup()
    fishCaught = false
    SoundManager:playSound(SoundManager.fishCaught)
    isAnimPlaying = true

    popupSpriteText = gfx.sprite.new()
    popupSpriteText:setImage(gfx.image.new("SystemAssets/caught_popup_text.png"))
    popupSpriteText:moveTo(200, 120)
    popupSpriteText:setZIndex(999)
    popupSpriteText:add()
    
    local textStartPoint = playdate.geometry.point.new(200, -100)
    local textEndPoint = playdate.geometry.point.new(200, 120)
    local textAnimator = gfx.animator.new(200, textStartPoint, textEndPoint, playdate.easingFunctions.outCubic)
    popupSpriteText:setAnimator(textAnimator)

   popupSpriteFrame = gfx.sprite.new()
   popupSpriteFrame:setImage(gfx.image.new("SystemAssets/caught_popup_frame.png"))
   popupSpriteFrame:setScale(0.7)
   popupSpriteFrame:moveTo(200, 120)
   popupSpriteFrame:setZIndex(999)
   popupSpriteFrame:add()

    playdate.timer.performAfterDelay(popupTime, function()
        popupSpriteText:remove()
        popupSpriteText = nil
        popupSpriteFrame:remove()
        popupSpriteFrame = nil
        isAnimPlaying = false
    end)
end