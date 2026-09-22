local gfx = playdate.graphics

local bobber = nil
local isCasting = false
local startX, startY = 0, 0
local targetX, targetY = 0, 0
local castProgress = 0.0
local castDuration = 30             -- duration in frames
local arcWidth, arcHeight = 40, 40  -- throw arc (set to 0 for straight line)

-- lerp calculation over time T from position A to B
local function lerp(a, b, t)
    return a + (b - a) * t
end

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

        -- override into global update, kindof?
        function bobber:update()
            if isCasting then
                castProgress = castProgress + (1.0 / castDuration)
                if castProgress >= 1.0 then
                    castProgress = 1.0
                    isCasting = false
                end

                -- lerping animation
                local t = castProgress
                local arc_x = 4 * arcWidth * t * (1.0 - t)
                bobber_x = lerp(startX, endX, t) + arc_x
                local arc_y = 4 * arcHeight * t * (1.0 - t)
                bobber_y = lerp(startY, endY, t) - arc_y
                self:moveTo(bobber_x, bobber_y)
            end
        end
    end

    -- set initial values to be overridden in the first update
    startX, startY = player_x, player_y
    endX, endY = destX, destY
    castProgress = 0.0
    isCasting = true
    bobber_x, bobber_y = startX, startY
    bobber:moveTo(bobber_x, bobber_y)
end