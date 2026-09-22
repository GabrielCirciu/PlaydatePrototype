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
        self:moveBy(1, 0)
        bubblePosition[1] += 1
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
    end
end