local gfx = playdate.graphics

function spawn_bubble(posX, posY)
    bubblePositions[bubbleCount] = {posX, posY}
    bubbleSprites[bubbleCount] = gfx.sprite.new()
    bubbleSprites[bubbleCount]:setImage(gfx.image.new("SystemAssets/bubble.png"))
    bubbleSprites[bubbleCount]:moveTo(posX, posY)
    bubbleSprites[bubbleCount]:setZIndex(200 + bubbleCount)
    bubbleSprites[bubbleCount]:add()
    bubbleCount = bubbleCount + 1
end

function move_bubbles()
    for i = 0, bubbleCount - 1 do
        bubblePositions[i][1] = bubblePositions[i][1] + 1
        bubbleSprites[i]:moveTo(bubblePositions[i][1], bubblePositions[i][2])
    end
end
