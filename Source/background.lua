local gfx = playdate.graphics

local bgX = 0
local bgW = 0

function createBackgroundSprite()

	local bg = gfx.sprite.new()
	local bgImg = gfx.image.new('SystemAssets/Background_Simple.png')
	--local bgImg = gfx.image.new('SystemAssets/background_old.png')
	local w, h = bgImg:getSize()
	bgW = w
	bg:setBounds(0, 0, 400, 240)

	function bg:draw(x, y, width, height)
		bgImg:draw(bgX, 0)
		bgImg:draw(bgX-bgW, 0)

	end

	function bg:update()
		bgX += 1
		if bgX > bgW then
			bgX = 0
		end
		self:markDirty()
	end

	bg:setZIndex(0)
	bg:add()
end

function createShoreSprite()
    local shore = gfx.sprite.new()
    local shoreImg = gfx.image.new('SystemAssets/shore.png')
    shore:setImage(shoreImg)
    shore:moveTo(200, 140)
    shore:setZIndex(200)
    shore:add()
end

function createCharacterSprite()
    local char = gfx.sprite.new()
    local charImg = gfx.image.new('SystemAssets/character.png')
    char:setImage(charImg)
    char:moveTo(200, 195)
    char:setZIndex(201)
    char:add()
end