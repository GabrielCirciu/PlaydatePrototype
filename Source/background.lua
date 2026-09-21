local gfx = playdate.graphics

local bgX = 0
local bgW = 0

function createBackgroundSprite()

	local bg = gfx.sprite.new()
	local bgImg = gfx.image.new('SystemAssets/background.png')
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