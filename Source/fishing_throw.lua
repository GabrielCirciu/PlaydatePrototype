import "move_bobber"

local gfx = playdate.graphics

function throw_line(destX, destY)
    -- only create the bobber once
    -- this can allow us to destroy bobber and not have to worry
    if not bobber then
        -- initialize sprite
        bobber = gfx.sprite.new()
        local bobber_image = gfx.image.new("SystemAssets/bobber.png")
        bobber:setImage(bobber_image)
        bobber:setZIndex(100)
        bobber:add()
    end

    -- start moving bobber from player position to destination
    move_bobber(player_x, player_y, destX, destY, 30, 40, 40)
end