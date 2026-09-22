import "background"
import "fishing_throw"
import "bobber_control"
import "move_bobber"
import "PullPush"

local gfx = playdate.graphics

bobber_x = 0
bobber_y = 0
player_x = 200
player_y = 220

bobber = nil

isCast = false
fishHooked = false
isMoving = false

crankScalar = 2

gfx.setColor(gfx.kColorBlack)

createBackgroundSprite()
playdate.startAccelerometer()

function playdate.update()
    gravityX, gravityY, gravityZ = playdate.readAccelerometer()

    -- Cast line
    if playdate.buttonJustPressed("A") and not isCast and not isMoving then
        isCast = true
        throw_line(math.random(100, 300), math.random(20, 220))
    elseif playdate.buttonJustPressed("Left") and isCast and not isMoving then
        move_bobber(bobber_x, bobber_y, bobber_x - 10, bobber_y, 5, 0, 0)
    elseif playdate.buttonJustPressed("Right") and isCast and not isMoving then
        move_bobber(bobber_x, bobber_y, bobber_x + 10, bobber_y, 5, 0, 0)
    elseif playdate.buttonJustPressed("Up") and isCast and not isMoving then
        move_bobber(bobber_x, bobber_y, bobber_x, bobber_y - 10, 5, 0, 0)
    elseif playdate.buttonJustPressed("Down") and isCast and not isMoving then
        move_bobber(bobber_x, bobber_y, bobber_x, bobber_y + 10, 5, 0, 0)
    elseif playdate.buttonJustPressed("B") and isCast and not isMoving then
        isCast = false
        move_bobber(bobber_x, bobber_y, player_x, player_y, 30, 0, 0)
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

function playdate.cranked(change, acceleratedChange)

    if(isCast) then
        if change < -1 then
          Pull(change * crankScalar)
        end

        if change > 1 then
            Push()
        end
    end
end