import "background"
import "fishing_throw"

local gfx = playdate.graphics

bobber_x = 0
bobber_y = 0
player_x = 100
player_y = 100

fishHooked = false

gfx.setColor(gfx.kColorBlack)

createBackgroundSprite()

function playdate.update()
    if playdate.buttonJustPressed("A") then
        throw_line()
    end

    gfx.sprite.update()

    playdate.drawFPS(0,0)
    gfx.drawText('bobber x: '..bobber_x, 0, 20)
    gfx.drawText('bobber y: '..bobber_y, 0, 40)
    gfx.drawText('player x: '..player_x, 0, 60)
    gfx.drawText('player y: '..player_y, 0, 80)
end

