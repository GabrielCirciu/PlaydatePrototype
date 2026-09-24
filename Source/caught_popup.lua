local gfx = playdate.graphics

local popupTime = 2000
local popupSpriteText = nil
local popupSpriteFrame = nil
local popupSpriteFishes = nil

local fish1 = gfx.image.new("SystemAssets/caught_popup_fish_1.png")
local fish2 = gfx.image.new("SystemAssets/caught_popup_fish_2.png")
local fish3 = gfx.image.new("SystemAssets/caught_popup_fish_3.png")
local fishOrder1 = {fish1, fish2, fish3}
local fishOrder2 = {fish2, fish3, fish1}
local fishOrder3 = {fish3, fish1, fish2}
local fishOrders = {fishOrder1, fishOrder2, fishOrder3}
local orderCount = 1

function caughtPopup()
    if stopSpawning then
        return
    end

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
    popupSpriteFrame:moveTo(200, 100)
    popupSpriteFrame:setZIndex(901)
    popupSpriteFrame:add()

    popupSpriteFish1 = gfx.sprite.new()
    popupSpriteFish1:setImage(fishOrders[orderCount][1])
    popupSpriteFish1:moveTo(200, 110)
    popupSpriteFish1:setZIndex(902)
    popupSpriteFish1:add()

    popupSpriteFish2 = gfx.sprite.new()
    popupSpriteFish2:setImage(fishOrders[orderCount][2])
    popupSpriteFish2:moveTo(-200, 110)
    popupSpriteFish2:setZIndex(903)
    popupSpriteFish2:add()

    popupSpriteFish3 = gfx.sprite.new()
    popupSpriteFish3:setImage(fishOrders[orderCount][3])
    popupSpriteFish3:moveTo(-600, 110)
    popupSpriteFish3:setZIndex(904)
    popupSpriteFish3:add()

    local scrollDuration = 1500
    local fish1Anim = gfx.animator.new(
        scrollDuration,
        playdate.geometry.point.new(200, 110),
        playdate.geometry.point.new(700, 110),
        playdate.easingFunctions.outCubic
    )
    local fish2Anim = gfx.animator.new(
        scrollDuration,
        playdate.geometry.point.new(-200, 110),
        playdate.geometry.point.new(500, 110),
        playdate.easingFunctions.outCubic
    )
    local fish3Anim = gfx.animator.new(
        scrollDuration,
        playdate.geometry.point.new(-600, 110),
        playdate.geometry.point.new(200, 110),
        playdate.easingFunctions.outCubic
    )

    popupSpriteFish1:setAnimator(fish1Anim)
    popupSpriteFish2:setAnimator(fish2Anim)
    popupSpriteFish3:setAnimator(fish3Anim)

    playdate.timer.performAfterDelay(popupTime, function()
        popupSpriteText:remove()
        popupSpriteText = nil
        popupSpriteFrame:remove()
        popupSpriteFrame = nil
        popupSpriteFish1:remove()
        popupSpriteFish1 = nil
        popupSpriteFish2:remove()
        popupSpriteFish2 = nil
        popupSpriteFish3:remove()
        popupSpriteFish3 = nil
        isAnimPlaying = false
    end)

    orderCount += 1
    
end