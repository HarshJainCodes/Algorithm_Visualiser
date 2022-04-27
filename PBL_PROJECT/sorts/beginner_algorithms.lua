BeginnerAlgorithms = Class{__includes = BaseState}

require 'States.sorts.gui_state'

function BeginnerAlgorithms:mouse_pressed(x, y)
    if x > self.bubbleSort_button.x and x < self.bubbleSort_button.x + self.bubbleSort_button.width and y > self.bubbleSort_button.y and y < self.bubbleSort_button.y + self.bubbleSort_button.height then
        gStateMachine:change('bubbleSort')
    elseif x > self.insertionSort_button.x and x < self.insertionSort_button.x + self.insertionSort_button.width and y > self.insertionSort_button.y and y < self.insertionSort_button.y + self.insertionSort_button.height then
        gStateMachine:change('insertionSort')
    elseif x > self.selectionSort_button.x and x < self.selectionSort_button.x + self.selectionSort_button.width and y > self.selectionSort_button.y and y < self.selectionSort_button.y + self.selectionSort_button.height then
        gStateMachine:change('selectionSort')
    elseif x > self.mergeSort_button.x and x < self.mergeSort_button.x + self.mergeSort_button.width and y > self.mergeSort_button.y and y < self.mergeSort_button.y + self.mergeSort_button.height then
        gStateMachine:change('countingSort')
    end
end

function BeginnerAlgorithms:init()
    self.bubbleSort_button = createButton(50, 100, 200, 50)
    self.insertionSort_button = createButton(300, 100, 200, 50)
    self.selectionSort_button = createButton(550, 100, 200, 50)
    self.mergeSort_button = createButton(800, 100, 200, 50)
end

function BeginnerAlgorithms:update(dt)
    
end

function BeginnerAlgorithms:render()
    love.graphics.setFont(love.graphics.newFont(30))
    love.graphics.printf("select your algorithm", 0, 30, WINDOW_WIDTH, "center")

    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.rectangle("line", self.bubbleSort_button.x, self.bubbleSort_button.y, self.bubbleSort_button.width, self.bubbleSort_button.height)
    love.graphics.printf("bubble sort", self.bubbleSort_button.x, self.bubbleSort_button.y, self.bubbleSort_button.width, "center")
    love.graphics.rectangle("line", self.insertionSort_button.x, self.insertionSort_button.y, self.insertionSort_button.width, self.insertionSort_button.height)
    love.graphics.printf("insertion sort", self.insertionSort_button.x, self.insertionSort_button.y, self.insertionSort_button.width, "center")

    love.graphics.rectangle("line", self.selectionSort_button.x, self.selectionSort_button.y, self.selectionSort_button.width, self.selectionSort_button.height)
    love.graphics.printf("selection sort", self.selectionSort_button.x, self.selectionSort_button.y, self.selectionSort_button.width, "center")

    love.graphics.rectangle("line", self.mergeSort_button.x, self.mergeSort_button.y, self.mergeSort_button.width, self.mergeSort_button.height)
    love.graphics.printf("counting sort", self.mergeSort_button.x, self.mergeSort_button.y, self.mergeSort_button.width, "center")
end