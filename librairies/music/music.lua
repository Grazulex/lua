local music = {
    background = "music.mp3"

}

function music:PlayMusic()
    music = love.audio.newSource("audio/"..music.background.."", "stream")
    music:setLooping(true)
    music:play()
end

function music:PlaySound(file)
    sound = love.audio.newSource("audio/"..file, "static")
    sound:play()
    return sound
end


return music