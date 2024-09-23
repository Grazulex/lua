local love = require("love")
Music = {
    background = "music.mp3"

}

function Music:playMusic()
    music = love.audio.newSource("audio/"..self.background.."", "stream")
    music:setLooping(true)
    music:play()
end

function Music:playSound(file)
    sound = love.audio.newSource("audio/"..file, "static")
    sound:play()
    return sound
end


return Music