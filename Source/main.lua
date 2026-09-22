import "background"
import "fishing_throw"

local gfx = playdate.graphics

bobber_x = 0
bobber_y = 0
player_x = 220
player_y = 220

isCast = false
fishHooked = false

gfx.setColor(gfx.kColorBlack)

createBackgroundSprite()

function playdate.update()
    -- Will be replaced with accelerometer in the future
    if playdate.buttonJustPressed("A") and not isCast then
        isCast = true
        throw_line(math.random(100, 300), math.random(20, 220))
    -- Will be repleaced with interaction to pull back line in the future
    elseif playdate.buttonJustPressed("B") and isCast then
        isCast = false
    end

    gfx.sprite.update()

    if isCast then
        gfx.drawLine(player_x, player_y, bobber_x, bobber_y)
    end

    playdate.drawFPS(0,0)
    gfx.drawText('bobber x: '..bobber_x, 0, 20)
    gfx.drawText('bobber y: '..bobber_y, 0, 40)
    gfx.drawText('player x: '..player_x, 0, 60)
    gfx.drawText('player y: '..player_y, 0, 80)
end

