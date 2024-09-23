local Music = require "librairies.music.music"

local music = Music
-- Meta class
local player = {
    x = 180,
    y = 380,
    speed = 3,
    zoom_x = 0.5,
    zomm_y = 0.5,
    tile = {
        width = 172,
        height = 124
    },
    mouvements = {
        down = {
            TotalFrames = 4,
            steps = {}
        },
        down_axe = {
            TotalFrames = 2,
            steps = {}
        },
        down_hoe = {
            TotalFrames = 2,
            steps = {}
        },
        down_idle = {
            TotalFrames = 2,
            steps = {}
        },
        down_water = {
            TotalFrames = 2,
            steps = {}
        },
        left = {
            TotalFrames = 4,
            steps = {}
        },
        left_axe = {
            TotalFrames = 2,
            steps = {}
        },
        left_hoe = {
            TotalFrames = 2,
            steps = {}
        },
        left_idle = {
            TotalFrames = 2,
            steps = {}
        },
        left_water = {
            TotalFrames = 2,
            steps = {}
        },
        right = {
            TotalFrames = 4,
            steps = {}
        },
        right_axe = {
            TotalFrames = 2,
            steps = {}
        },
        right_hoe = {
            TotalFrames = 2,
            steps = {}
        },
        right_idle = {
            TotalFrames = 2,
            steps = {}
        },
        right_water = {
            TotalFrames = 2,
            steps = {}
        },
        up = {
            TotalFrames = 4,
            steps = {}
        },
        up_axe = {
            TotalFrames = 2,
            steps = {}
        },
        up_hoe = {
            TotalFrames = 2,
            steps = {}
        },
        up_idle = {
            TotalFrames = 2,
            steps = {}
        },
        up_water = {
            TotalFrames = 2,
            steps = {}
        },
    },
    currentAnimation = "down_idle",
    currentFrame = 1,
    actions = {
        water = {
            sound = "water.mp3"
        },
        hoe = {
            sound = "hoe.wav"
        },
        axe = {
            sound = "axe.mp3"
        }
    }
}

-- Base class method new

local function init()

    for k, v in pairs(player.mouvements) do
        for i = 1, player.mouvements[k].TotalFrames do
            table.insert(player.mouvements[k].steps, love.graphics.newImage("graphics/character/"..k.."/" .. (i-1) .. ".png"))
        end      
    end
end


function player:Update(dt)
    local isMoving = false

    if love.keyboard.isDown("right") then
        player.x = player.x + player.speed
        player.currentAnimation = "right"
        isMoving = true
    elseif love.keyboard.isDown("left") then
        player.x = player.x - player.speed
        player.currentAnimation = "left"
        isMoving = true
    elseif love.keyboard.isDown("up") then
        player.y = player.y - player.speed
        player.currentAnimation = "up"
        isMoving = true
    elseif love.keyboard.isDown("down") then
        player.y = player.y + player.speed
        player.currentAnimation = "down"
        isMoving = true
    end

    if not isMoving then
        if player.currentAnimation == "right" then
            player.currentAnimation = "right_idle"
        elseif player.currentAnimation == "left" then
            player.currentAnimation = "left_idle"
        elseif player.currentAnimation == "up" then
            player.currentAnimation = "up_idle"
        elseif player.currentAnimation == "down" then
            player.currentAnimation = "down_idle"
        end
    end

    if love.keyboard.isDown("a") and not player.actionPressed then
        player.actionPressed = true
        local currentAction = player.currentAnimation:match("_(%a+)$")
        local currentDirection = player.currentAnimation:match("^(%a+)_")
        local nextAction = nil

        if currentAction then
            local foundCurrent = false
            for actionName, _ in pairs(player.actions) do
                if foundCurrent then
                    nextAction = actionName
                    break
                end
                if actionName == currentAction then
                    foundCurrent = true
                end
            end
            if not nextAction then
                nextAction = next(player.actions)
            end
        else
            nextAction = next(player.actions)
        end

        player.currentAnimation = currentDirection .. "_" .. nextAction
        music:PlaySound(player.actions[nextAction].sound)
    end

    if not love.keyboard.isDown("a") then
        player.actionPressed = false
    end

    player.currentFrame = player.currentFrame + player.speed * dt
    if player.currentFrame >= (player.mouvements[player.currentAnimation].TotalFrames+1) then
        player.currentFrame = 1
    end
end

function player:Draw()
    love.graphics.draw(player.mouvements[player.currentAnimation].steps[math.floor(player.currentFrame)], player.x, player.y, nil, player.zoom_x, player.zoom_y)
end

init()

return player