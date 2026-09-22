import "background"
import "fishing_throw"
import "bobber_control"
import "move_bobber"
import "Pulling"

local gfx = playdate.graphics

bobber_x = 0
bobber_y = 0
player_x = 200
player_y = 220

bobber = nil

isCast = false
fishHooked = false
isMoving = false

gfx.setColor(gfx.kColorBlack)

createBackgroundSprite()
playdate.startAccelerometer()

function playdate.update()
    gravityX, gravityY, gravityZ = playdate.readAccelerometer()

    -- Cast line
    if playdate.buttonJustPressed("A") and not isCast and not isMoving then
        isCast = true
        throw_line(math.random(100, 300), math.random(20, 220))
    elseif playdate.buttonJustPressed("B") and isCast and not isMoving then
        isCast = false
    end

    if playdate.buttonJustPressed(playdate.kButtonRight) then
        Pull()
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

