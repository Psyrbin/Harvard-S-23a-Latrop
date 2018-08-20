EndState = Class{__includes = BaseState}

function EndState:render()
    love.graphics.printf('You completed all levels', 150, 100, 100, 'center')
end
