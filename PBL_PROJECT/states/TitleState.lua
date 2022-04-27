TitleScreenState = Class{__includes = BaseState}

local simulate_button = {}
simulate_button.width = 100
simulate_button.height = 50
simulate_button.x = WINDOW_WIDTH - simulate_button.width/2 - 150
simulate_button.y = WINDOW_HEIGHT - simulate_button.height/2 - 100


function TitleScreenState:init()
    self.font20 = love.graphics.newFont(20)
end

function TitleScreenState:enter()
    
end

function TitleScreenState:mousepressed(x, y)
    if x > simulate_button.x and x < simulate_button.x + simulate_button.width and y > simulate_button.y and simulate_button.y + simulate_button.height then
        gStateMachine:change('simulate')
    end
    
end

function TitleScreenState:update(dt)
    
end

function TitleScreenState:render()
    love.graphics.draw(background, 0, 0, 0, WINDOW_WIDTH/background:getWidth(), WINDOW_HEIGHT/background:getHeight())
    love.graphics.setFont(self.font20)
    love.graphics.rectangle("line", simulate_button.x, simulate_button.y, simulate_button.width, simulate_button.height, 10, 10)
    love.graphics.printf("simulate", simulate_button.x, simulate_button.y + 10, simulate_button.width, "center")
end