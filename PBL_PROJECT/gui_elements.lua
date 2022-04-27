Generate_buttons = Class{}

function Generate_buttons:init(x, y, width, height)
    self.width = width
    self.height = height
    self.x = x
    self.y = y
    self.simulate = false
end

function Generate_buttons:render(name, color)
    love.graphics.setColor(color[1], color[2], color[3])
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height, 10, 10)
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf(name, self.x, self.y + 10, self.width, "center")
end