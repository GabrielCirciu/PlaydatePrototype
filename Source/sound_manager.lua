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

local currentMusicPlayer = nil

function SoundManager:playSound(name)
	if self.sounds[name] then
		self.sounds[name]:play(1)
	end
end

function SoundManager:stopSound(name)
	if self.sounds[name] then
		self.sounds[name]:stop()
	end
end

function SoundManager:playMusic(path)
	if currentMusicPlayer ~= nil then
		currentMusicPlayer:stop()
	end
	currentMusicPlayer = snd.fileplayer.new(path)
	if currentMusicPlayer ~= nil then
		currentMusicPlayer:play(0) -- repeat forever
	end
end

function SoundManager:stopMusic()
	if currentMusicPlayer ~= nil then
		currentMusicPlayer:stop()
		currentMusicPlayer = nil
	end
end

function SoundManager:playBackgroundMusic()
	self:playMusic('sfx/music_idle')
end

function SoundManager:playMusicCatching()
	self:playMusic('sfx/music_catching')
end

function SoundManager:playMusicWin()
	self:playMusic('sfx/music_win')
end