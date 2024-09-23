local Cow = {
    speed = 5,
    zoom_x = 2,
    zoom_y = 2,
    tile = {
        width = 32,
        height = 32
    },
    colors = {
        Brown = {
            spriteSheet = love.graphics.newImage("graphics/cow/Brown_cow_animations.png"),
            mouvements = {
                idle = {
                    TotalFrames = 3,
                    line = 1,
                    steps = {}
                },
                walk = {
                    TotalFrames = 8,
                    line = 2,
                    steps = {}
                },
                jump = {
                    TotalFrames = 7,
                    line = 3,
                    steps = {}
                },
                swim = {
                    TotalFrames = 3,
                    line = 4,
                    steps = {}
                },
                sleep = {
                    TotalFrames = 4,
                    line = 5,
                    steps = {}
                },
                food = {
                    TotalFrames = 7,
                    line = 6,
                    steps = {}
                },
                grass = {
                    TotalFrames = 4,
                    line = 7,
                    steps = {}
                },
                love = {
                    TotalFrames = 6,
                    line = 8,
                    steps = {}
                },
            },
        },
        Green = {
            spriteSheet = love.graphics.newImage("graphics/cow/Green_cow_animations.png"),
            mouvements = {
                idle = {
                    TotalFrames = 3,
                    line = 1,
                    steps = {}
                },
                walk = {
                    TotalFrames = 8,
                    line = 2,
                    steps = {}
                },
                jump = {
                    TotalFrames = 7,
                    line = 3,
                    steps = {}
                },
                swim = {
                    TotalFrames = 3,
                    line = 4,
                    steps = {}
                },
                sleep = {
                    TotalFrames = 4,
                    line = 5,
                    steps = {}
                },
                food = {
                    TotalFrames = 7,
                    line = 6,
                    steps = {}
                },
                grass = {
                    TotalFrames = 4,
                    line = 7,
                    steps = {}
                },
                love = {
                    TotalFrames = 6,
                    line = 8,
                    steps = {}
                },
            },
        },
        Light = {
            spriteSheet = love.graphics.newImage("graphics/cow/Light_cow_animations.png"),
            mouvements = {
                idle = {
                    TotalFrames = 3,
                    line = 1,
                    steps = {}
                },
                walk = {
                    TotalFrames = 8,
                    line = 2,
                    steps = {}
                },
                jump = {
                    TotalFrames = 7,
                    line = 3,
                    steps = {}
                },
                swim = {
                    TotalFrames = 3,
                    line = 4,
                    steps = {}
                },
                sleep = {
                    TotalFrames = 4,
                    line = 5,
                    steps = {}
                },
                food = {
                    TotalFrames = 7,
                    line = 6,
                    steps = {}
                },
                grass = {
                    TotalFrames = 4,
                    line = 7,
                    steps = {}
                },
                love = {
                    TotalFrames = 6,
                    line = 8,
                    steps = {}
                },
            },
        },
        Pink = {
            spriteSheet = love.graphics.newImage("graphics/cow/Pink_cow_animations.png"),
            mouvements = {
                idle = {
                    TotalFrames = 3,
                    line = 1,
                    steps = {}
                },
                walk = {
                    TotalFrames = 8,
                    line = 2,
                    steps = {}
                },
                jump = {
                    TotalFrames = 7,
                    line = 3,
                    steps = {}
                },
                swim = {
                    TotalFrames = 3,
                    line = 4,
                    steps = {}
                },
                sleep = {
                    TotalFrames = 4,
                    line = 5,
                    steps = {}
                },
                food = {
                    TotalFrames = 7,
                    line = 6,
                    steps = {}
                },
                grass = {
                    TotalFrames = 4,
                    line = 7,
                    steps = {}
                },
                love = {
                    TotalFrames = 6,
                    line = 8,
                    steps = {}
                },
            },
        },
        Purple = {
            spriteSheet = love.graphics.newImage("graphics/cow/Purple_cow_animations.png"),
            mouvements = {
                idle = {
                    TotalFrames = 3,
                    line = 1,
                    steps = {}
                },
                walk = {
                    TotalFrames = 8,
                    line = 2,
                    steps = {}
                },
                jump = {
                    TotalFrames = 7,
                    line = 3,
                    steps = {}
                },
                swim = {
                    TotalFrames = 3,
                    line = 4,
                    steps = {}
                },
                sleep = {
                    TotalFrames = 4,
                    line = 5,
                    steps = {}
                },
                food = {
                    TotalFrames = 7,
                    line = 6,
                    steps = {}
                },
                grass = {
                    TotalFrames = 4,
                    line = 7,
                    steps = {}
                },
                love = {
                    TotalFrames = 6,
                    line = 8,
                    steps = {}
                },
            },
        },
    },
    currentColor = "Brown",
    currentAnimation = "walk",
    currentFrame = 1,

}
Cow.__index = Cow

local function init()
    for color, v in pairs(Cow.colors) do
        for mouvement, value in pairs(Cow.colors[color].mouvements) do
            local line = Cow.colors[color].mouvements[mouvement].line - 1
            for i=0,Cow.colors[color].mouvements[mouvement].TotalFrames do
                table.insert(Cow.colors[color].mouvements[mouvement].steps, love.graphics.newQuad(i*Cow.tile.width, line*Cow.tile.height, Cow.tile.width, Cow.tile.height, Cow.colors[color].spriteSheet:getWidth(), Cow.colors[color].spriteSheet:getHeight()))
            end
        end
    end
end

function Cow:Create(color, animation)
    Cow.currentColor = color
    Cow.currentAnimation = animation

    local cow = setmetatable({}, Cow)
    
    return cow
end

function Cow:Update(dt)
    Cow.currentFrame = Cow.currentFrame + Cow.speed * dt
    if Cow.currentFrame >= (Cow.colors[Cow.currentColor].mouvements[Cow.currentAnimation].TotalFrames+1) then
        Cow.currentFrame = 1
    end
end

function Cow:Draw(x, y)
    love.graphics.draw(Cow.colors[Cow.currentColor].spriteSheet, Cow.colors[Cow.currentColor].mouvements[Cow.currentAnimation].steps[math.floor(Cow.currentFrame)],x, y, 0, Cow.zoom_x, Cow.zoom_y)
end

init()

return Cow