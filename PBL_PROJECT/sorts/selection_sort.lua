SelectionSort = Class{__includes = BaseState}

require 'sorts.gui_state'

function SelectionSort:mousepressed(x, y)
    if x > self.generateRandomData.x and x < self.generateRandomData.x + self.generateRandomData.width and y > self.generateRandomData.y and y < self.generateRandomData.y + self.generateRandomData.height then
        self.unsortedData = generate_dataset(self.number)
        self.timer = 0
        self.current = 1
        self.index = 2
        self.time_elapsed = 0
        min_idx = self.current
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

function SelectionSort:init()
    self.number = 30
    self.time_elapsed = 0
    self.generateRandomData = createButton(100, WINDOW_HEIGHT - 80, 200, 50)
    self.sortButton = createButton(400, WINDOW_HEIGHT - 80, 100, 50)
    self.plusButton = createButton(600, WINDOW_HEIGHT - 70, 30, 30)
    self.minusButton = createButton(700, WINDOW_HEIGHT - 70, 30, 30)
    self.back_button = createButton(30, 30, 50, 50)
    math.randomseed(os.time())
    self.font10 = love.graphics.newFont(10)
    self.font25 = love.graphics.newFont(25)
end

function SelectionSort:update(dt)
    if self.should_sort then
        self.time_elapsed = self.time_elapsed + dt
    end
end

function SelectionSort:render()
    love.graphics.draw(white_bg, 0, 0, 0, WINDOW_WIDTH/white_bg:getWidth(), WINDOW_HEIGHT/white_bg:getHeight())
    if self.unsortedData ~= nil and self.should_sort then
        
        if self.index > #self.unsortedData then
            local temp = self.unsortedData[self.current]
            self.unsortedData[self.current] = self.unsortedData[min_idx]
            self.unsortedData[min_idx] = temp
            self.current = self.current + 1
            min_idx = self.current
            if self.current > #self.unsortedData - 1 then
                self.should_sort = false
                self.current = #self.unsortedData - 1
            end
            self.index = self.current + 1
        end
        if self.unsortedData[min_idx][1] > self.unsortedData[self.index][1] then
            min_idx = self.index
        end
        self.index = self.index + 1
    end



    if self.unsortedData ~= nil then
        love.graphics.setFont(self.font10)
        for i = 1, #self.unsortedData do
            if i == self.index or i == self.current then
                love.graphics.setColor(1, 1, 1)
            else
                love.graphics.setColor(self.unsortedData[i][2]/255, self.unsortedData[i][3]/255, self.unsortedData[i][4]/255)
            end
            love.graphics.rectangle("fill", (i - 1) * (WINDOW_WIDTH/#self.unsortedData), WINDOW_HEIGHT - self.unsortedData[i][1] - 100, (WINDOW_WIDTH/#self.unsortedData) - 10, self.unsortedData[i][1])
            love.graphics.setColor(0, 0, 0)
            love.graphics.printf(self.unsortedData[i][1], (i - 1) * (WINDOW_WIDTH/#self.unsortedData), WINDOW_HEIGHT - 100, (WINDOW_WIDTH/#self.unsortedData) - 10, "center")
        end
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.draw(backButton, self.back_button.x, self.back_button.y, 0, self.back_button.width/backButton:getWidth(), self.back_button.height/backButton:getHeight())
    love.graphics.setFont(self.font25)
    love.graphics.printf("time taken : ", 100, 10, 300, "center")
    love.graphics.printf(string.format("%.3f", self.time_elapsed).." ".."s", 175, 30, 300, "left")
    render_gui(self, "Selection Sort")
end
