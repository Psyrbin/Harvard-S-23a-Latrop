StartState = Class{__includes = BaseState}

function StartState:update(dt)
    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        gStateMachine:change('play', 1)
    end
end

function StartState:render()
    love.graphics.setColor(95, 80, 10, 255)
    love.graphics.rectangle('fill', 0, 0, 400, 400)
    love.graphics.setColor(255, 255, 255, 255)

    love.graphics.printf('Use arrow keys or "a" and "d" to move, left and right click to create portals.', 50, 10, 300, 'center')

    love.graphics.printf('Get to this thing to complete the level:', 50, 40, 300, 'center')
    love.graphics.draw(gTextures['finish'], gFrames['finish'][1], 330, 46, 0, 1, 1, 0, 0, 0, 0)

    love.graphics.printf('Press "e" to pick up and throw boxes:', 50, 60, 300, 'center')
    love.graphics.draw(gTextures['box'], gFrames['box'][1], 330, 64, 0, 1, 1, 0, 0, 0, 0)

    love.graphics.printf('Press "q" to press buttons(one press permanently opens a door):', 50, 80, 300, 'center')
    love.graphics.draw(gTextures['button'], gFrames['button'][1], 330, 88, 0, 1, 1, 0, 0, 0, 0)


    love.graphics.printf('Stand or put box on the panel to activate it:', 50, 120, 300, 'center')
    love.graphics.draw(gTextures['panel'], gFrames['panel'][1], 350, 124, 0, 1, 1, 0, 0, 0, 0)


    love.graphics.printf('Portals can only be created on white tiles:', 50, 140, 300, 'center')
    love.graphics.draw(gTextures['tiles'], gFrames['tiles'][1], 350, 140, 0, 1, 1, 0, 0, 0, 0)

    love.graphics.printf('Press enter to begin', 150, 180, 100, 'center')
end
