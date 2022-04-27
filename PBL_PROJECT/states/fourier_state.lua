FourierSeries = Class{__includes = BaseState}

function FourierSeries:init()
    self.time = 0
    self.yvalues = {}
    self.home_button = Generate_buttons(WINDOW_WIDTH - 100, 100, 100, 50)
    self.mousex = 0
    self.mousey = 0
    self.n_inc_button = Generate_buttons(WINDOW_WIDTH - 100, 200, 100, 50)
    self.n_dec_button = Generate_buttons(WINDOW_WIDTH - 100, 300, 100, 50)
    self.n_value = 0
end

function FourierSeries:update(dt)
    

 
end

function FourierSeries:mousepressed(x, y)
    self.mousex = x
    self.mousey = y
    if x > self.home_button.x and x < self.home_button.x + self.home_button.width and y > self.home_button.y and y < self.home_button.y + self.home_button.height then
        gStateMachine:change("simulate")
    end

    if x > self.n_inc_button.x and x < self.n_inc_button.x + self.n_inc_button.width and y > self.n_inc_button.y and y < self.n_inc_button.y + self.n_inc_button.height then
        self.n_value = self.n_value + 1
        self.yvalues = {}
    end

    if x > self.n_dec_button.x and x < self.n_dec_button.x + self.n_dec_button.width and y > self.n_dec_button.y and y < self.n_dec_button.y + self.n_dec_button.height then
        self.n_value = math.max(0, self.n_value - 1)
        self.yvalues = {}
    end
end

function FourierSeries:render()
    love.graphics.draw(bg_blue, 0, 0, 0, WINDOW_WIDTH/bg_blue:getWidth(), WINDOW_HEIGHT/bg_blue:getHeight())

    love.graphics.push()
    love.graphics.translate(WINDOW_WIDTH/2 - 100, WINDOW_HEIGHT/2)



    x = 0
    y = 0


    for i = 0, self.n_value do
        n = 2 * i + 1

        radius = 150 * (4 / (n * math.pi))

        prevx = x
        prevy = y
        x = x + radius * math.cos(n  * self.time)
        y = y + radius * math.sin(n * self.time)

        --table.insert(self.yvalues, y)     -- very interesting thing happens if you execute this

        love.graphics.setColor(1, 1, 1, 0.9)
        love.graphics.circle("line", prevx - 100, prevy, radius)
        love.graphics.setColor(1, 1, 1)

        love.graphics.line(prevx - 100, prevy, x - 100, y)

        --love.graphics.circle("fill", x, y, 6)

        --love.graphics.line(x, y, WINDOW_WIDTH/4, self.yvalues[#self.yvalues])


    end
    table.insert(self.yvalues, y)
    love.graphics.line(x - 100, y, WINDOW_WIDTH/4, self.yvalues[#self.yvalues])

    love.graphics.translate(WINDOW_WIDTH/4, 0)

    c = 1
    for i = #self.yvalues, 2, -1 do
        -- love.graphics.points(c/2, self.yvalues[i])
        love.graphics.line(c/2, self.yvalues[i], c/2, self.yvalues[i - 1])
        c = c + 1
    end

    self.time = self.time + 0.016
    if #self.yvalues> WINDOW_WIDTH/2 then
        table.remove(self.yvalues, 1)
    end

    love.graphics.line(WINDOW_WIDTH/2 - 249, -WINDOW_HEIGHT/2, WINDOW_WIDTH/2 - 249, WINDOW_HEIGHT/2)

    

    -- love.graphics.print(self.mousex, 0)
    -- love.graphics.print(self.mousey, 100)
    love.graphics.pop()

    love.graphics.printf("the value of n currently is "..(self.n_value + 1), 0, 70, WINDOW_WIDTH - 100, "center")

    self.home_button:render("home", {1, 1, 1})
    self.n_inc_button:render("n + 1", {1, 1, 1})
    self.n_dec_button:render("n - 1", {1, 1, 1})
end