InsertionSort = Class{__includes = BaseState}

require 'sorts.gui_state'

function InsertionSort:mousepressed(x, y)
    if x > self.generateRandomData.x and x < self.generateRandomData.x + self.generateRandomData.width and y > self.generateRandomData.y and y < self.generateRandomData.y + self.generateRandomData.height then
        self.unsortedData = generate_dataset(self.number)
        self.timer = 0
        self.time_elapsed = 0
        self.current = 1
        self.index = 1
        self.stop = false
        self.should_sort = false
    elseif x > self.sortButton.x and x < self.sortButton.x + self.sortButton.width and y > self.sortButton.y and y < self.sortButton.y + self.sortButton.height then
        self.should_sort = true
    elseif x > self.plusButton.x and x < self.plusButton.x + self.plusButton.width and y > self.plusButton.y and y < self.plusButton.y + self.plusButton.height then
        self.number = self.number + 1
    elseif x > self.minusButton.x and x < self.minusButton.x + self.minusButton.width and y > self.minusButton.y and y < self.minusButton.y + self.minusButton.height then
        self.number = math.max(2, self.number - 1)
    elseif x > self.back_button.x and x < self.back_button.x + self.back_button.width and y > self.back_button.y and y < self.back_button.y + self.back_button.height then
        gStateMachine:change('simulate')
    end
end

function InsertionSort:init()
    self.number = 30
    self.stop = false
    self.current = 2
    self.index = 1
    self.timer = 0
    self.should_sort = false
    self.time_elapsed = 0
    self.generateRandomData = createButton(100, WINDOW_HEIGHT - 80, 200, 50)
    self.sortButton = createButton(400, WINDOW_HEIGHT - 80, 100, 50)
    self.plusButton = createButton(600, WINDOW_HEIGHT - 70, 30, 30)
    self.minusButton = createButton(700, WINDOW_HEIGHT - 70, 30, 30)
    self.back_button = createButton(30, 30, 50, 50)
end

function InsertionSort:update(dt)
    self.timer = self.timer + dt
    if self.should_sort then
        self.time_elapsed = self.time_elapsed + dt
    end
end

function InsertionSort:render()
    love.graphics.draw(white_bg, 0, 0, 0, WINDOW_WIDTH/white_bg:getWidth(), WINDOW_HEIGHT/white_bg:getHeight())

    -- if self.timer > 0.5 then
        if self.unsortedData ~= nil and self.should_sort then
            if self.current > #self.unsortedData then
                self.current = #self.unsortedData
                self.should_sort = false
            end
    
            key = self.unsortedData[self.current]
            if self.index >= 1 and key[1] < self.unsortedData[self.index][1] then
                self.unsortedData[self.index + 1] = self.unsortedData[self.index]
                self.index = self.index - 1
            else
                self.unsortedData[self.index + 1] = key
                self.index = self.current - 1
                self.current = self.current + 1
                
            end
        end
    --     self.timer = 0
    -- end
    


    if self.unsortedData ~= nil then
        love.graphics.push()
        love.graphics.translate(0, WINDOW_HEIGHT - 100)
        love.graphics.scale(1, -1)
        love.graphics.setFont(love.graphics.newFont(10))
        for i = 1, #self.unsortedData do
            -- if i == self.index then
            --     love.graphics.setColor(1, 0, 0)
            -- else
            --     love.graphics.setColor(1, 1, 1)
            -- end
            love.graphics.setColor(self.unsortedData[i][2]/255, self.unsortedData[i][3]/255, self.unsortedData[i][4]/255)
            love.graphics.rectangle("fill", (i - 1) * (WINDOW_WIDTH/#self.unsortedData), 0, (WINDOW_WIDTH/#self.unsortedData) - 10, self.unsortedData[i][1])
            love.graphics.push()
            love.graphics.scale(1, -1)
            love.graphics.setColor(0, 0, 0)
            love.graphics.printf(self.unsortedData[i][1], (i - 1) * (WINDOW_WIDTH/#self.unsortedData), 0, (WINDOW_WIDTH/#self.unsortedData) - 10, "center")
            love.graphics.pop()
        end
        love.graphics.pop()
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(backButton, self.back_button.x, self.back_button.y, 0, self.back_button.width/backButton:getWidth(), self.back_button.height/backButton:getHeight())
    love.graphics.setFont(love.graphics.newFont(25))
    love.graphics.printf("time taken : ", 100, 10, 300, "center")
    love.graphics.printf(string.format("%.3f", self.time_elapsed).." ".."s", 175, 30, 300, "left")
    render_gui(self, "Insertion Sort")
end