local snd = playdate.sound

SoundManager = {}

SoundManager.throwLine = 'throw_line'
SoundManager.bobberLand = 'bobber_land'
SoundManager.fishHooked = 'fish_hooked'
SoundManager.fishPull = 'fish_pull'
SoundManager.fishCaught = 'fish_caught'
SoundManager.bossSpawn = 'boss_spawn'

local sounds = {}

for _, v in pairs(SoundManager) do
	sounds[v] = snd.sampleplayer.new('sfx/' .. v)
end

SoundManager.sounds = sounds

function SoundManager:playSound(name)
	self.sounds[name]:play(1)		
end


function SoundManager:stopSound(name)
	self.sounds[name]:stop()
end


function SoundManager:playBackgroundMusic()
	local filePlayer = snd.fileplayer.new('sfx/music')
	filePlayer:play(0) -- repeat forever
end