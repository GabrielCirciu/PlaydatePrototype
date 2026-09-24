local gfx = playdate.graphics

local popupTime = 2000
local popupSpriteText = nil
local popupSpriteFrame = nil
local popupSpriteFishes = nil

function caughtPopup()
    fishCaught = false
    SoundManager:playSound(SoundManager.fishCaught)
    isAnimPlaying = true

    popupSpriteText = gfx.sprite.new()
    popupSpriteText:setImage(gfx.image.new("SystemAssets/caught_popup_text.png"))
    popupSpriteText:moveTo(200, 120)
    popupSpriteText:setZIndex(900)
    popupSpriteText:add()
    
    local textStartPoint = playdate.geometry.point.new(200, -100)
    local textEndPoint = playdate.geometry.point.new(200, 120)
    local textAnimator = gfx.animator.new(200, textStartPoint, textEndPoint, playdate.easingFunctions.outCubic)
    popupSpriteText:setAnimator(textAnimator)

    popupSpriteFrame = gfx.sprite.new()
    popupSpriteFrame:setImage(gfx.image.new("SystemAssets/caught_popup_frame.png"))
    popupSpriteFrame:setScale(0.5)
    popupSpriteFrame:moveTo(200, 120)
    popupSpriteFrame:setZIndex(901)
    popupSpriteFrame:add()

    local fishesImage = gfx.image.new("SystemAssets/caught_popup_fishes.png")

    popupSpriteFishes = gfx.sprite.new()
    popupSpriteFishes:setImage(fishesImage)
    popupSpriteFishes:moveTo(200, 130)
    popupSpriteFishes:setZIndex(902)
    popupSpriteFishes:add()

    popupSpriteFishesLoop = gfx.sprite.new()
    popupSpriteFishesLoop:setImage(fishesImage)
    popupSpriteFishesLoop:moveTo(-200, 130)
    popupSpriteFishesLoop:setZIndex(902)
    popupSpriteFishesLoop:add()

    local scrollDuration = 800
    local fishAnim1 = gfx.animator.new(
        scrollDuration,
        playdate.geometry.point.new(200, 130),
        playdate.geometry.point.new(600, 130),
        playdate.easingFunctions.outCubic
    )
    local fishAnim2 = gfx.animator.new(
        scrollDuration,
        playdate.geometry.point.new(-200, 130),
        playdate.geometry.point.new(200, 130),
        playdate.easingFunctions.outCubic
    )

    popupSpriteFishes:setAnimator(fishAnim1)
    popupSpriteFishesLoop:setAnimator(fishAnim2)

    playdate.timer.performAfterDelay(popupTime, function()
        popupSpriteText:remove()
        popupSpriteText = nil
        popupSpriteFrame:remove()
        popupSpriteFrame = nil
        popupSpriteFishes:remove()
        popupSpriteFishes = nil
        popupSpriteFishesLoop:remove()
        popupSpriteFishesLoop = nil
        isAnimPlaying = false
    end)
end