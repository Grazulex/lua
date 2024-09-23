local love = require("love")
local Music = require "librairies.music.music"

local sound = Music

Player = {
    x = 180,
    y = 380,
    speed_frame = 4,
    speed_move = 2,
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

function Player:init()

    for k, v in pairs(self.mouvements) do
        for i = 1, self.mouvements[k].TotalFrames do
            table.insert(self.mouvements[k].steps, love.graphics.newImage("graphics/character/"..k.."/" .. (i-1) .. ".png"))
        end      
    end
end


function Player:update(dt)
    local isMoving = false

    if love.keyboard.isDown("right") then
        self.x = self.x + self.speed_move
        self.currentAnimation = "right"
        isMoving = true
    elseif love.keyboard.isDown("left") then
        self.x = self.x - self.speed_move
        self.currentAnimation = "left"
        isMoving = true
    elseif love.keyboard.isDown("up") then
        self.y = self.y - self.speed_move
        self.currentAnimation = "up"
        isMoving = true
    elseif love.keyboard.isDown("down") then
        self.y = self.y + self.speed_move
        self.currentAnimation = "down"
        isMoving = true
    end

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
end

function Player:draw()
    love.graphics.draw(self.mouvements[self.currentAnimation].steps[math.floor(self.currentFrame)], self.x, self.y, nil, self.zoom_x, self.zoom_y)
end

Player:init()

return Player