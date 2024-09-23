local love = require("love")
local Music = require "librairies.music.music"

local sound = Music

Player = {
    x = 2770, --2770
    y = 2000, --2000
    speed_frame = 4,
    speed_move = 120,
    zoom_x = 0.8,
    zoom_y = 0.8,
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

function Player:init()

    for k, v in pairs(self.mouvements) do
        for i = 1, self.mouvements[k].TotalFrames do
            table.insert(self.mouvements[k].steps, love.graphics.newImage("graphics/character/"..k.."/" .. (i-1) .. ".png"))
        end      
    end
end


function Player:update(dt, cam)
    local isMoving = false

    local vx = 0
    local vy = 0

    if love.keyboard.isDown("right") then
        vx = self.speed_move
        self.currentAnimation = "right"
        isMoving = true
    elseif love.keyboard.isDown("left") then
        vx = self.speed_move *-1
        self.currentAnimation = "left"
        isMoving = true
    elseif love.keyboard.isDown("up") then
        vy = self.speed_move * -1
        self.currentAnimation = "up"
        isMoving = true
    elseif love.keyboard.isDown("down") then
        vy = self.speed_move
        self.currentAnimation = "down"
        isMoving = true
    end

    self.collider:setLinearVelocity(vx, vy)

    if not isMoving then
        if self.currentAnimation == "right" then
            self.currentAnimation = "right_idle"
        elseif self.currentAnimation == "left" then
            self.currentAnimation = "left_idle"
        elseif self.currentAnimation == "up" then
            self.currentAnimation = "up_idle"
        elseif self.currentAnimation == "down" then
            self.currentAnimation = "down_idle"
        end
    end

    if love.keyboard.isDown("a") and not self.actionPressed then
        self.actionPressed = true
        local currentAction = self.currentAnimation:match("_(%a+)$")
        local currentDirection = self.currentAnimation:match("^(%a+)_")
        currentDirection = currentDirection or "down"
        local nextAction = nil

        if currentAction then
            local foundCurrent = false
            for actionName, _ in pairs(self.actions) do
                if foundCurrent then
                    nextAction = actionName
                    break
                end
                if actionName == currentAction then
                    foundCurrent = true
                end
            end
            if not nextAction then
                nextAction = next(self.actions)
            end
        else
            nextAction = next(self.actions)
        end

        self.currentAnimation = currentDirection .. "_" .. nextAction
        sound:playSound(self.actions[nextAction].sound)
    end

    if not love.keyboard.isDown("a") then
        self.actionPressed = false
    end

    self.currentFrame = self.currentFrame + self.speed_frame * dt
    if self.currentFrame >= (self.mouvements[self.currentAnimation].TotalFrames+1) then
        self.currentFrame = 1
    end

    cam:lookAt(self.x, self.y)

    local screenWidth, screenHeight = love.graphics.getDimensions()
    if cam.x < screenWidth/2 then
        cam.x = screenWidth/2
    end
    if cam.y < screenHeight/2 then
        cam.y = screenHeight/2
    end
    if cam.x > map.width * map.tilewidth - screenWidth/2 then
        cam.x = map.width * map.tilewidth - screenWidth/2
    end
    if cam.y > map.height * map.tileheight - screenHeight/2 then
        cam.y = map.height * map.tileheight - screenHeight/2
    end
end

function Player:draw()
    love.graphics.draw(self.mouvements[self.currentAnimation].steps[math.floor(self.currentFrame)], self.x, self.y, nil, self.zoom_x, self.zoom_y, self.tile.width/2, self.tile.height/2)
end

Player:init()

return Player