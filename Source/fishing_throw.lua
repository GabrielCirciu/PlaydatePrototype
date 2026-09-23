import "move_bobber"
import "reel_fish"

local gfx = playdate.graphics

function throw_line(destX, destY)
    -- only create the bobber once
    -- this can allow us to destroy bobber and not have to worry
    if not bobber then
        -- initialize sprite
        bobber = gfx.sprite.new()
        local bobber_image = gfx.image.new("SystemAssets/bobber.png")
        bobber:setImage(bobber_image)
        bobber:setZIndex(101)
        bobber:add()
        SoundManager:playSound(SoundManager.throwLine)
        playdate.timer.performAfterDelay(200, function()
            SoundManager:playSound(SoundManager.bobberLand)
        end)
    end

    -- start bobber at player position and set destination target
    bobber_x = player_x
    bobber_y = player_y
    bobber:moveTo(bobber_x, bobber_y)
    set_bobber_target(destX, destY)
    isCast = true
    isMoving = true
end

function destroy_bobber()
    if bobber then
        bobber:remove()
        bobber = nil
    end
    reset_reeling()
    isMoving = false
end