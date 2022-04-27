WINDOW_WIDTH = 1000
WINDOW_HEIGHT = 600

push = require 'push'
Class = require 'class'
require 'StateMachine'
require 'gui_elements'
require 'states/BaseState'
require 'states/TitleState'
require 'states/SimulationState'
require 'states/fourier_state'
require 'sorts/bubble_sort'
require 'sorts/insertion_sort'
require 'sorts/selection_sort'


function love.load()
    push:setupScreen(WINDOW_WIDTH, WINDOW_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = true,
        resizable = true,
        vsync = true,
        highdpi = true,
        stretched = true
    })

    gStateMachine = StateMachine{
        ['title'] = function () return TitleScreenState() end,
        ['simulate'] = function () return SimulationState() end,
        ['fourier'] = function () return FourierSeries() end,
        ['bubbleSort'] = function () return BubbleSort() end,
        ['insertionSort'] = function () return InsertionSort() end,
        ['selectionSort'] = function () return SelectionSort() end,
    }
    gStateMachine:change('title')

    backButton = love.graphics.newImage('assets/back_button.png')
    white_bg = love.graphics.newImage('assets/white_bg.jpg')
    background = love.graphics.newImage('assets/bg_image.png')
    bg_blue = love.graphics.newImage('assets/bg_blue.png')
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    gStateMachine.current:keypressed(key)
end

function love.mousepressed(x1, y1)
    x, y = push:toGame(x1, y1)
    gStateMachine.current:mousepressed(x, y)
end

function love.update(dt)
    gStateMachine:update(dt)
end

function love.draw()
    --love.graphics.print(gStateMachine.current)
    push:start()
    gStateMachine:render()
    -- love.graphics.print(love.timer.getFPS())

    push:finish()
end