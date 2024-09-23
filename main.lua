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

    sti = require 'librairies/sti'
    camera = require 'librairies/hump/camera'
    cam = camera()
    map = sti('data/map.lua')


    music:playMusic()
end

function love.update(dt)
    game:update(dt)
    player:update(dt, cam)
end

function love.draw()
    cam:attach()
        map:drawLayer(map.layers["Water"])
        map:drawLayer(map.layers["Ground"])
        map:drawLayer(map.layers["Ground2"])
        map:drawLayer(map.layers["Bridge"])
        love.graphics.print("Loading...", 100, 100)
        game:draw()
        player:draw()
    cam:detach()
end