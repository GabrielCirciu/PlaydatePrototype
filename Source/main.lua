import "background"

local gfx = playdate.graphics

bobber_x = 0
bobber_y = 0

gfx.setColor(gfx.kColorBlack)

createBackgroundSprite()

function playdate.update()
    -- gfx.fillRect(0, 0, 400, 240)
    gfx.sprite.update()
    playdate.drawFPS(0,0)
end

