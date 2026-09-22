import "background"
import "fishing_throw"

local gfx = playdate.graphics

bobber_x = 0
bobber_y = 0
player_x = 200
player_y = 220

isCast = false
fishHooked = false

gfx.setColor(gfx.kColorBlack)

createBackgroundSprite()
playdate.startAccelerometer()

function playdate.update()
    gravityX, gravityY, gravityZ = playdate.readAccelerometer()

    -- Cast line
    if playdate.buttonJustPressed("A") or gravityY > 0.9 and not isCast then
        isCast = true
        throw_line(math.random(100, 300), math.random(20, 220))
    -- Reel in line
    elseif playdate.buttonJustPressed("B") or gravityY < -0.9 and isCast then
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

