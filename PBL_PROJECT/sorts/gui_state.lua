createButton = Class{}

local font20 = love.graphics.newFont(20)
local font30 = love.graphics.newFont(30)

function createButton:init(x, y, width, height)
    self.width = width
    self.height = height
    self.x = x
    self.y = y
    
end

function generate_dataset(number)
    local t = {}
    for x = 1, number do
        table.insert(t, {math.random(1, 450), math.random(0, 255), math.random(0, 255), math.random(0, 255)})
    end
    -- start = 200
    -- for x = 1, number do
    --     table.insert(t, {start, math.random(0, 255), math.random(0, 255),math.random(0, 255)})
    --     start = start + 1
    -- end
    return t
end

function render_gui(self, name)

    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(font30)
    love.graphics.printf(name, 0, 30, WINDOW_WIDTH, "center")
    love.graphics.rectangle("line", self.generateRandomData.x, self.generateRandomData.y, self.generateRandomData.width, self.generateRandomData.height)
    
    love.graphics.setFont(font20)
    love.graphics.printf("generate random data", self.generateRandomData.x, self.generateRandomData.y, self.generateRandomData.width, "center")


    love.graphics.rectangle("line", self.sortButton.x, self.sortButton.y, self.sortButton.width, self.sortButton.height)
    love.graphics.printf("sort", self.sortButton.x, self.sortButton.y + 10, self.sortButton.width, "center")
    love.graphics.rectangle("line", self.plusButton.x, self.plusButton.y, self.plusButton.width, self.plusButton.height)
    love.graphics.printf("+", self.plusButton.x, self.plusButton.y, self.plusButton.width, "center")

    love.graphics.printf(self.number, 630, WINDOW_HEIGHT - 70, 70, "center")

    love.graphics.rectangle("line", self.minusButton.x, self.minusButton.y, self.minusButton.width, self.minusButton.height)
    love.graphics.printf("-", self.minusButton.x, self.minusButton.y, self.minusButton.width, "center")
end