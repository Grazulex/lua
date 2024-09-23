local Cow = require "librairies.cow.cow"

Cow1 = Cow:Create("Brown", "walk")
Cow2 = Cow:Create("Green", "grass")


local game = {
    title = "Farmer & co",
    width = 800,
    height = 620,
    cows = 2,
    chicken = 5,
}

local function init()

end


function game:Update(dt)
    Cow1:Update(dt)
    Cow2:Update(dt)
end

function game:Draw()
    Cow1:Draw(100, 100)
    Cow2:Draw(200, 100)
end

init()

return game