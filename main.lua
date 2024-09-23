local love = require("love")
local Game = require "librairies.game.game"
local Music = require "librairies.music.music"
local Player = require "librairies.player.player"

local game= Game
local player = Player
local music = Music

mainFont = love.graphics.newFont("font/LycheeSoda.ttf", 18)

function love.load()
    love.graphics.setFont(mainFont)
    love.window.setMode(game.width, game.height)
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle(game.title)

    music:playMusic()
end

function love.update(dt)
    game:update(dt)
    player:update(dt)
end

function love.draw()
    love.graphics.print("Loading...", 100, 100)
    game:draw()
    player:draw()
end