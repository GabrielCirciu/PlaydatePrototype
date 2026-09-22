local gfx = playdate.graphics

function overlapping_fish_bobber_check()
    -- Check distance between the bobber and the bubble
    local distance = math.sqrt((bubblePosition[1] - bobber_x)^2 + (bubblePosition[2] - bobber_y)^2)
    if distance < 20 and not fishHooked then
        fishHooked = true
        -- Show background.png for 1 seconds in the middle of the screen
        local alertSprite = gfx.sprite.new()
        alertSprite:setImage(gfx.image.new("SystemAssets/background.png"))
        alertSprite:moveTo(200, 120)
        alertSprite:setZIndex(999)
        alertSprite:add()
        destroy_bubble()
        playdate.timer.performAfterDelay(1000, function()
            alertSprite:remove()
            alertSprite = nil
        end)
    end
end

function reeling_minigame()

end