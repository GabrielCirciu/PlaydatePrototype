local gfx = playdate.graphics


function throw_line()
    local bobber = gfx.sprite.new()
    bobber_image = gfx.image.new("SystemAssets/bobber.png")
    local bobberW, bobberH = bobber_image:getSize()
    bobber:setImage(bobber_image)

    -- Change position of bobber x and y
    bobber_x = 20
    bobber_y = 20
    
    -- Draw line from player to bobber
    gfx.drawLine(player_x, player_y, bobber_x, bobber_y)

    -- Draw bobber sprite at bobber x and y
    bobber:moveTo(bobber_x, bobber_y)

    bobber:setZIndex(100)
    return bobber
end