import "background"
import "fishing_throw"
import "bobber_control"
import "move_bobber"
import "PullPush"
import "spawn_bubble"

local gfx = playdate.graphics

bobber_x = 0
bobber_y = 0
player_x = 200
player_y = 220

resetCastDistanceThreshold = 10

bobber = nil

isCast = false
fishHooked = false
isMoving = false

crankScalar = 2
bubbleCount = 0
bubbleMax = 1
bubblePositions = {}
bubbleSprites = {}

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

    -- Random chance of spawning bubble
    if math.random(1, 100) == 1 and bubbleCount < bubbleMax then
        spawn_bubble(50, math.random(20, 220))
    end

    gfx.sprite.update()
    if isCast then
        gfx.drawLine(player_x, player_y, bobber_x, bobber_y)
    end

    -- playdate.drawFPS(0,0)
    -- gfx.drawText('bobber x: '..bobber_x, 0, 20)
    -- gfx.drawText('bobber y: '..bobber_y, 0, 40)
    -- gfx.drawText('player x: '..player_x, 0, 60)
    -- gfx.drawText('player y: '..player_y, 0, 80)
end

function playdate.cranked(change, acceleratedChange)

    -- If the line is not cast the player can't pull it
    if not isCast then
        return
    end

    if change < -1 then
        Pull(change * crankScalar)
    end

    if change > 1 then
        Push()
    end

end