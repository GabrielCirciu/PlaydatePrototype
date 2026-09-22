local gfx = playdate.graphics

function spawn_bubble(posX, posY)
    if not bubbleSprite then
        bubblePosition = {posX, posY}
        bubbleSprite = gfx.sprite.new()
        bubbleSprite:setImage(gfx.image.new("SystemAssets/bubble.png"))
        bubbleSprite:moveTo(posX, posY)
        bubbleSprite:setZIndex(101)
        bubbleSprite:add()
    end

    function bubbleSprite:update()
        self:moveBy(1 * player_skill, 0)
        bubblePosition[1] += 1 * player_skill
        if bubblePosition[1] > 400 then
            self:remove()
            bubbleSprite = nil
            bubblePosition = {0, 0}
        end
    end
end

function destroy_bubble()
    if bubbleSprite then
        bubbleSprite:remove()
        bubbleSprite = nil
        bubblePosition = {0, 0}
    elseif bossBubbleSprite then
        bossBubbleSprite:remove()
        bossBubbleSprite = nil
        bossBubblePosition = {0, 0}
    end
end

function spawn_boss_bubble(posX, posY)
    if not bossBubbleSprite then
        bossBubblePosition = {posX, posY}
        bossBubbleSprite = gfx.sprite.new()
        bossBubbleSprite:setImage(gfx.image.new("SystemAssets/boss_bubble.png"))
        bossBubbleSprite:moveTo(posX, posY)
        bossBubbleSprite:setZIndex(101)
        bossBubbleSprite:add()
    end

    function bossBubbleSprite:update()
        self:moveBy(0.2, 0)
        bossBubblePosition[1] += 0.2
        if bossBubblePosition[1] > 400 then
            self:remove()
            bossBubbleSprite = nil
            bossBubblePosition = {0, 0}
        end
    end
end