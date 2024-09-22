local Game = require "librairies.game.game"
local Music = require "librairies.music.music"
local Player = require "librairies.player.player"

local game= Game
local player = Player
local music = Music

function love.load()
    love.window.setMode(game.width, game.height)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle(game.title)

    music:PlayMusic()
end

function love.update(dt)
    player:Update(dt)
end

function love.draw()
    player:Draw()
end