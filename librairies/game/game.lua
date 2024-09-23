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
            x = 300,
            y = 300
        },
        {
            color = "Pink",
            action = "food",
            x = 300,
            y = 400
        },
    },
    chicken = {
        {
            color = "Green",
            action = "walk",
            x = 2900,
            y = 300
        },
        {
            color = "Blue",
            action = "look",
            x = 2900,
            y = 400
        },
        {
            color = "Red",
            action = "food",
            x = 2900,
            y = 500
        },
        {
            color = "Yellow",
            action = "love",
            x = 2900,
            y = 600
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

function Game:update(dt, map)
    for i, cow in ipairs(self.cows) do
        NewCow[i]:update(dt, map)
    end
    for i, chicken in ipairs(self.chicken) do
        NewChicken[i]:update(dt, map)
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