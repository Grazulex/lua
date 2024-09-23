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

    wf = require 'librairies/windfield'
    world = wf.newWorld(0, 0, true)

    player.collider = world:newBSGRectangleCollider(player.x, player.y, player.tile.height/3, player.tile.width/3, 14)
    player.collider:setFixedRotation(true)

    camera = require 'librairies/hump/camera'
    cam = camera()

    sti = require 'librairies/sti'
    map = sti('data/map.lua')

    walls = {}
    if map.layers["Limit_chicken"] then
        for i, obj in pairs(map.layers["Limit_chicken"].objects) do
            --local wall = world:newRectangleCollider(obj.x, obj.y, obj.width, obj.height)
            --wall:setType('static')
            --table.insert(walls, wall)
        end
    end

    music:playMusic()
end

function love.update(dt)
    game:update(dt, map)
    world:update(dt)
    player.x = player.collider:getX()
    player.y = player.collider:getY()
    player:update(dt, cam)


end

function love.draw()
    cam:attach()
        map:drawLayer(map.layers["Water"])
        map:drawLayer(map.layers["Ground"])
        map:drawLayer(map.layers["Ground2"])
        map:drawLayer(map.layers["Bridge"])
        map:drawLayer(map.layers["Fence"])
        map:drawLayer(map.layers["Plante"])
        map:drawLayer(map.layers["Chicken_house"])
        game:draw()
        player:draw()
        --world:draw()
    cam:detach()
    love.graphics.print("Loading...", 100, 100)
end