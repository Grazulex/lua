local Cow = { } do
    local love = require("love")

    function Cow:init(color, animation, x, y)
        self.x = x
        self.y = y
        self.speed_frame = 3
        self.speed_move = 10
        self.zoom_x = 2
        self.zoom_y = 2
        self.tile = {
            width = 32,
            height = 32
        }
        self.currentFrame = 1
        self.direction = 2
        self.currentColor = color
        self.currentAnimation = animation
        self.spriteSheet = love.graphics.newImage("graphics/cow/"..color.."_cow_animations.png")
        self.mouvements = {
            idle = {
                TotalFrames = 3,
                line = 0,
                steps = {}
            },
            walk = {
                TotalFrames = 8,
                line = 1,
                steps = {}
            },
            jump = {
                TotalFrames = 7,
                line = 2,
                steps = {}
            },
            swim = {
                TotalFrames = 3,
                line = 3,
                steps = {}
            },
            sleep = {
                TotalFrames = 4,
                line = 4,
                steps = {}
            },
            food = {
                TotalFrames = 7,
                line = 5,
                steps = {}
            },
            grass = {
                TotalFrames = 4,
                line = 6,
                steps = {}
            },
            love = {
                TotalFrames = 6,
                line = 7,
                steps = {}
            },
        }
        for mouvement in pairs(self.mouvements) do
            for i=0,self.mouvements[mouvement].TotalFrames do
                table.insert(self.mouvements[mouvement].steps, love.graphics.newQuad(i*self.tile.width, self.mouvements[mouvement].line*self.tile.height, self.tile.width, self.tile.height, self.spriteSheet:getWidth(), self.spriteSheet:getHeight()))
            end
        end
    end

    function Cow:new(o)
        o = o or {}
        setmetatable(o, self)
        self.__index = self

        return o
    end

    function Cow:update(dt)
        -- Initialize or update the timer for direction change
        if not self.directionTimer then
            self.directionTimer = 0
        end
        if not self.animationTimer then
            self.animationTimer = 0
        end

        self.directionTimer = self.directionTimer + dt
        self.animationTimer = self.animationTimer + dt


        -- Change animation randomly
        if self.animationTimer >= 120 then    
            local animations = {"idle", "walk", "walk", "walk", "jump", "swim", "sleep", "food", "grass"}
            self.currentAnimation = animations[math.random(#animations)]
            self.animationTimer = 0
        end

        -- Move the cow based on the direction
        if self.currentAnimation == "walk" then
            -- Change direction if the timer exceeds 10 seconds
            if self.directionTimer >= 20 then
                local directions = {1, 2, 2, 3, 4, 4} -- More right (2) and left (4) than up (1) and down (3)
                self.direction = directions[math.random(#directions)]
                self.directionTimer = 0
            end
            
            if self.direction == 1 then
                self.y = self.y - self.speed_move * dt
            elseif self.direction == 2 then
                self.x = self.x + self.speed_move * dt
            elseif self.direction == 3 then
                self.y = self.y + self.speed_move * dt
            elseif self.direction == 4 then
                self.x = self.x - self.speed_move * dt
            end
        else
            self.x = self.x
            self.y = self.y
        end

        -- Check screen boundaries and change direction if necessary
        local screenWidth, screenHeight = love.graphics.getDimensions()
        if self.x < 0 then
            self.x = 0
            self.direction = 2 -- Change direction to right
        elseif self.x + self.tile.width * self.zoom_x > screenWidth then
            self.x = screenWidth - self.tile.width * self.zoom_x
            self.direction = 4 -- Change direction to left
        end

        if self.y < 0 then
            self.y = 0
            self.direction = 3 -- Change direction to down
        elseif self.y + self.tile.height * self.zoom_y > screenHeight then
            self.y = screenHeight - self.tile.height * self.zoom_y
            self.direction = 1 -- Change direction to up
        end

        -- Invert the animation if moving left
        if self.direction == 4 then
            self.zoom_x = -2
        else
            self.zoom_x = 2
        end



        self.currentFrame = self.currentFrame + self.speed_frame * dt
        if self.currentFrame >= (self.mouvements[self.currentAnimation].TotalFrames+1) then
            self.currentFrame = 1
        end
    end

    function Cow:draw()
        love.graphics.draw(self.spriteSheet, self.mouvements[self.currentAnimation].steps[math.floor(self.currentFrame)],self.x, self.y, 0, self.zoom_x, self.zoom_y)
    end

    return Cow
end