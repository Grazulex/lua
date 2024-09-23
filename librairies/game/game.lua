local Cow = require "librairies.cow.cow"
local Chicken = require "librairies.chicken.chicken"

Game = {
    title = "Farmer & co",
    width = 800,
    height = 620,
    cows = {
        {
            color = "Green",
            action = "grass",
            x = 100,
            y = 100
        },
        {
            color = "Brown",
            action = "walk",
            x = 200,
            y = 100
        },
        {
            color = "Light",
            action = "love",
            x = 300,
            y = 100
        },
        {
            color = "Pink",
            action = "food",
            x = 400,
            y = 100
        },
        {
            color = "Purple",
            action = "swim",
            x = 500,
            y = 100
        },
    },
    chicken = {
        {
            color = "Green",
            action = "idle",
            x = 100,
            y = 200
        },
        {
            color = "Red",
            action = "walk",
            x = 200,
            y = 200
        },
        {
            color = "Brown",
            action = "jump",
            x = 300,
            y = 200
        },
        {
            color = "Yellow",
            action = "food",
            x = 400,
            y = 200
        },
        {
            color = "Blue",
            action = "love",
            x = 500,
            y = 200
        },
    }
}

NewCow = {}
NewChicken = {}

function Game:init()
    for i, cow in ipairs(self.cows) do
        NewCow[i] = Cow:new(nil)
        NewCow[i]:init(cow.color, cow.action, cow.x, cow.y)
    end
    for i, chicken in ipairs(self.chicken) do
        NewChicken[i] = Chicken:new(nil)
        NewChicken[i]:init(chicken.color, chicken.action, chicken.x, chicken.y)
    end
end

function Game:update(dt)
    for i, cow in ipairs(self.cows) do
        NewCow[i]:update(dt)
    end
    for i, chicken in ipairs(self.chicken) do
        NewChicken[i]:update(dt)
    end
end

function Game:draw()
    for i, cow in ipairs(self.cows) do
        NewCow[i]:draw()
    end
    for i, chicken in ipairs(self.chicken) do
        NewChicken[i]:draw()
    end
end

Game:init()

return Game