import "CoreLibs/timer"
import "CoreLibs/sprites"

import "background"
import "fishing_throw"
import "bobber_control"
import "move_bobber"
import "PullPush"
import "spawn_bubble"
import "reel_fish"
import "intro"
import "sound_manager"
import "caught_popup"
import "win_screen"

local gfx = playdate.graphics

isIntro = true

bobber_x = 0
bobber_y = 0
bobber_target_x = 0
bobber_target_y = 0
player_x = 205
player_y = 195
player_skill = 1
spawnBossAtFishCount = 4

resetCastDistanceThreshold = 20

bobber = nil
bubbleSprite = nil
bubblePosition = {0, math.random(20, 160)}
bossBubbleSprite = nil
bossBubblePosition = {0, math.random(20, 160)}
bubbleTimer = nil

isCast = false
fishHooked = false
fishCaught = false
isMoving = false
justCastThisFrame = false
spawnBoss = false
stopSpawning = false
isWon = false
isAnimPlaying = false

accelerometerMoveTheshold = 0.9
accelerometerMoveThesholdHoriz = 0.9
accelerometerYankScalar = 10.0
crankScalar = 0.05
throwDistance = 90

gfx.setColor(gfx.kColorBlack)

local function createFishingLineSprite()
    local lineSprite = gfx.sprite.new()
    lineSprite:setBounds(0, 0, 400, 240)
    lineSprite:setZIndex(100) -- Below bobber (100) and bubbles (101) so it can be covered up

    function lineSprite:draw(x, y, width, height)
        if isCast then
            gfx.setColor(gfx.kColorBlack)
            gfx.drawLine(player_x, player_y, bobber_x, bobber_y)
        end
    end

    local wasCast = false
    function lineSprite:update()
        if isCast or wasCast then
            self:markDirty()
        end
        wasCast = isCast
    end

    lineSprite:setOpaque(false)
    lineSprite:add()
    return lineSprite
end

showIntroScreen()
createBackgroundSprite()
createShoreSprite()
createCharacterSprite()
fishingLineSprite = createFishingLineSprite()
playdate.startAccelerometer()
SoundManager:playBackgroundMusic()
spawn_bubble(0, math.random(20, 160))

function playdate.update()
    gravityX, gravityY, gravityZ = playdate.readAccelerometer()
    playdate.timer.updateTimers()
    gfx.sprite.update()

    if isIntro or isWon or isAnimPlaying then
        return
    end

    --[[
    if playdate.buttonJustPressed("A") and not isCast and not isMoving then
        isCast = true
        throw_line(math.random(100, 300), math.random(20, 220))
    end
    --]]

    -- Cast line while holding B
    if playdate.buttonIsPressed("B") and not isCast then
        if gravityY < -accelerometerMoveTheshold then
            -- Find target coordinates based on throw
            local targetX = player_x + (gravityX * throwDistance)
            local targetY = player_y + (gravityY * throwDistance)

            -- Limit to screen space
            if targetX >= 400 then
                targetX = 400
            elseif targetX < 0 then
                targetX = 0
            end        
            if targetY >= 240 then
                targetY = 240
            elseif targetY < 0 then
                targetY = 0
            end
            
            print("THROW!")
            throw_line(targetX, targetY)
            accelerometerMoveThesholdHoriz = 0.5
            justCastThisFrame = true
        end
    end

    -- Yank with accelerometer
    if isCast then
        if math.abs(gravityX) > accelerometerMoveThesholdHoriz then
            set_bobber_target(bobber_target_x + (gravityX * accelerometerYankScalar), bobber_target_y)
        end
        
        if math.abs(gravityY) > accelerometerMoveTheshold then
            set_bobber_target(bobber_target_x, bobber_target_y + (gravityY * accelerometerYankScalar))
        end
        -- Check for out of bounds
        if bobber_target_x < 0 then
            bobber_target_x = 0
        elseif bobber_target_x > 400 then
            bobber_target_x = 400
        end
        if bobber_target_y < 0 then
            bobber_target_y = 0
        elseif bobber_target_y > 200 then
            bobber_target_y = 200
        end
    end

    -- Reset bobber
    if playdate.buttonJustPressed("B") and isCast and not justCastThisFrame then
        set_bobber_target(player_x, player_y)
    end

    -- Retrieve/destroy bobber when it has returned back to the player
    if isCast and not justCastThisFrame and distanceToPlayer() < resetCastDistanceThreshold and targetDistanceToPlayer() < resetCastDistanceThreshold then
        destroy_bobber()
        isCast = false
        if fishHooked then
            fishHooked = false
            fishCaught = true
            player_skill += 1
            SoundManager:playSound(SoundManager.fishCaught)
            if spawnBoss then
                print("STOP SPAWNING!")
                stopSpawning = true
            end
        end
    end

    -- Continuously move bobber towards target
    if isCast and bobber then
        move_bobber()
    end

    justCastThisFrame = false

    if player_skill >= spawnBossAtFishCount then
        spawnBoss = true
    end

    -- Bubble spawner
    if bubbleSprite == nil and not fishHooked and not spawnBoss and not stopSpawning and bubbleTimer == nil then
        -- Wait 2 seconds before spawning bubble
        bubbleTimer = playdate.timer.new(2000, function()
            bubbleTimer = nil
            if not fishHooked and not spawnBoss and not stopSpawning then
                spawn_bubble(0, math.random(20, 160))
            end
        end)
    elseif bossBubbleSprite == nil and not fishHooked and spawnBoss and not stopSpawning and bubbleTimer == nil then
        -- Wait 2 seconds before spawning boss bubble
        bubbleTimer = playdate.timer.new(2000, function()
            bubbleTimer = nil
            if not fishHooked and spawnBoss and not stopSpawning then
                spawn_boss_bubble(0, 100)
            end
        end)
    end

    -- Check if bubble overlaps with bobber
    if fishHooked == false then
        overlapping_fish_bobber_check()
    end

    -- Reeling minigame
    if fishHooked and bobber ~= nil then
        reeling_minigame()
    end

    -- When fish is fully reeled in
    if fishCaught and not stopSpawning then
        caughtPopup()
    end

    -- Player won the game and reeled in boss fish
    if stopSpawning then
        winscreen()
    end

end

-- Use crank to reel in or give line to bobber
function playdate.cranked(change, acceleratedChange)

    -- If the line is not cast the player can't pull it
    if not isCast then
        return
    end

    if change < -1 then
        Pull(change * crankScalar)
    end

    if change > 1 then
        Push(change * crankScalar)
    end
end