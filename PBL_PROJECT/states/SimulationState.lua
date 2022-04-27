SimulationState = Class{__includes = BaseState}

function SimulationState:enter()
    
end


function SimulationState:init()
    sin_wave_button = Generate_buttons(WINDOW_WIDTH/4 - 50, WINDOW_HEIGHT - 80, 100, 50)
    cos_wave_button = Generate_buttons(WINDOW_WIDTH/2 - 50, WINDOW_HEIGHT - 80, 100, 50)
    tan_wave_button = Generate_buttons(3 * WINDOW_WIDTH/4 - 50, WINDOW_HEIGHT - 80, 100, 50)
    fourier_button = Generate_buttons(WINDOW_WIDTH - 100, WINDOW_HEIGHT/4 - 50, 100, 50)
    bubble_button = Generate_buttons(WINDOW_WIDTH - 100, WINDOW_HEIGHT/4 + 50, 100, 50)
    insertion_button = Generate_buttons(WINDOW_WIDTH - 100, WINDOW_HEIGHT/4 + 150, 100, 50)
    selection_button = Generate_buttons(WINDOW_WIDTH - 100, WINDOW_HEIGHT/4 + 250, 100, 50)

    sin_wave = {}
    sin_x = 0
    sin_amplitude = 50

    cos_wave = {}
    cos_x = 0
    cos_amplitude = 50

    tan_wave = {}
    tan_x = 0
    tan_amplitude = 50 -- tan dosnt require this as it dosnt require scaling

    self.font15 = love.graphics.newFont(15)
    self.font20 = love.graphics.newFont(20)
end


function SimulationState:mousepressed(x, y)
    if x > sin_wave_button.x and x < sin_wave_button.x + sin_wave_button.width and y > sin_wave_button.y and y < sin_wave_button.y + sin_wave_button.height then
        sin_wave_button.simulate = true
    end
    if x > cos_wave_button.x and x < cos_wave_button.x + cos_wave_button.width and y > cos_wave_button.y and y < cos_wave_button.y + cos_wave_button.height then
        cos_wave_button.simulate = true
    end
    if x > tan_wave_button.x and x < tan_wave_button.x + tan_wave_button.width and y > tan_wave_button.y and y < tan_wave_button.y + tan_wave_button.height then
        tan_wave_button.simulate = true
    end
    if x > fourier_button.x and x < fourier_button.x + fourier_button.width and y > fourier_button.y and y < fourier_button.y + fourier_button.height then
        fourier_button.simulate = true
    end
    if x > bubble_button.x and x < bubble_button.x + bubble_button.width and y > bubble_button.y and y < bubble_button.y + bubble_button.height then
        bubble_button.simulate = true
    end
    if x > insertion_button.x and x < insertion_button.x + insertion_button.width and y > insertion_button.y and y < insertion_button.y + insertion_button.height then
        insertion_button.simulate = true
    end
    if x > selection_button.x and x < selection_button.x + selection_button.width and y > selection_button.y and y < selection_button.y + selection_button.height then
        selection_button.simulate = true
    end
end

function SimulationState:update_wave(wave, wave_x, amplitude, func, increment, dt)
    --table.insert(wave, {0, amplitude * func(wave_x)})
    local value = amplitude * func(wave_x)
    if value > WINDOW_HEIGHT/2 then
        value = WINDOW_HEIGHT/2
    end
    if value < -WINDOW_HEIGHT/2 + 50 then
        value = -WINDOW_HEIGHT/2 + 50
    end

    table.insert(wave, {0, value})
    for key, value in pairs(wave) do
        value[1] = value[1] - 60 * dt
    end
end

function SimulationState:render_wave(wave, color)
    love.graphics.push()
    love.graphics.setColor(color[1], color[2], color[3])
    love.graphics.line(0, WINDOW_HEIGHT/2 - 50, WINDOW_WIDTH - 100, WINDOW_HEIGHT/2 - 50)
    love.graphics.translate(WINDOW_WIDTH/2 - 50, WINDOW_HEIGHT/2 - 50)
    love.graphics.scale(1, -1)  -- to make the coordinates like normal cartesian plane
    if #wave > 1 then
        for index = 1, #wave - 1 do
            love.graphics.line(wave[index][1], wave[index][2], wave[index + 1][1], wave[index + 1][2])
        end
    end
    love.graphics.setColor(1, 1, 1)
    love.graphics.pop()
end

function SimulationState:update(dt)
    if sin_wave_button.simulate then
        SimulationState:update_wave(sin_wave, sin_x, sin_amplitude, math.sin, 2, dt)
        sin_x = sin_x + 2 * dt
    end
    if cos_wave_button.simulate then
        SimulationState:update_wave(cos_wave, cos_x, cos_amplitude, math.cos, 2, dt)
        cos_x = cos_x + 2 * dt
    end
    if tan_wave_button.simulate then
        SimulationState:update_wave(tan_wave, tan_x, tan_amplitude, math.tan, 1, dt)
        tan_x = tan_x + 1 * dt
    end
end

function SimulationState:render()
    love.graphics.draw(bg_blue, 0, 0, 0, WINDOW_WIDTH/bg_blue:getWidth(), WINDOW_HEIGHT/bg_blue:getHeight())
    love.graphics.line(0, WINDOW_HEIGHT - 100, WINDOW_WIDTH, WINDOW_HEIGHT - 100)
    love.graphics.line(WINDOW_WIDTH - 100, 0, WINDOW_WIDTH - 100, WINDOW_HEIGHT)

    sin_wave_button:render("sin wave", {1, 1, 0})
    cos_wave_button:render("cos wave", {1, 0, 0})
    tan_wave_button:render("tan wave", {0, 0, 1})
    fourier_button:render("fourier", {1, 1, 1})
    

    love.graphics.setFont(self.font15)
    insertion_button:render("insertion sort", {1, 1 , 1})
    bubble_button:render('bubble sort', {1, 1, 1})
    selection_button:render('selection sort',{1, 1, 1})
    love.graphics.setFont(self.font20)

    if sin_wave_button.simulate then
        SimulationState:render_wave(sin_wave, {1, 1, 0})
    end
    if cos_wave_button.simulate then
        SimulationState:render_wave(cos_wave, {1, 0, 0})
    end
    if tan_wave_button.simulate then
        SimulationState:render_wave(tan_wave, {0, 0, 1})
    end
    if fourier_button.simulate then
        gStateMachine:change('fourier')
    end
    if bubble_button.simulate then
        gStateMachine:change('bubbleSort')
    end
    if insertion_button.simulate then
        gStateMachine:change('insertionSort')
    end
    if selection_button.simulate then
        gStateMachine:change('selectionSort')
    end
end